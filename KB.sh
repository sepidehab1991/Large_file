#!/bin/bash

# File size in bytes (adjust as needed)
FILE_SIZE=1073741824  # Example: 1 GB

# Define chunk sizes in bytes
CHUNK_SIZES=(1024 2048 4096 8192 16384 32768 65536 131072 262144 524288)

# Number of repetitions
REPETITIONS=10

# CSV file to save results
CSV_FILE="download_times.csv"

# Initialize the CSV file with headers
echo "Chunk Size,Run,Start Time,End Time,Duration (seconds)" > $CSV_FILE

# Loop through each chunk size
for CHUNK_SIZE in "${CHUNK_SIZES[@]}"; do
    # Calculate the number of chunks
    NUM_CHUNKS=$((FILE_SIZE / CHUNK_SIZE))

    # Repeat the download 10 times
    for ((i=1; i<=REPETITIONS; i++)); do
        echo "Running test for chunk size: $CHUNK_SIZE bytes, Run: $i"

        # Capture start time
        START_TIME=$(date +%s.%N)

        # Run the download command
        python3 simpleAsync.py $NUM_CHUNKS

        # Capture end time
        END_TIME=$(date +%s.%N)

        # Calculate duration
        DURATION=$(echo "$END_TIME - $START_TIME" | bc)

        # Append the result to the CSV file
        echo "$CHUNK_SIZE,$i,$START_TIME,$END_TIME,$DURATION" >> $CSV_FILE
    done
done

# Notify completion
echo "All tests completed. Results saved in $CSV_FILE."

