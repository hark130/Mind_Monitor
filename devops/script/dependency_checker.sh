#!/bin/bash
# Purpose - Check the local system for necessary Mind Monitor (MIMO) dependencies

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
cd ../..  # Change directory to the project's top level

# LOCAL VARIABLES
EXIT_CODE=0
DMALLOC_SUMMARIZE_PATH="/usr/share/doc/libdmalloc-dev/examples/contrib/"
DMALLOC_SUMMARIZE_FILE="dmalloc_summarize.pl"
DMALLOC_SUMMARIZE_ABS_PATH=$DMALLOC_SUMMARIZE_PATH$DMALLOC_SUMMARIZE_FILE
RESULT_ONE=0    # Use this for checking two command results at once
RESULT_TWO=0    # Use this for checking two command results at once

# CHECK DEPENDENCIES
print_banner "CHECKING DEPENDENCIES"

# Dmalloc
dmalloc --version > /dev/null 2>&1
if [ $? -eq 0 ]
then
    echo "[✓] Dmalloc"
    # dmalloc_summarize.pl
    test -f $DMALLOC_SUMMARIZE_ABS_PATH
    if [ $? -ne 0 ]
    then
        echo "[ ] Dmalloc's "$DMALLOC_SUMMARIZE_FILE
        echo -e "  Failed to find"$DMALLOC_SUMMARIZE_FILE
        echo "  Attempt to find it with the following command:"
        echo -e "      find / -iname "$DMALLOC_SUMMARIZE_FILE"\n"
        EXIT_CODE=1
    fi
else
    echo "[ ] Dmalloc is not available"
    echo "  Replicate this error with the following command:"
    echo "      dmalloc --version"
    echo "  Install Dmalloc with the following command:"
    echo "      apt install libdmalloc*"
    EXIT_CODE=1
fi

# Electric Fence
dpkg-query --list electric-fence > /dev/null 2>&1
if [ $? -eq 0 ]
then
    echo "[✓] Electric Fence"
else
    echo "[ ] Electric Fence is not available"
    echo "  Replicate this error with the following command:"
    echo "      dpkg-query --list electric-fence"
    echo "      -or-"
    echo "      man efence"
    echo "  Install Electric Fence with the following command:"
    echo "      apt install electric-fence"
    EXIT_CODE=1
fi

# Memcheck (AKA Valgrind)
valgrind --version > /dev/null 2>&1
if [ $? -eq 0 ]
then
    echo "[✓] Valgrind"
else
    echo "[ ] Valgrind is not available"
    echo "  Replicate this error with the following command:"
    echo "      valgrind --version"
    echo "  Install Valgrind with the following command:"
    echo "      apt install valgrind"
    EXIT_CODE=1
fi

# Memwatch
ls src/memwatch.h > /dev/null 2>&1
RESULT_ONE=$?
ls src/memwatch.c > /dev/null 2>&1
RESULT_TWO=$?
if [ $RESULT_ONE -eq 0 ] && [ $RESULT_TWO -eq 0 ]
then
    echo "[✓] Memwatch"
else
    echo "[ ] Memwatch is not available"
    echo "  Replicate this error with the following command from the 'Mind_Monitor' directory:"
    echo "      ls src/memwatch.?"
    echo "  As to installing Memwatch... The Memwatch files have been source-controlled in this repository.  How do you *not* have them?!"
    echo "  Install Memwatch with the following commands:"
    echo "      wget -P ~/Downloads/ https://www.linkdata.se/downloads/sourcecode/memwatch/memwatch-2.71.tar.gz"
    echo "      tar -xvf ~/Downloads/memwatch-2.71.tar.gz -C ~/Downloads/"
    echo "      cp ~/Downloads/memwatch-2.71/memwatch.? src/"
    EXIT_CODE=1
fi

# Mtrace
mtrace --version > /dev/null 2>&1
if [ $? -eq 0 ]
then
    echo "[✓] Mtrace"
else
    echo "[ ] Mtrace is not available"
    echo "  Replicate this error with the following command:"
    echo "      mtrace --version"
    echo "  As to installing Mtrace... Mtrace is built into glibc!  How do you *not* have glibc?!"
    EXIT_CODE=1
fi

# DONE
echo ""
exit $EXIT_CODE