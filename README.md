Taiji nextflow pipeline: 
1. checks input file is valid
2. prepare per-sample inputs for Taiji
3. runs Taiji for each sample in parallel
4. filters network for most confident edges (edges shared by at least 30% samples)
5. prepares publication-ready figures
