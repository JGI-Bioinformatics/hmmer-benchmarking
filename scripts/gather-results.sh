#!/bin/bash

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