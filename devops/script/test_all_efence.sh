#!/bin/bash
# PURPOSE - Build 'name' code using Electric Fence and test it in GDB
# PARAMETERS
#   name - The name of the tests to run (e.g., good, bad)
#   start - Lowest numbered filename
#   stop - Highest numbered filename
# USAGE: test_all_efence.sh [type] [start] [stop]
# EXAMPLE: test_all_efence.sh good 1 3  # Runs mtrace on good_code{1-3}_mtrace.bin
# NOTES:
#   Executes in the following order:
#       make all_[name]; gdb -x ./devops/script/automate.gdb dist/[name]_code{1-3}_efence.bin
#   Validates all input
#   Greps the GDB output for references to:
#       - /src/
#       - ElectricFence Aborting
# EXIT CODES:
#   255 on bad input or failure
#   Otherwise, number of errors found

PARAM_NAME=$1
PARAM_START=$2
PARAM_STOP=$3

MIMO_DIST_DIRECTORY="dist/"
MIMO_LOG_DIRECTORY="devops/logs/"
MIMO_SCRIPT_DIRECTORY="devops/script/"
FILE_PREFIX=$PARAM_NAME"_code"
TOOL_SUFFIX="_efence"
BIN_FILE_EXT=".bin"
LOG_FILE_EXT=".log"
GDB_LOG_FILENAME="temp_electric_fence"$LOG_FILE_EXT
GDB_REL_LOG_FILENAME=$MIMO_LOG_DIRECTORY$GDB_LOG_FILENAME
GDB_SCRIPT_FILENAME="automate.gdb"
GDB_REL_SCRIPT_FILENAME=$MIMO_SCRIPT_DIRECTORY$GDB_SCRIPT_FILENAME
SUCCESS_PREFIX="Success: "  # Use this when the test results are favorable
FAILURE_PREFIX="FAILURE! "  # Use this when some aspect of the shell script errors
ERRORS_PREFIX="ERRORS! "    # Use this when the test results are not favorable
EFENCE_FAILURE=0            # Indicates Electric Fence found an error
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
    echo -e "\n"$FAILURE_PREFIX"The 'name' parameter is invalid\n" >&2
    exit 255
fi
# PARAM_START
validate_input_not_empty $PARAM_START
if [ $? -ne 0 ]
then
    echo -e "\n"FAILURE_PREFIX"The 'start' parameter is invalid\n" >&2
    exit 255
fi
# PARAM_STOP
validate_input_not_empty $PARAM_STOP
if [ $? -ne 0 ]
then
    echo -e "\n"$FAILURE_PREFIX"The 'stop' parameter is invalid\n" >&2
    exit 255
fi
# Range
if [ $PARAM_START -gt $PARAM_STOP ]
then
    echo -e "\n"$FAILURE_PREFIX"The 'start' can not be greater than the 'stop'\n" >&2
    exit 255
fi


# CHANGE DIRECTORY
cd "$(dirname "$0")"  # Change directory with respect to this script
cd ../..  # Change directory to the project's top level

# BUILD
make --quiet all_$PARAM_NAME 2>&1 /dev/null
if [ $? -ne 0 ]
then
    echo -e "\n"$FAILURE_PREFIX"Makefile recipe has failed" >&2
    echo "Replicate these results with the following command:" >&2
    echo -e "make all_"$PARAM_NAME"\n" >&2
    exit 255
fi 

# TEST
for (( i=$PARAM_START; i<=$PARAM_STOP; i++ ))
do
    EFENCE_FAILURE=0  # Reset temp variable
    TEMP_BIN_FILENAME=$FILE_PREFIX$i$TOOL_SUFFIX$BIN_FILE_EXT
    TEMP_BIN_REL_FILENAME=$MIMO_DIST_DIRECTORY$TEMP_BIN_FILENAME
    # Verify binary file exists
    test -f $TEMP_REL_FILENAME
    if [ $? -ne 0 ]
    then
        echo -e "\n"$FAILURE_PREFIX$FILE_PREFIX$i$BIN_FILE_EXT" does not exist\n" >&2
        exit 255
    fi

    # Verify log is removed, thereby guaranteeing a clean slate
    TEMP_EFENCE_LOG_FILENAME=$FILE_PREFIX$i$TOOL_SUFFIX$LOG_FILE_EXT
    TEMP_EFENCE_REL_LOG_FILENAME=$MIMO_LOG_DIRECTORY$TEMP_EFENCE_LOG_FILENAME
    test -f $TEMP_EFENCE_REL_LOG_FILENAME
    if [ $? -eq 0 ]
    then
        rm -f $TEMP_EFENCE_REL_LOG_FILENAME
        if [ $? -ne 0 ]
        then
            echo -e "\n"$FAILURE_PREFIX" failed to delete"$TEMP_EFENCE_REL_LOG_FILENAME >&2
        fi
    fi

    # Execute GDB
    gdb -quiet -batch -x $GDB_REL_SCRIPT_FILENAME $TEMP_BIN_REL_FILENAME
    if [ $? -ne 0 ]
    then
        echo -e "\n"$FAILURE_PREFIX" GDB failed to execute" >&2
        echo "Replicate this error with the following command:" >&2
        echo "gdb -x "$GDB_REL_SCRIPT_FILENAME $TEMP_BIN_REL_FILENAME >&2
        echo "-then-" >&2
        echo -e "cat "$GDB_REL_LOG_FILENAME"\n" >&2
        exit 255
    fi
    # Rename the temp log file
    mv $GDB_REL_LOG_FILENAME $TEMP_EFENCE_REL_LOG_FILENAME
    if [ $? -ne 0 ]
    then
        echo -e "\n"$FAILURE_PREFIX" Failed to rename the log file\n" >&2
        exit 255
    fi
    # Check the log file
    for EFENCE_ERROR_STRING in "/src/" "ElectricFence Aborting"
    do
        grep "$EFENCE_ERROR_STRING" $TEMP_EFENCE_REL_LOG_FILENAME > /dev/null 2>&1
        if [ $? -eq 0 ]
        then
            echo -e "\n"$ERRORS_PREFIX" Electric Fence has found an error inside "$TEMP_BIN_REL_FILENAME >&2
            echo "View this error with one of the following commands:" >&2
            echo "cat "$TEMP_EFENCE_REL_LOG_FILENAME >&2
            echo "-or-" >&2
            echo -e "grep \""$EFENCE_ERROR_STRING"\"" $TEMP_EFENCE_REL_LOG_FILENAME"\n" >&2
            EFENCE_FAILURE=1
        fi
    done

    # Did Electric Fence find any errors?
    if [ $EFENCE_FAILURE -eq 0 ]
    then
        echo $SUCCESS_PREFIX"Electric Fence has found 0 errors in "$TEMP_BIN_REL_FILENAME
    else
        NUM_ERRORS_FOUND=$(($NUM_ERRORS_FOUND + 1))
    fi
done

exit $NUM_ERRORS_FOUND
