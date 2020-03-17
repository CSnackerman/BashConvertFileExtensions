#!/bin/bash

inExtension="null"
outExtension="null"
validOptions=1

# Spacer
echo ""

# Parse options for user passed extensions choices
while getopts 'i:o:' option;
do
    case "$option" in
        i) inExtension=$OPTARG ;;
        o) outExtension=$OPTARG ;;
    esac
done

# Validate user passed options
if [ "$inExtension" = "null" ]
then
    echo "ERROR: missing option [-i .inFileExt]"
    validOptions=0
fi

if [ "$outExtension" = "null" ]
then
    echo "ERROR: missing option [-o .outFileExt]"
    validOptions=0
fi

if [ $validOptions -eq 0 ]
then
    exit 0
fi

# Get length of option args
inExtensionLength=${#inExtension}
outExtensionLength=${#outExtension}


# Script execution informative header:

# Line 1
headerLine1='*** CONVERTING FILE EXTENSIONS ***'
headerLine1Length=${#headerLine1}

# Line 2
let spacesToFill=$headerLine1Length-$inExtensionLength-$outExtensionLength-6
let halfSpaces=$spacesToFill/2
headerLine2=""
for i in $(seq 0 $spacesToFill);
do
    if [ $i -lt $halfSpaces ]
    then
        headerLine2="${headerLine2} "
    elif [ $i -gt $halfSpaces ]
    then
        headerLine2="${headerLine2} "
    else
        headerLine2="${headerLine2} $inExtension -> $outExtension "
    fi
done

# Line 3
headerLine3=""
for i in $(seq 1 $headerLine1Length);
do
    headerLine3="${headerLine3}."
done

# Output script execution header to terminal
echo "$headerLine1"
echo "$headerLine2"
echo "$headerLine3"

# Convert extensions for all files in directory of script invocation
regexString="*$inExtension"
for f in $regexString; do
    mv -- "$f" "$(basename -- "$f" $inExtension)$outExtension"
done

# Check if completed successfully
if [ $? -eq 0 ]
then
    echo "...Success"
else
    echo "...file extension conversion unsuccessful"
fi

echo ""
