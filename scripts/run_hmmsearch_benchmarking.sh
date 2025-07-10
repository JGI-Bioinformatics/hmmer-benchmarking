#!/bin/bash
for CPU in 256 128 64 32 16 8 4 2 1; do
    for COUNT in $(seq 5); do
        export CPU=$CPU
        export COUNT=$COUNT
        echo "submitting hmmsearch with $CPU: NUM=$COUNT"
        echo "sbatch --cpus-per-task=$CPU --job-name=hmmsearch_${CPU} --export=ALL,CPU=$CPU,COUNT=$COUNT--output="$SCRATCH/NESAP-hmmer-benchmarking/hmm_benchmark/logs/hmmsearch/$COUNT/$CPU/hmmsearch_${CPU}_%j.out" --error="$SCRATCH/NESAP-hmmer/benchmarking/hmm_benchmark/logs/hmmsearch/$COUNT/$CPU/hmmsearch_${CPU}_%j.err" submit_hmmsearch.sh"
        mkdir -p $SCRATCH/NESAP-hmmer-benchmarking/hmm_benchmark/logs/hmmsearch/$COUNT/$CPU
        sbatch --cpus-per-task=$CPU --job-name=hmmsearch_${CPU} --export=ALL,CPU=$CPU,COUNT=$COUNT --output="$SCRATCH/NESAP-hmmer-benchmarking/hmm_benchmark/logs/hmmsearch/$COUNT/$CPU/hmmsearch_${CPU}_%j.out" --error="$SCRATCH/NESAP-hmmer/benchmarking/hmm_benchmark/logs/hmmsearch/$COUNT/$CPU/hmmsearch_${CPU}_%j.err" submit_hmmsearch.sh
    done
done
