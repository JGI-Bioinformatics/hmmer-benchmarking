# HMMersearch Benchmarking Study

The contents of this repo contain scripts and data used for benchmarking Hmmer. The runs are done on CPU perlmutter.
Submissions scripts are found in the /data directory. There also exists an hmm_benchmark.tgz tarball that contains
the HMMs and FAA files to run hmmsearch. Most of the file paths are references to Perlmutter so this repository
should be used on that filesystems (e.g $SCRATCH, $CFS, etc)

## Install
This project uses `uv` package manager to manage depends and run the project. If you don't have `uv` installed you can
follow the instructions [here](https://docs.astral.sh/uv/getting-started/installation/). You can run a jupyter notebook
server using the following command: `uv run --with jupyter jupyter lab`.


## scripts/
The project contains a `/scripts` directory that contains two scripts: `run_benchmarking.sh` and `submit_hmmsearch.sh`.
The `run_benchmarking.sh` is the main script to be used to submit multiple runs using different core counts. These
scripts submit to Perlmutter. Adjust the `#SBATCH` stanzas to your appropriate QOS and Account names. 

### hmmr_benchmarking data
The data needed to run the scripts is located at this portal: https://portal.nersc.gov/dna/plant/annotation/hmm_benchmark/hmm_benchmark.tgz. 
To fetch the data, run:

```
wget https://portal.nersc.gov/dna/plant/annotation/hmm_benchmark/hmm_benchmark.tgz
```

This will download a tgz file with the following contents:

```console
├── databases
│   ├── panther_main
│   └── panther_small
├── hmmscan
│   ├── regular_run
│   └── tiny_run
├── hmmsearch
│   ├── regular_run
│   └── tiny_run
├── inputs
│   ├── Arabidopsis_thaliana.100.pep.fa
│   └── Arabidopsis_thaliana.pep.fa
└── README.md
```

## Perlmutter setup
Most of the work done for this study was done on Perlmutter. To setup this experiment, you will want to make sure you have
access to the $SCRATCH filesystem. As a setup, you can download the tarball and extract it on the $SCRATCH filesystem. 
You can also create an output file (here it is called `logs`). As an example, the `run_benchmarking.sh` script creates
the output directories located here: 

`mkdir -p $SCRATCH/NESAP-hmmer-benchmarking/hmm_benchmark/logs/$COUNT/$CPU`

The `hmm_benchmark` dir is the name of the dir when you extract the tarball, however, you can
direct your logfiles to any path. Just change references to it in `run_benchmarking.sh`.

### gather-results.sh
Utility script that aggregates the timings from all the runs. You run this from the output directory referenced above.
This will write to a CSV file to be used for analysis using the jupyter notebook.

## data/
HmmrsearchBenchmarking.ipnb is a notebook that analyses the data found in `data/results.csv`. The results.csv contains
the timing data from 5 different runs that consists of running hmmsearch on Arabidopsis_thaliana.pep.fa file. 
