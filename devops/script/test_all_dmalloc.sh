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
# DISCLAIMER:
#   Whether it's user error, Dmalloc BUGS, bad documentation, or some
#   combination of all of the above, I don't like Dmalloc.  The Perl script's
#   output doesn't mention ERRORs from the log file and otherwise isn't very
#   useful or readable.  The log file itself is a mess and difficult to read.
#   (Isn't the Perl script supposed to be parsing the log for me?!)  The worst
#   part is the false positives.  I am unable to determine why (I stopped short
#   of using gdb) Dmalloc is reporting heap-based memory leaks for code that
#   doesn't allocate memory on the heap.  These false positives essentially
#   make this tool unusable.  The "check to see if Dmalloc found a problem"
#   statements below are a bit of a "shunt" around Dmalloc's failings.
#   I search the Perl script output for mentions of the directory I store my
#   source code in.  I also grep the log file for "ERROR".  That's about as
#   much use as I can squeeze out of Dmalloc.
# EXIT CODES:
#   255 on bad input or failure
#   Otherwise, number of errors found

PARAM_NAME=$1
PARAM_START=$2
PARAM_STOP=$3

DIST_DIRECTORY="dist/"
DMALLOC_LOG_DIRECTORY="devops/logs/"
FILE_PREFIX=$PARAM_NAME"_code"
TOOL_SUFFIX="_dmalloc"
BIN_FILE_EXT=".bin"
LOG_FILE_EXT=".log"
SUCCESS_PREFIX="Success: "  # Use this when the test results are favorable
FAILURE_PREFIX="FAILURE! "  # Use this when some aspect of the shell script errors
ERRORS_PREFIX="ERRORS! "    # Use this when the test results are not favorable
DMALLOC_SUMMARIZE_PATH="/usr/share/doc/libdmalloc-dev/examples/contrib/"
DMALLOC_SUMMARIZE_FILE="dmalloc_summarize.pl"
DMALLOC_SUMMARIZE_ABS_PATH=$DMALLOC_SUMMARIZE_PATH$DMALLOC_SUMMARIZE_FILE
DMALLOC_FAILURE=0           # Indicates Dmalloc found an error
NUM_ERRORS_FOUND=0

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
    exit 255
fi
# PARAM_START
validate_input_not_empty $PARAM_START
if [ $? -ne 0 ]
then
    echo -e "\n"FAILURE_PREFIX" The 'start' parameter is invalid\n"
    exit 255
fi
# PARAM_STOP
validate_input_not_empty $PARAM_STOP
if [ $? -ne 0 ]
then
    echo -e "\n"$FAILURE_PREFIX" The 'stop' parameter is invalid\n"
    exit 255
fi
# Range
if [ $PARAM_START -gt $PARAM_STOP ]
then
    echo -e "\n"$FAILURE_PREFIX" The 'start' can not be greater than the 'stop'\n"
    exit 255
fi
# dmalloc_summarize.pl
test -f $DMALLOC_SUMMARIZE_ABS_PATH
if [ $? -ne 0 ]
then
    echo -e "\n"$FAILURE_PREFIX" Failed to find"$DMALLOC_SUMMARIZE_FILE
    echo "Attempt to find it with the following command:"
    echo -e "   find / -iname "$DMALLOC_SUMMARIZE_FILE"\n"
    exit 255
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
    exit 255
fi

# TEST
for (( i=$PARAM_START; i<=$PARAM_STOP; i++ ))
do
    DMALLOC_FAILURE=0  # Reset temp variable
    TEMP_BIN_FILENAME=$FILE_PREFIX$i$TOOL_SUFFIX$BIN_FILE_EXT
    TEMP_BIN_REL_FILENAME=$DIST_DIRECTORY$TEMP_BIN_FILENAME
    # Verify binary file exists
    test -f $TEMP_BIN_REL_FILENAME
    if [ $? -ne 0 ]
    then
        echo -e "\n"$FAILURE_PREFIX $TEMP_BIN_FILENAME" does not exist\n"
        exit 255
    fi

    # Verify log is removed, thereby guaranteeing a clean slate
    TEMP_DMALLOC_LOG_FILENAME=$FILE_PREFIX$i$TOOL_SUFFIX$LOG_FILE_EXT
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
        exit 255
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
        NUM_ERRORS_FOUND=$(($NUM_ERRORS_FOUND + 1))
        echo -e "\n"$ERRORS_PREFIX" Dmalloc has found an error with "$TEMP_BIN_REL_FILENAME >&2
        echo "Replicate these results with the following commands:"
        echo $DMALLOC_SUMMARIZE_ABS_PATH" < "$TEMP_DMALLOC_REL_LOG_FILENAME >&2
        echo -e "cat "$TEMP_DMALLOC_REL_LOG_FILENAME"\n" >&2
    fi
done

exit $NUM_ERRORS_FOUND
