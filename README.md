# Taiji nextflow pipeline: 
1. checks input file is valid
2. prepare per-sample inputs for Taiji
3. runs Taiji for each sample in parallel (10 samples in parallel; parameter can be changed in nextflow.config file)
4. filters network for most confident edges (edges shared by at least 10% samples) for downstream analysis by user
   
   
