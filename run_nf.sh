#!/bin/bash
#SBATCH --mem 60G 
#SBATCH --cpus-per-task=24 
#SBATCH --job-name=nf-taiji
time nextflow run main.nf \
    --inputs 'data/taiji_small_sample.tsv' \
    --output 'test_nextflow_output/' \
    --genome 'hg38' \
    --system 'singularity' \
    --wd $(realpath .) \
    -profile slurm

