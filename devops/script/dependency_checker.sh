#!/bin/bash


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


# LOCAL VARIABLES
EXIT_CODE=0


print_banner "CHECKING DEPENDENCIES"

# Dmalloc
dmalloc --version > /dev/null 2>&1
if [ $? -eq 0 ]
then
    echo "[✓] Dmalloc"
else
    echo "[ ] Dmalloc is not available"
    echo "  Replicate this error with the following command:"
    echo "      dmalloc --version"
    echo "  Install valgrind with the following command:"
    echo "      apt install libdmalloc*"
    EXIT_CODE=1
fi

# Electric Fence
echo "[?] Electric Fence"

# Memcheck (AKA Valgrind)
valgrind --version > /dev/null 2>&1
if [ $? -eq 0 ]
then
    echo "[✓] Valgrind"
else
    echo "[ ] Valgrind is not available"
    echo "  Replicate this error with the following command:"
    echo "      valgrind --version"
    echo "  Install valgrind with the following command:"
    echo "      apt install valgrind"
    EXIT_CODE=1
fi

# Memwatch
echo "[?] Memwatch"

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