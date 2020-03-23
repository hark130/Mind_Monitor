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
#       make all_[name]; valgrind [name]_code{1-3}.bin
#   Executes valgrind with:
#       valgrind -q --leak-check=full --track-origins=yes --tool=memcheck \
#       --error-exitcode=1 [name]_code{start-stop}.bin 2>&1 /dev/null
#   Validates all input

PARAM_NAME=$1
PARAM_START=$2
PARAM_STOP=$3

DIRECTORY="dist/"
FILE_PREFIX=$PARAM_NAME"_code"
FILE_EXT=".bin"
SUCCESS_PREFIX="Success: "
FAILURE_PREFIX="FAILURE! "

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
    echo $FAILURE_PREFIX"The 'name' parameter is invalid"
    exit 1
fi
# PARAM_START
validate_input_not_empty $PARAM_START
if [ $? -ne 0 ]
then
    echo $FAILURE_PREFIX"The 'start' parameter is invalid"
    exit 1
fi
# PARAM_STOP
validate_input_not_empty $PARAM_STOP
if [ $? -ne 0 ]
then
    echo $FAILURE_PREFIX"The 'stop' parameter is invalid"
    exit 1
fi
# Range
if [ $PARAM_START -gt $PARAM_STOP ]
then
    echo $FAILURE_PREFIX"The 'start' can not be greater than the 'stop'"
    exit 1
fi


# CHANGE DIRECTORY
cd "$(dirname "$0")"

# BUILD
make --quiet -C ../.. all_$PARAM_NAME 2>&1 /dev/null
if [ $? -ne 0 ]
then
    echo ""
    echo $FAILURE_PREFIX"Makefile recipe has failed"
    echo "Replicate these results with the following command:"
    echo "make all_"$PARAM_NAME
    echo ""
    exit 1
fi 

# TEST
for (( i=$PARAM_START; i<=$PARAM_STOP; i++ ))
do
    TEMP_REL_FILENAME=../../$DIRECTORY$FILE_PREFIX$i$FILE_EXT
    # Verify file exists
    test -f $TEMP_REL_FILENAME
    if [ $? -ne 0 ]
    then
        echo ""
        echo $FAILURE_PREFIX$FILE_PREFIX$i$FILE_EXT" does not exist"
        echo ""
        exit 1
    fi

    # Execute valgrind
    # A. See the valgrind errors
    # valgrind -q --leak-check=full --track-origins=yes --tool=memcheck\
    # --child-silent-after-fork=yes --error-exitcode=1\
    # $TEMP_REL_FILENAME 2>&1 /dev/null
    # B. Silence the valgrind errors
    valgrind -q --leak-check=full --track-origins=yes --tool=memcheck\
    --child-silent-after-fork=yes --error-exitcode=1\
    $TEMP_REL_FILENAME > /dev/null 2>&1

    # Check the results
    if [ $? -eq 0 ]
    then
        echo $SUCCESS_PREFIX"Valgrind has found 0 errors in"\
        $FILE_PREFIX$i$FILE_EXT
    else
        echo ""
        echo $FAILURE_PREFIX"Valgrind has found an error in"\
        $FILE_PREFIX$i$FILE_EXT >&2
        echo "Replicate these results with the following command:"
        echo "valgrind -v --leak-check=full --track-origins=yes"\
        "--tool=memcheck" $FILE_PREFIX$i$FILE_EXT
        echo ""
        # exit 1
    fi   
done

exit 0
