#!/bin/bash

GOOD_START_NUM=1
GOOD_STOP_NUM=13
BAD_START_NUM=1
BAD_STOP_NUM=13
TOTAL_TESTS=10
SUCCESS_PREFIX="Success: "  # Use this when the test results are favorable
FAILURE_PREFIX="FAILURE! "  # Use this when some aspect of the shell script errors
ERRORS_PREFIX="ERRORS! "    # Use this when the test results are not favorable
TEMP_GOOD_EXIT=0            # Temp variable to hold the exit code for a test_all*.sh good execution
TEMP_BAD_EXIT=0             # Temp variable to hold the exit code for a test_all*.sh bad execution
TEMP_RESULTS=""             # Temp results to concatenate into RESULTS
RESULTS=""                  # Final human-readable results


# Purpose - Check the good results
check_good()
{
    # LOCAL VARIABLES
    CHECK_NAME=$1
    NUM_FOUND=$2
    TOTAL=$3
    ERROR_PHRASE="ERRORS"
    TEST_PHRASE="TESTS"

    # DO IT
    if [[ $NUM_FOUND -gt 0 ]]
    then
        if [[ $NUM_FOUND -eq 1 ]]
        then
            ERROR_PHRASE="ERROR"
        fi
        if [[ $TOTAL -eq 1 ]]
        then
            TEST_PHRASE="TEST"
        fi
        echo "\t$CHECK_NAME FOUND $NUM_FOUND GOOD $ERROR_PHRASE IN $TOTAL $TEST_PHRASE?!\n"
    else
        echo
    fi
}


# Purpose - Check the bad results
check_bad()
{
    # LOCAL VARIABLES
    CHECK_NAME=$1
    NUM_FOUND=$2
    TOTAL=$3

    # DO IT
    echo "\t$CHECK_NAME FOUND $NUM_FOUND OF $TOTAL TOTAL ERRORS\n"
}


# Purpose - Print an octothorp a certain number of times
print_line()
{
    # LOCAL VARIABLES
    LINE_LEN=$1
    LINE_STR=""
    LINE_CHAR="#"

    # INPUT VALIDATION
    if [ ${#LINE_LEN} -gt 0 ]
    then
        for (( i=0; i<($LINE_LEN+4); i++ ))
        do
            LINE_STR+="$LINE_CHAR"
        done
        echo $LINE_STR
    fi
}


# Purpose - Print a message wrapped in a banner verically
#   bookended by blank lines
print_banner()
{
    # LOCAL VARIABLES
    LINE_CHAR="#"

    # INPUT VALIDATION
    if [ ${#1} -gt 0 ]
    then
        BANNER_WIDTH=${#1}
        echo ""
        print_line $BANNER_WIDTH
        echo $LINE_CHAR $1 $LINE_CHAR
        print_line $BANNER_WIDTH
        echo ""
    fi
}

# VALIDATION
# Range Good
if [ $GOOD_START_NUM -gt $GOOD_STOP_NUM ]
then
    echo -e "\n"$FAILURE_PREFIX"The good 'start' can not be greater than the 'stop'\n" >&2
    exit 1
fi
# Range Bad
if [ $BAD_START_NUM -gt $BAD_STOP_NUM ]
then
    echo -e "\n"$FAILURE_PREFIX"The bad 'start' can not be greater than the 'stop'\n" >&2
    exit 1
fi
TOTAL_GOOD_TESTS=$(($GOOD_STOP_NUM - $GOOD_START_NUM + 1))
TOTAL_BAD_TESTS=$(($BAD_STOP_NUM - $BAD_START_NUM + 1))

# CHANGE DIRECTORY
cd "$(dirname "$0")"  # Change directory with respect to this script

# CHECK DEPENDENCIES
./dependency_checker.sh
if [ $? -ne 0 ]
then
    echo -e "\nYou are missing a necessary dependency."
    echo -e "Resolve the issue and try again.\n"
    exit 1
fi

# EXECUTE TESTS
# Dmalloc
print_banner "DMALLOC TESTS"
./test_all_dmalloc.sh good $GOOD_START_NUM $GOOD_STOP_NUM
TEMP_GOOD_EXIT=$?
TEMP_RESULTS=$(check_good "DMALLOC" $TEMP_GOOD_EXIT $TOTAL_GOOD_TESTS)
RESULTS="$RESULTS$TEMP_RESULTS"
./test_all_dmalloc.sh bad $BAD_START_NUM $BAD_STOP_NUM
TEMP_BAD_EXIT=$?
TEMP_RESULTS=$(check_bad "DMALLOC" $TEMP_BAD_EXIT $TOTAL_BAD_TESTS)
RESULTS="$RESULTS$TEMP_RESULTS"

# Electric Fence
print_banner "ELECTRIC FENCE TESTS"
./test_all_efence.sh good $GOOD_START_NUM $GOOD_STOP_NUM
TEMP_GOOD_EXIT=$?
TEMP_RESULTS=$(check_good "ELECTRIC FENCE" $TEMP_GOOD_EXIT $TOTAL_GOOD_TESTS)
RESULTS="$RESULTS$TEMP_RESULTS"
./test_all_efence.sh bad $BAD_START_NUM $BAD_STOP_NUM
TEMP_BAD_EXIT=$?
TEMP_RESULTS=$(check_bad "ELECTRIC FENCE" $TEMP_BAD_EXIT $TOTAL_BAD_TESTS)
RESULTS="$RESULTS$TEMP_RESULTS"

# Valgrind
print_banner "VALGRIND TESTS"
./test_all_valgrind.sh good $GOOD_START_NUM $GOOD_STOP_NUM
TEMP_GOOD_EXIT=$?
TEMP_RESULTS=$(check_good "VALGRIND" $TEMP_GOOD_EXIT $TOTAL_GOOD_TESTS)
RESULTS="$RESULTS$TEMP_RESULTS"
./test_all_valgrind.sh bad $BAD_START_NUM $BAD_STOP_NUM
TEMP_BAD_EXIT=$?
TEMP_RESULTS=$(check_bad "VALGRIND" $TEMP_BAD_EXIT $TOTAL_BAD_TESTS)
RESULTS="$RESULTS$TEMP_RESULTS"

# Memwatch
print_banner "MEMWATCH TESTS"
./test_all_memwatch.sh good $GOOD_START_NUM $GOOD_STOP_NUM
TEMP_GOOD_EXIT=$?
TEMP_RESULTS=$(check_good "MEMWATCH" $TEMP_GOOD_EXIT $TOTAL_GOOD_TESTS)
RESULTS="$RESULTS$TEMP_RESULTS"
./test_all_memwatch.sh bad $BAD_START_NUM $BAD_STOP_NUM
TEMP_BAD_EXIT=$?
TEMP_RESULTS=$(check_bad "MEMWATCH" $TEMP_BAD_EXIT $TOTAL_BAD_TESTS)
RESULTS="$RESULTS$TEMP_RESULTS"

# Mtrace
print_banner "MTRACE TESTS"
./test_all_mtrace.sh good $GOOD_START_NUM $GOOD_STOP_NUM
TEMP_GOOD_EXIT=$?
TEMP_RESULTS=$(check_good "MTRACE" $TEMP_GOOD_EXIT $TOTAL_GOOD_TESTS)
RESULTS="$RESULTS$TEMP_RESULTS"
./test_all_mtrace.sh bad $BAD_START_NUM $BAD_STOP_NUM
TEMP_BAD_EXIT=$?
TEMP_RESULTS=$(check_bad "MTRACE" $TEMP_BAD_EXIT $TOTAL_BAD_TESTS)
RESULTS="$RESULTS$TEMP_RESULTS"

# AddressSanitizer (ASAN)
print_banner "ADDRESS SANITIZER (ASAN) TESTS"
./test_all_ASAN.sh good $GOOD_START_NUM $GOOD_STOP_NUM
TEMP_GOOD_EXIT=$?
TEMP_RESULTS=$(check_good "ASAN" $TEMP_GOOD_EXIT $TOTAL_GOOD_TESTS)
RESULTS="$RESULTS$TEMP_RESULTS"
./test_all_ASAN.sh bad $BAD_START_NUM $BAD_STOP_NUM
TEMP_BAD_EXIT=$?
TEMP_RESULTS=$(check_bad "ASAN" $TEMP_BAD_EXIT $TOTAL_BAD_TESTS)
RESULTS="$RESULTS$TEMP_RESULTS"

# SUMMARY
echo -e "\n"
print_banner "RESULTS"
echo -e "$RESULTS"

# DONE
echo ""
