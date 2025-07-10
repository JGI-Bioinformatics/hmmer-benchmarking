#!/bin/bash
for CPU in 256 128 64 32 16 8 4 2 1; do
    for COUNT in $(seq 5); do
        export CPU=$CPU
        export COUNT=$COUNT
        echo "submitting hmmscan with $CPU: NUM=$COUNT"
        echo "sbatch --cpus-per-task=$CPU --job-name=hmmscan_${CPU} --export=ALL,CPU=$CPU,COUNT=$COUNT--output="$SCRATCH/NESAP-hmmer-benchmarking/hmm_benchmark/logs/hmmscan/$COUNT/$CPU/hmmscan_${CPU}_%j.out" --error="$SCRATCH/NESAP-hmmer/benchmarking/hmm_benchmark/logs/hmmscan/$COUNT/$CPU/hmmscan_${CPU}_%j.err" submit_hmmscan.sh"
        mkdir -p $SCRATCH/NESAP-hmmer-benchmarking/hmm_benchmark/logs/hmmscan/$COUNT/$CPU
        sbatch --cpus-per-task=$CPU --job-name=hmmscan_${CPU} --export=ALL,CPU=$CPU,COUNT=$COUNT --output="$SCRATCH/NESAP-hmmer-benchmarking/hmm_benchmark/logs/$COUNT/$CPU/hmmscan/hmmscan_${CPU}_%j.out" --error="$SCRATCH/NESAP-hmmer/benchmarking/hmm_benchmark/logs/hmmscan/$COUNT/$CPU/hmmscan_${CPU}_%j.err" submit_hmmscan.sh
    done
done
