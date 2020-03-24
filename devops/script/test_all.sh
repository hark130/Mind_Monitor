#!/bin/bash

GOOD_START_NUM=1
GOOD_STOP_NUM=9
BAD_START_NUM=1
BAD_STOP_NUM=9

# CHANGE DIRECTORY
cd "$(dirname "$0")"

./test_all_valgrind.sh good $GOOD_START_NUM $GOOD_STOP_NUM
./test_all_valgrind.sh bad $BAD_START_NUM $BAD_STOP_NUM
./test_all_mtrace.sh good $GOOD_START_NUM $GOOD_STOP_NUM
./test_all_mtrace.sh bad $GOOD_START_NUM $GOOD_STOP_NUM
