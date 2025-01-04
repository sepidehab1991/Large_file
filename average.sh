#!/bin/bash

# Input CSV file defined directly in the script
input_file="results1G.csv"
output_file="output1G.csv"

# Verify the input file exists
if [ ! -f "$input_file" ]; then
    echo "Error: Input file '$input_file' does not exist."
    exit 1
fi

# Process the file
awk -F"," -v output_file="$output_file" 'BEGIN {
    OFS=",";
} {
    group[$2] += $4;
    count[$2]++;
} END {
    for (key in group) {
        avg = group[key] / count[key];
        print key, avg > output_file;
    }
}' "$input_file"

echo "Processing complete. Results saved to $output_file."

