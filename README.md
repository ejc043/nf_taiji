# Taiji nextflow pipeline: 

1. checks input file is valid
2. prepare per-sample inputs for Taiji
3. runs Taiji for each sample in parallel (10 samples in parallel; parameter can be changed in nextflow.config file)
4. filters network for most confident edges (edges shared by at least 10% samples) for downstream analysis by user

# Running the pipeline 
1. Ensure nextflow and docker are installed and in path
2. Download reference files from this [drive](https://drive.google.com/drive/folders/1DlJm54MVIyoIfV_c5yBBzp0BI_vubVUZ?usp=sharing) (currently only have hg38)
3. Working directory should look as so:
```
   .
├── bin
│   ├── 00_validate_input.sh
│   ├── taiji_wrapper-uniqueGen.py
│   ├── test_regular_taiji_run.sh
│   └── write_inputs.sh
├── binaries
│   ├── taiji-CentOS-x86_64
│   ├── taiji-macOS-Catalina-10.15
│   └── taiji-Ubuntu-x86_64
├── data
│   ├── OA_02_REP1.mLb.clN_peaks_small.narrowPeak
│   ├── oa1316_hicloops_chr22.bedpe
│   ├── oa1316_RNA.tsv
│   ├── RA_11_REP1.mLb.clN_peaks_small.narrowPeak
│   ├── ra999_hicloops_chr22.bedpe
│   ├── ra999_RNA.tsv
│   └── taiji_small_sample.tsv
├── database
│   ├── hg38
│   └── taiji_config_formulafile.yml
├── main.nf
├── nextflow.config
├── README.md
├── regular_taiji_inputs
│   ├── output
│   ├── sciflow.db
│   ├── taiji_small_sample.tsv
│   └── test_config.yml
├── run_nf.sh
├── work
│   ├── 04
│   ├── 07
│   ├── 09
```
5. Try the small, reproducible test set with :
   ```
   nextflow run main.nf \
    --inputs 'data/taiji_small_sample.tsv' \
    --output 'test_nextflow_output/' \
    --genome 'hg38' \
    --system 'macos' \
    --wd $(realpath .) \
    -resume
   ```
`--system` can be `centos`,`macos`, or `ubuntu` depending on your local system
`--inputs` is your tab delimited, 8 column .tsv file with <u>absolute</u> paths to input files. RNA-seq and ATAC-seq are required while HiC is optional. Check the [documentation](https://taiji-pipeline.github.io/documentation/input.html) for more input options.
`--output` is your output directory.
`--genome` is your reference files
`--wd` is your working directory
Running the small test set should take <15 minutes:
```
executor >  local (10)
[8d/477b40] TAIJI_BASIC_VERIFY_INPUT (1) [100%] 1 of 1 ✔
[41/f63de1] TAIJI_MAKE_INPUTS (1)        [100%] 1 of 1 ✔
[6e/43ea50] RUN_TAIJI (2)                [100%] 2 of 2 ✔
[65/fc2e45] EXTRACT_NETWORK_FILES (2)    [100%] 2 of 2 ✔
[8d/c6ba85] PREPROCESS_NETWORK (1)       [100%] 1 of 1 ✔
[1b/a55e65] EXTRACT_PAGERANK_FILES (2)   [100%] 2 of 2 ✔
[50/60ff9e] VISUALIZE_NETWORK            [100%] 1 of 1 ✔
Found network file: /Users/eunicechoi/Documents/bioinformatics_resources/CHEM280/WI26/Taiji/work/65/fc2e45861c44240ce923b05fc4135b/ra999_edges_combined.csv
Found PageRank file: /Users/eunicechoi/Documents/bioinformatics_resources/CHEM280/WI26/Taiji/work/1b/a55e65ff32880993b3d95bc1fcb56b/ra999_GeneRanks.tsv
Completed at: 17-Dec-2025 15:52:09
Duration    : 13m 42s
CPU hours   : 0.4
Succeeded   : 10

```
the output should look as so:
```
.
├── figures
│   └── pageranks.png
├── filtered_edges_combined.csv
├── oa1316_taiji_inputs
│   ├── oa1316_config.yml
│   ├── oa1316_input.tsv
│   └── test_tmp
├── ra999_taiji_inputs
│   ├── ra999_config.yml
│   ├── ra999_input.tsv
│   └── test_tmp
└── taiji_results
    ├── oa1316
    └── ra999
```
   
   
