#!/bin/bash
# PURPOSE - Build 'name' code using Memwatch and test the memwatch.log
# PARAMETERS
#   name - The name of the tests to run (e.g., good, bad)
#   start - Lowest numbered filename
#   stop - Highest numbered filename
# USAGE: test_all_memwatch.sh [type] [start] [stop]
# EXAMPLE: test_all_memwatch.sh good 1 3  # Runs good_code{1-3}_memwatch.bin (memwatch binaries)
# NOTES:
#   Executes in the following order:
#       make all_[name]; dist/[name]_code{1-3}_memwatch.bin; grep <errors> memwatch.log
#   Validates all input
#   Greps the Memwatch log for references to:
#       - /src/
#       - Common errors (see: memwatch.h)

PARAM_NAME=$1
PARAM_START=$2
PARAM_STOP=$3

MIMO_DIST_DIRECTORY="dist/"
MIMO_LOG_DIRECTORY="devops/logs/"
MIMO_SCRIPT_DIRECTORY="devops/script/"
FILE_PREFIX=$PARAM_NAME"_code"
TOOL_SUFFIX="_memwatch"
BIN_FILE_EXT=".bin"
LOG_FILE_EXT=".log"
MEMWATCH_LOG_FILENAME="memwatch"$LOG_FILE_EXT
MEMWATCH_REL_LOG_FILENAME="./"$MEMWATCH_LOG_FILENAME
SUCCESS_PREFIX="Success: "  # Use this when the test results are favorable
FAILURE_PREFIX="FAILURE! "  # Use this when some aspect of the shell script errors
ERRORS_PREFIX="ERRORS! "    # Use this when the test results are not favorable
MEMWATCH_FAILURE=0          # Indicates Memwatch found an error


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
    exit 1
fi
# PARAM_START
validate_input_not_empty $PARAM_START
if [ $? -ne 0 ]
then
    echo -e "\n"FAILURE_PREFIX"The 'start' parameter is invalid\n" >&2
    exit 1
fi
# PARAM_STOP
validate_input_not_empty $PARAM_STOP
if [ $? -ne 0 ]
then
    echo -e "\n"$FAILURE_PREFIX"The 'stop' parameter is invalid\n" >&2
    exit 1
fi
# Range
if [ $PARAM_START -gt $PARAM_STOP ]
then
    echo -e "\n"$FAILURE_PREFIX"The 'start' can not be greater than the 'stop'\n" >&2
    exit 1
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
    exit 1
fi 

# TEST
for (( i=$PARAM_START; i<=$PARAM_STOP; i++ ))
do
    MEMWATCH_FAILURE=0  # Reset temp variable
    TEMP_BIN_FILENAME=$FILE_PREFIX$i$TOOL_SUFFIX$BIN_FILE_EXT
    TEMP_BIN_REL_FILENAME=$MIMO_DIST_DIRECTORY$TEMP_BIN_FILENAME
    # Verify binary file exists
    test -f $TEMP_REL_FILENAME
    if [ $? -ne 0 ]
    then
        echo -e "\n"$FAILURE_PREFIX$FILE_PREFIX$i$BIN_FILE_EXT" does not exist\n" >&2
        rm -f $MEMWATCH_REL_LOG_FILENAME > /dev/null 2>&1
        exit 1
    fi

    # Verify input log is removed, thereby guaranteeing a clean slate
    test -f $MEMWATCH_REL_LOG_FILENAME
    if [ $? -eq 0 ]
    then
        rm -f $MEMWATCH_REL_LOG_FILENAME
        if [ $? -ne 0 ]
        then
            echo -e "\n"$FAILURE_PREFIX" failed to delete "$MEMWATCH_REL_LOG_FILENAME"\n" >&2
        fi
    fi

    # Verify output log is removed, thereby guaranteeing a clean slate
    TEMP_MEMWATCH_LOG_FILENAME=$FILE_PREFIX$i$TOOL_SUFFIX$LOG_FILE_EXT
    TEMP_MEMWATCH_REL_LOG_FILENAME=$MIMO_LOG_DIRECTORY$TEMP_MEMWATCH_LOG_FILENAME
    test -f $TEMP_MEMWATCH_REL_LOG_FILENAME
    if [ $? -eq 0 ]
    then
        rm -f $TEMP_MEMWATCH_REL_LOG_FILENAME
        if [ $? -ne 0 ]
        then
            echo -e "\n"$FAILURE_PREFIX" failed to delete "$TEMP_MEMWATCH_REL_LOG_FILENAME"\n" >&2
        fi
    fi

    # Execute the binary
    $TEMP_BIN_REL_FILENAME > /dev/null 2>&1
    if [ $? -ne 0 ]
    then
        echo -e "\n"$FAILURE_PREFIX" Failed to execute binary" >&2
        echo "Replicate this error with the following command:" >&2
        echo -e $TEMP_BIN_REL_FILENAME"\n" >&2
        MEMWATCH_FAILURE=1
    else
        # Verify output log exists
        test -f $MEMWATCH_REL_LOG_FILENAME
        if [ $? -ne 0 ]
        then
            echo -e "\n"$FAILURE_PREFIX $MEMWATCH_REL_LOG_FILENAME" does not exist for "$TEMP_BIN_REL_FILENAME >&2
            echo "Replicate this error with the following commands:" >&2
            echo "rm "$MEMWATCH_REL_LOG_FILENAME >&2
            echo $TEMP_BIN_REL_FILENAME >&2
            echo -e "ls "$MEMWATCH_REL_LOG_FILENAME"\n" >&2
            MEMWATCH_FAILURE=1
        else
            # Copy the temp log file
            cp $MEMWATCH_REL_LOG_FILENAME $TEMP_MEMWATCH_REL_LOG_FILENAME
            if [ $? -ne 0 ]
            then
                echo -e "\n"$FAILURE_PREFIX" Failed to copy the memwatch log file\n" >&2
                MEMWATCH_FAILURE=1
            else
                # Check the log file
                for MEMWATCH_ERROR_STRING in "overflow" "underflow" "unfreed" "double-free" "WILD free" "wild pointer" "/src/"
                do
                    grep "$MEMWATCH_ERROR_STRING" $TEMP_MEMWATCH_REL_LOG_FILENAME > /dev/null 2>&1
                    if [ $? -eq 0 ]
                    then
                        echo -e "\n"$ERRORS_PREFIX" Memwatch has found an error inside "$TEMP_BIN_REL_FILENAME >&2
                        echo "View this error with one of the following commands:" >&2
                        echo "cat "$TEMP_MEMWATCH_REL_LOG_FILENAME >&2
                        echo "-or-" >&2
                        echo -e "grep \""$MEMWATCH_ERROR_STRING"\"" $TEMP_MEMWATCH_REL_LOG_FILENAME"\n" >&2
                        MEMWATCH_FAILURE=1
                        break  # There may be more errors but we don't want to flood the user
                    fi
                done
            fi
        fi
    fi

    # Did Memwatch find any errors?
    if [ $MEMWATCH_FAILURE -eq 0 ]
    then
        echo $SUCCESS_PREFIX"Memwatch has found 0 errors in "$TEMP_BIN_REL_FILENAME
    fi

    # Clean up
    test -f $MEMWATCH_REL_LOG_FILENAME
    if [ $? -eq 0 ]
    then
        rm -f $MEMWATCH_REL_LOG_FILENAME
        if [ $? -ne 0 ]
        then
            echo -e "\n"$FAILURE_PREFIX" failed to delete "$MEMWATCH_REL_LOG_FILENAME"\n" >&2
        fi
    fi
done

exit 0
