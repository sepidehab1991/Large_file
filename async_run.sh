#!/bin/bash

# Constants
total_file_size=4096  # Total file size in MB
num_servers=6         # Number of servers
max_chunk_size=$((total_file_size / num_servers))  # Maximum chunk size (L)

# Output files
output_csv="results4G.csv"
output_log="async"

# Ensure output files are clean
echo "File Name,Chunk Size (MB),Number of Chunks,Run Time (Seconds)" > $output_csv
> $output_log

# Iterate over chunk sizes from 1M to max_chunk_size (L)

#for chunk_size in $(seq 1 $max_chunk_size); do
for chunk_size in $(seq 1 427); do
    echo "Testing with chunk size: ${chunk_size}M"
    
    # Calculate the number of chunks
    num_chunks=$((total_file_size / chunk_size))
    
        
       # Run the Python script 10 times for each file size
     for run in $(seq 1 10); do
	     echo "Running for file: $file_name, Number of Chunks: $num_chunks, Iteration: $run"
            
            # Measure time and capture output
            start_time=$(date +%s%N)  # Start time in nanoseconds
            python3 simpleAsync.py $num_chunks >> $output_log 2>&1
            end_time=$(date +%s%N)    # End time in nanoseconds
            
            # Calculate elapsed time in seconds
            elapsed_time=$(echo "scale=4; ($end_time - $start_time) / 1000000000" | bc)
            
            # Append results to CSV file
            echo "$file_name,${chunk_size}M, Num_Chunks:$num_chunks,$elapsed_time" >> $output_csv
        done
    done

echo "All runs completed. Results saved to $output_csv and logs saved to $output_log."

