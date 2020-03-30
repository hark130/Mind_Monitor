#!/bin/bash
# Purpose - Automate the download, extraction, and installation of
#   necessary Memwatch files
# Exit Codes
#   1 if the download fails
#   2 if the extraction fails
#   3 if the copy fails


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
FAILURE_PREFIX="FAILURE! "  # Use this when the shell script errors

# PRINT BANNER
print_banner "INSTALL MEMWATCH"

# CHANGE DIRECTORY
cd "$(dirname "$0")"  # Change directory with respect to this script
cd ../..  # Change directory to the project's top level

# DOWNLOAD
print_banner "1. Download"
wget -P ~/Downloads/ https://www.linkdata.se/downloads/sourcecode/memwatch/memwatch-2.71.tar.gz
if [ $? -ne 0 ]
then
    echo -e "\n"$FAILURE_PREFIX" Download failed\n" >&2
    exit 1
fi

# EXTRACT
print_banner "2. Extract"
tar -xvf ~/Downloads/memwatch-2.71.tar.gz -C ~/Downloads/
if [ $? -ne 0 ]
then
    echo -e "\n"$FAILURE_PREFIX" Extraction failed\n" >&2
    exit 2
fi

# COPY
print_banner "3. Copy"
cp -v ~/Downloads/memwatch-2.71/memwatch.? src/
if [ $? -ne 0 ]
then
    echo -e "\n"$FAILURE_PREFIX" Copy failed\n" >&2
    exit 3
fi

# DONE
print_banner "MEMWATCH INSTALLED"
