#!/bin/bash

# Check if a file is provided as an argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <csv_file>"
    exit 1
fi

# File path
csv_file="$1"

# Check if the file exists
if [ ! -f "$csv_file" ]; then
    echo "Error: File '$csv_file' not found!"
    exit 1
fi

# Read the CSV file, find the row with the minimum value in the second column, and print the row
awk -F, '{
    if (NR == 1 || $2 < min) {
        min = $2;
        row = $0;
    }
}
END {
    print row;
}' "$csv_file"

