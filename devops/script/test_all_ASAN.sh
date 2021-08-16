#!/bin/bash
# PURPOSE - Build and test 'name' code using mtrace
# PARAMETERS
#   name - The name of the tests to run (e.g., good, bad)
#   start - Lowest numbered filename
#   stop - Highest numbered filename
# USAGE: test_all_ASAN.sh [type] [start] [stop]
# EXAMPLE: test_all_ASAN.sh good 1 3  # Runs mtrace on good_code{1-3}_mtrace.bin
# NOTES:
#   Executes in the following order:
#       make all_[name]; dist/[name]_code{1-3}_mtrace.bin; mtrace dist/[name]_code{1-3}_mtrace.bin devops/logs/[name]_code{1-3}_mtrace
#   Validates all input
# EXIT CODES:
#   255 on bad input or failure
#   Otherwise, number of errors found

PARAM_NAME=$1
PARAM_START=$2
PARAM_STOP=$3

DIST_DIRECTORY="dist/"
MTRACE_LOG_DIRECTORY="devops/logs/"
FILE_PREFIX=$PARAM_NAME"_code"
TOOL_SUFFIX="_ASAN"
BIN_FILE_EXT=".bin"
LOG_FILE_EXT=".log"
SUCCESS_PREFIX="Success: "
FAILURE_PREFIX="FAILURE! "
ERRORS_PREFIX="ERRORS! "
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
    echo -e "\n"$FAILURE_PREFIX"The 'name' parameter is invalid\n"
    exit 255
fi
# PARAM_START
validate_input_not_empty $PARAM_START
if [ $? -ne 0 ]
then
    echo -e "\n"FAILURE_PREFIX"The 'start' parameter is invalid\n"
    exit 255
fi
# PARAM_STOP
validate_input_not_empty $PARAM_STOP
if [ $? -ne 0 ]
then
    echo -e "\n"$FAILURE_PREFIX"The 'stop' parameter is invalid\n"
    exit 255
fi
# Range
if [ $PARAM_START -gt $PARAM_STOP ]
then
    echo -e "\n"$FAILURE_PREFIX"The 'start' can not be greater than the 'stop'\n"
    exit 255
fi


# CHANGE DIRECTORY
cd "$(dirname "$0")"  # Change directory with respect to this script
cd ../..  # Change directory to the project's top level

# BUILD
make --quiet all_$PARAM_NAME 2>&1 /dev/null
if [ $? -ne 0 ]
then
    echo -e "\n"$FAILURE_PREFIX"Makefile recipe has failed"
    echo "Replicate these results with the following command:"
    echo -e "make all_"$PARAM_NAME"\n"
    exit 255
fi

# TEST
for (( i=$PARAM_START; i<=$PARAM_STOP; i++ ))
do
    TEMP_BIN_FILENAME=$FILE_PREFIX$i$TOOL_SUFFIX$BIN_FILE_EXT
    TEMP_BIN_REL_FILENAME=$DIST_DIRECTORY$TEMP_BIN_FILENAME
    # Verify binary file exists
    test -f $TEMP_REL_FILENAME
    if [ $? -ne 0 ]
    then
        echo -e "\n"$FAILURE_PREFIX$FILE_PREFIX$i$BIN_FILE_EXT" does not exist\n"
        exit 255
    fi

    # Execute the binary
    # TEMP_ERROR=$($TEMP_BIN_REL_FILENAME)
    TEMP_ERROR=$($TEMP_BIN_REL_FILENAME > /dev/null 2>&1)
    TEMP_EXIT_CODE=$?

    # Evaluate results
    if [ $TEMP_EXIT_CODE -eq 0 ]
    then
        echo $SUCCESS_PREFIX" AddressSanitizer (ASAN) has found 0 errors in "$TEMP_BIN_FILENAME
    elif [ $TEMP_EXIT_CODE -eq 1 ]
    then
        NUM_ERRORS_FOUND=$(($NUM_ERRORS_FOUND + 1))
        echo -e "\n"$ERRORS_PREFIX" AddressSanitizer (ASAN) has found an error in "$TEMP_BIN_FILENAME >&2
        echo "Replicate these results with the following command:" >&2
        echo -e "$TEMP_BIN_REL_FILENAME\n" >&2
    else
        echo -e "\n"$FAILURE_PREFIX" AddressSanitizer (ASAN) has failed" >&2
        exit 255
    fi
done

exit $NUM_ERRORS_FOUND
