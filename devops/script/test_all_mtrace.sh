#!/bin/bash
# PURPOSE - Build and test 'name' code using mtrace
# PARAMETERS
#   name - The name of the tests to run (e.g., good, bad)
#   start - Lowest numbered filename
#   stop - Highest numbered filename
# USAGE: test_all_mtrace.sh [type] [start] [stop]
# EXAMPLE: test_all_mtrace.sh good 1 3  # Runs mtrace on good_code{1-3}_mtrace.bin
# NOTES:
#   Executes in the following order:
#       make all_[name]; dist/[name]_code{1-3}_mtrace.bin; mtrace dist/[name]_code{1-3}_mtrace.bin devops/logs/[name]_code{1-3}_mtrace
#   Executes mtrace with:
#       mtrace dist/[name]_code{start-stop}.bin devops/logs/[name]_code{1-3}_mtrace 2>&1 /dev/null
#   Validates all input

PARAM_NAME=$1
PARAM_START=$2
PARAM_STOP=$3

DIST_DIRECTORY="dist/"
MTRACE_LOG_DIRECTORY="devops/logs/"
FILE_PREFIX=$PARAM_NAME"_code"
TOOL_SUFFIX="_mtrace"
FILE_EXT=".bin"
SUCCESS_PREFIX="Success: "
FAILURE_PREFIX="FAILURE! "
ERRORS_PREFIX="ERRORS! "

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
    echo -e "\n"$FAILURE_PREFIX"The 'name' parameter is invalid\n"
    exit 1
fi
# PARAM_START
validate_input_not_empty $PARAM_START
if [ $? -ne 0 ]
then
    echo -e "\n"FAILURE_PREFIX"The 'start' parameter is invalid\n"
    exit 1
fi
# PARAM_STOP
validate_input_not_empty $PARAM_STOP
if [ $? -ne 0 ]
then
    echo -e "\n"$FAILURE_PREFIX"The 'stop' parameter is invalid\n"
    exit 1
fi
# Range
if [ $PARAM_START -gt $PARAM_STOP ]
then
    echo -e "\n"$FAILURE_PREFIX"The 'start' can not be greater than the 'stop'\n"
    exit 1
fi


# CHANGE DIRECTORY
cd "$(dirname "$0")"

# BUILD
make --quiet -C ../.. all_$PARAM_NAME 2>&1 /dev/null
if [ $? -ne 0 ]
then
    echo -e "\n"$FAILURE_PREFIX"Makefile recipe has failed"
    echo "Replicate these results with the following command:"
    echo -e "make all_"$PARAM_NAME"\n"
    exit 1
fi 

# TEST
for (( i=$PARAM_START; i<=$PARAM_STOP; i++ ))
do
    TEMP_BIN_FILENAME=$FILE_PREFIX$i$TOOL_SUFFIX$FILE_EXT
    TEMP_BIN_REL_FILENAME=../../$DIST_DIRECTORY$TEMP_BIN_FILENAME
    # Verify binary file exists
    test -f $TEMP_REL_FILENAME
    if [ $? -ne 0 ]
    then
        echo -e "\n"$FAILURE_PREFIX$FILE_PREFIX$i$FILE_EXT" does not exist\n"
        exit 1
    fi

    # Verify log is removed, thereby guaranteeing a clean slate
    TEMP_MTRACE_LOG_FILENAME=$FILE_PREFIX$i$TOOL_SUFFIX
    TEMP_MTRACE_REL_LOG_FILENAME=../../$MTRACE_LOG_DIRECTORY$TEMP_MTRACE_LOG_FILENAME
    test -f $TEMP_MTRACE_REL_LOG_FILENAME
    if [ $? -eq 0 ]
    then
        rm -f $TEMP_MTRACE_REL_LOG_FILENAME
        if [ $? -ne 0 ]
        then
            echo -e "\n"$FAILURE_PREFIX" failed to delete"$TEMP_MTRACE_REL_LOG_FILENAME
        fi
    fi

    # Set the environment variable
    export MALLOC_TRACE=$TEMP_MTRACE_REL_LOG_FILENAME
    if [ $? -ne 0 ]
    then
        echo -e "\n"$FAILURE_PREFIX" failed to set MALLOC_TRACE environment variable\n"
        exit 1
    fi

    # Execute the binary
    $TEMP_BIN_REL_FILENAME > /dev/null 2>&1

    # Execute mtrace
    mtrace $TEMP_BIN_REL_FILENAME $TEMP_MTRACE_REL_LOG_FILENAME > /dev/null 2>&1
    RESULTS=$?
    if [ $RESULTS -eq 0 ]
    then
        echo $SUCCESS_PREFIX" Mtrace has found 0 errors in "$TEMP_BIN_FILENAME
    elif [ $RESULTS -eq 1 ]
    then
        echo -e "\n"$ERRORS_PREFIX" Mtrace has found an error in "$TEMP_BIN_FILENAME >&2
        echo "Replicate these results with the following command:"
        echo -e "mtrace "$TEMP_BIN_FILENAME $TEMP_MTRACE_LOG_FILENAME"\n" >&2
    else
        echo -e "\n"$FAILURE_PREFIX" Mtrace has failed"
        # Verify mtrace log was created
        test -f $TEMP_MTRACE_REL_LOG_FILENAME
        if [ $? -ne 0 ]
        then
            echo -e $FAILURE_PREFIX" Failed to find "$TEMP_MTRACE_REL_LOG_FILENAME
            echo -e "Did you neglect to compile your code with the MIMO Wrappers?\n"
        else
            echo -e $SUCCESS_PREFIX" found "$TEMP_MTRACE_LOG_FILENAME"\n"
        fi
        exit 1
    fi
done

exit 0
