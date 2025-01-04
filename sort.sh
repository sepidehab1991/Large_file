#!/bin/bash

# Check if a file is provided as an argument
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <input_csv_file> <output_csv_file>"
  exit 1
fi

input_file="$1"
output_file="$2"

# Check if the input file exists
if [ ! -f "$input_file" ]; then
  echo "Error: File '$input_file' not found!"
  exit 1
fi

# Sort the CSV file numerically by the first column
# Using a custom sort that extracts the numeric part from the first column
awk -F, '{ print $1, $2 }' "$input_file" | sort -k1,1n | awk '{ print $1","$2 }' > "$output_file"

echo "Sorted file has been saved to '$output_file'."

