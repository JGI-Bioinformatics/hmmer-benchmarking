#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --mem 64G
#SBATCH -q regular
#SBATCH -A m342
#SBATCH -t 5:00:00
#SBATCH --constraint=cpu
#SBATCH --output=/pscratch/sd/m/mamelara/NESAP-hmmer-benchmarking/logs/hmmsearch_%j.out
#SBATCH --error=/pscratch/sd/m/mamelara/NESAP-hmmer-benchmarking/logs/hmmsearch_%j.err

WORKDIR="$SCRATCH/NESAP-hmmer-benchmarking/hmm_benchmark"
HMM_FILE="$WORKDIR/databases/panther_main/panther.hmm"
DB_FILE="$WORKDIR/inputs/Arabidopsis_thaliana.pep.fa"

module load python
conda activate HMMer
{ time hmmsearch --cpu $CPU $HMM_FILE $DB_FILE > $WORKDIR/logs/$COUNT/$CPU/hmmsearch_output_${CPU}.out 2> $WORKDIR/logs/$COUNT/$CPU/stderr_${CPU}.log; } 2> $WORKDIR/logs/$COUNT/$CPU/time_${CPU}.log
