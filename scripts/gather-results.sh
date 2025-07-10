#!/bin/bash

# --- HMMER Benchmarking Script ---
# This script processes benchmark timing logs for HMMER.
# It takes one argument: the name of the directory to process (e.g., hmmscan or hmmsearch).
# It navigates into subdirectories representing experimental runs and CPU counts,
# extracts the 'real' time from log files, and compiles the results into a CSV file
# named 'results.csv' inside the specified target directory.

# During my experiments this script was at this path:
# /pscratch/sd/m/mamelara/NESAP-hmmer-benchmarking/hmm_benchmark/logs
# Which is where the results were located at the end of each run

# --- Argument Validation ---
# Check if a directory name was provided as an argument.
if [ -z "$1" ]; then
    echo "Usage: $0 <directory_name>"
    echo "Example: $0 hmmscan"
    exit 1
fi

TARGET_DIR=$1

# Check if the provided directory exists.
if [ ! -d "$TARGET_DIR" ]; then
    echo "Error: Directory '$TARGET_DIR' not found."
    exit 1
fi

# --- Main Logic ---
# Change into the target directory (e.g., hmmscan or hmmsearch).
cd "$TARGET_DIR" || exit

# Define the results file path relative to the new directory.
RESULTS_FILE=$(pwd)/results.csv

echo "CPU,Time" > "$RESULTS_FILE"

for experiment in $(seq 1 5); do
    cd $experiment
    for cpu in 256 128 64 32 16 8 4 2 1; do
        echo "changing directory $(pwd)/$cpu"
        cd $cpu 
        grep "real" time_$cpu.log | sed -E 's/[^0-9]*([0-9]+)m([0-9]+\.[0-9]+)s/\1m\2s/' | \
                awk -F'[m,s]' -v cpu="$cpu" '{print cpu "," ($1 * 60 + $2)}' >> "${RESULTS_FILE}"
        cd ..
    done
    cd ..
done
