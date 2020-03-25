#!/bin/bash
# PURPOSE - Build and test 'name' code using dmalloc
# PARAMETERS
#   name - The name of the tests to run (e.g., good, bad)
#   start - Lowest numbered filename
#   stop - Highest numbered filename
# USAGE: test_all_dmalloc.sh [type] [start] [stop]
# EXAMPLE: test_all_dmalloc.sh good 1 3  # Runs dmalloc on good_code{1-3}_dmalloc.bin
# NOTES:
#   Executes in the following order:
#       - make all_[name]
#       - eval `dmalloc -b -l devops/logs/[name]_code{1-3}_dmalloc all`
#       - dist/[name]_code{1-3}_dmalloc.bin
#       - /usr/share/doc/libdmalloc-dev/examples/contrib/dmalloc_summarize.pl < devops/logs/[name]_code{1-3}_dmalloc
#   Validates all input

PARAM_NAME=$1
PARAM_START=$2
PARAM_STOP=$3

DIST_DIRECTORY="dist/"
DMALLOC_LOG_DIRECTORY="devops/logs/"
FILE_PREFIX=$PARAM_NAME"_code"
TOOL_SUFFIX="_dmalloc"
FILE_EXT=".bin"
SUCCESS_PREFIX="Success: "  # Use this when the test results are favorable
FAILURE_PREFIX="FAILURE! "  # Use this when some aspect of the shell script errors
ERRORS_PREFIX="ERRORS! "    # Use this when the test results are not favorable
DMALLOC_SUMMARIZE_PATH="/usr/share/doc/libdmalloc-dev/examples/contrib/"
DMALLOC_SUMMARIZE_FILE="dmalloc_summarize.pl"
DMALLOC_SUMMARIZE_ABS_PATH=$DMALLOC_SUMMARIZE_PATH$DMALLOC_SUMMARIZE_FILE
DMALLOC_FAILURE=0           # Indicates Dmalloc found an error

# Purpose - Tests parameter 1 for length 0
# Return - 1 if empty, 0 if not
validate_input_not_empty()
{
    if [ ${#1} -gt 0 ]
    then
        return 0
    else
        return 1
    fi
}

# INPUT VALIDATION
# PARAM_NAME
validate_input_not_empty $PARAM_NAME
if [ $? -ne 0 ]
then
    echo -e "\n"$FAILURE_PREFIX" The 'name' parameter is invalid\n"
    exit 1
fi
# PARAM_START
validate_input_not_empty $PARAM_START
if [ $? -ne 0 ]
then
    echo -e "\n"FAILURE_PREFIX" The 'start' parameter is invalid\n"
    exit 1
fi
# PARAM_STOP
validate_input_not_empty $PARAM_STOP
if [ $? -ne 0 ]
then
    echo -e "\n"$FAILURE_PREFIX" The 'stop' parameter is invalid\n"
    exit 1
fi
# Range
if [ $PARAM_START -gt $PARAM_STOP ]
then
    echo -e "\n"$FAILURE_PREFIX" The 'start' can not be greater than the 'stop'\n"
    exit 1
fi
# dmalloc_summarize.pl
test -f $DMALLOC_SUMMARIZE_ABS_PATH
if [ $? -ne 0 ]
then
    echo -e "\n"$FAILURE_PREFIX" Failed to find"$DMALLOC_SUMMARIZE_FILE
    echo "Attempt to find it with the following command:"
    echo -e "   find / -iname "$DMALLOC_SUMMARIZE_FILE"\n"
    exit 1
fi

# CHANGE DIRECTORY
cd "$(dirname "$0")"  # Change directory with respect to this script
cd ../..  # Change directory to the project's top level

# BUILD
make --quiet all_$PARAM_NAME > /dev/null 2>&1
if [ $? -ne 0 ]
then
    echo -e "\n"$FAILURE_PREFIX" Makefile recipe has failed"
    echo "Replicate these results with the following command:"
    echo -e "make all_"$PARAM_NAME"\n"
    exit 1
fi 

# TEST
for (( i=$PARAM_START; i<=$PARAM_STOP; i++ ))
do
    DMALLOC_FAILURE=0  # Reset temp variable
    TEMP_BIN_FILENAME=$FILE_PREFIX$i$TOOL_SUFFIX$FILE_EXT
    TEMP_BIN_REL_FILENAME=$DIST_DIRECTORY$TEMP_BIN_FILENAME
    # Verify binary file exists
    test -f $TEMP_BIN_REL_FILENAME
    if [ $? -ne 0 ]
    then
        echo -e "\n"$FAILURE_PREFIX $TEMP_BIN_FILENAME" does not exist\n"
        exit 1
    fi

    # Verify log is removed, thereby guaranteeing a clean slate
    TEMP_DMALLOC_LOG_FILENAME=$FILE_PREFIX$i$TOOL_SUFFIX
    TEMP_DMALLOC_REL_LOG_FILENAME=$DMALLOC_LOG_DIRECTORY$TEMP_DMALLOC_LOG_FILENAME
    test -f $TEMP_DMALLOC_REL_LOG_FILENAME
    if [ $? -eq 0 ]
    then
        rm -f $TEMP_DMALLOC_REL_LOG_FILENAME
        if [ $? -ne 0 ]
        then
            echo -e "\n"$FAILURE_PREFIX" Failed to delete"$TEMP_DMALLOC_REL_LOG_FILENAME
        fi
    fi

    # Set the environment variable
    eval `dmalloc -b -l $TEMP_DMALLOC_REL_LOG_FILENAME all`
    if [ $? -ne 0 ]
    then
        echo -e "\n"$FAILURE_PREFIX" Failed to set DMALLOC_OPTIONS environment variable\n"
        exit 1
    fi

    # Execute the binary
    $TEMP_BIN_REL_FILENAME > /dev/null 2>&1

    # Verify dmalloc log was created
    test -f $TEMP_DMALLOC_REL_LOG_FILENAME
    if [ $? -ne 0 ]
    then
        echo -e $FAILURE_PREFIX" Failed to find "$TEMP_DMALLOC_REL_LOG_FILENAME
        echo -e "Did you neglect to compile your code with the MIMO Wrappers?\n"
    else
        # Execute dmalloc_summarize.pl
        $DMALLOC_SUMMARIZE_ABS_PATH < $TEMP_DMALLOC_REL_LOG_FILENAME > /dev/null 2>&1
        if [ $? -ne 0 ]
        then
            echo -e "\n"$ERRORS_PREFIX $DMALLOC_SUMMARIZE_FILE" has failed" >&2
            echo "Replicate these results with the following command:"
            echo -e $DMALLOC_SUMMARIZE_ABS_PATH" < "$TEMP_DMALLOC_REL_LOG_FILENAME"\n" >&2
        else
            # Test dmalloc_summarize.pl output
            $DMALLOC_SUMMARIZE_ABS_PATH < $TEMP_DMALLOC_REL_LOG_FILENAME | grep /src/ > /dev/null 2>&1
            if [ $? -eq 0 ]
            then
                DMALLOC_FAILURE=1
            fi
            # Test dmalloc log file
            grep ERROR $TEMP_DMALLOC_REL_LOG_FILENAME
            if [ $? -eq 0 ]
            then
                DMALLOC_FAILURE=1
            fi
        fi
    fi

    # Did Dmalloc find any errors?
    if [ $DMALLOC_FAILURE -eq 0 ]
    then
        echo $SUCCESS_PREFIX"Dmalloc has found 0 errors in "$TEMP_BIN_REL_FILENAME
    else
        echo -e "\n"$ERRORS_PREFIX" Dmalloc has found an error with "$TEMP_BIN_REL_FILENAME >&2
        echo "Replicate these results with the following commands:"
        echo $DMALLOC_SUMMARIZE_ABS_PATH" < "$TEMP_DMALLOC_REL_LOG_FILENAME >&2
        echo -e "grep ERROR "$TEMP_DMALLOC_REL_LOG_FILENAME"\n" >&2
    fi
done

exit 0
