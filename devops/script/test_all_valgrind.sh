#!/bin/bash
# PURPOSE - Build and test 'name' code using valgrind
# PARAMETERS
#   name - The name of the tests to run (e.g., good, bad)
#   start - Lowest numbered filename
#   stop - Highest numbered filename
# USAGE: test_all_valgrind.sh [type] [start] [stop]
# EXAMPLE: test_all_valgrind.sh good 1 3  # Runs valgrind on good_code{1-3}.bin
# NOTES:
#   Executes in the following order:
#       make all_[name]; valgrind dist/[name]_code{1-3}.bin
#   Executes valgrind with:
#       valgrind -q --leak-check=full --track-origins=yes --tool=memcheck \
#       --error-exitcode=1 dist/[name]_code{start-stop}.bin 2>&1 /dev/null
#   Validates all input
# EXIT CODES:
#   255 on bad input or failure
#   Otherwise, number of errors found

PARAM_NAME=$1
PARAM_START=$2
PARAM_STOP=$3

DIRECTORY="dist/"
FILE_PREFIX=$PARAM_NAME"_code"
FILE_EXT=".bin"
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
    echo ""
    echo $FAILURE_PREFIX"Makefile recipe has failed" >&2
    echo "Replicate these results with the following command:" >&2
    echo "make all_"$PARAM_NAME >&2
    echo ""
    exit 255
fi

# TEST
for (( i=$PARAM_START; i<=$PARAM_STOP; i++ ))
do
    TEMP_REL_FILENAME=$DIRECTORY$FILE_PREFIX$i$FILE_EXT
    # Verify file exists
    test -f $TEMP_REL_FILENAME
    if [ $? -ne 0 ]
    then
        echo ""
        echo $FAILURE_PREFIX$FILE_PREFIX$i$FILE_EXT" does not exist" >&2
        echo ""
        exit 255
    fi

    # Execute valgrind
    # A. See the valgrind errors
    # valgrind -q --leak-check=full --track-origins=yes --tool=memcheck\
    # --child-silent-after-fork=yes --error-exitcode=1\
    # $TEMP_REL_FILENAME 2>&1 /dev/null
    # B. Silence the valgrind errors
    valgrind -q --leak-check=full --track-origins=yes --tool=memcheck\
    --child-silent-after-fork=yes --error-exitcode=1 --trace-children=yes\
    $TEMP_REL_FILENAME > /dev/null 2>&1

    # Check the results
    if [ $? -eq 0 ]
    then
        echo $SUCCESS_PREFIX"Valgrind has found 0 errors in"\
        $TEMP_REL_FILENAME
    else
        NUM_ERRORS_FOUND=$(($NUM_ERRORS_FOUND + 1))
        echo ""
        echo $ERRORS_PREFIX"Valgrind has found an error in"\
        $FILE_PREFIX$i$FILE_EXT >&2
        echo "Replicate these results with the following command:" >&2
        echo "valgrind -v --leak-check=full --track-origins=yes"\
        "--tool=memcheck --child-silent-after-fork=yes"\
        "--trace-children=yes" $TEMP_REL_FILENAME >&2
        echo ""
    fi   
done

exit $NUM_ERRORS_FOUND
