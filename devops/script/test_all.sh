#!/bin/bash

GOOD_START_NUM=1
GOOD_STOP_NUM=9
BAD_START_NUM=1
BAD_STOP_NUM=9


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


# CHANGE DIRECTORY
cd "$(dirname "$0")"  # Change directory with respect to this script

# Dependency Checker
./dependency_checker.sh
if [ $? -ne 0 ]
then
    echo -e "\nYou are missing a necessary dependency."
    echo -e "Resolve the issue and try again.\n"
    exit 1
fi

# Valgrind
print_banner "VALGRIND TESTS"
./test_all_valgrind.sh good $GOOD_START_NUM $GOOD_STOP_NUM
./test_all_valgrind.sh bad $BAD_START_NUM $BAD_STOP_NUM

# Mtrace
print_banner "MTRACE TESTS"
./test_all_mtrace.sh good $GOOD_START_NUM $GOOD_STOP_NUM
./test_all_mtrace.sh bad $GOOD_START_NUM $GOOD_STOP_NUM
