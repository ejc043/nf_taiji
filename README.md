# Taiji nextflow pipeline: 

1. checks input file is valid
2. prepare per-sample inputs for Taiji
3. runs Taiji for each sample in parallel (10 samples in parallel; parameter can be changed in nextflow.config file)
4. filters network for most confident edges (edges shared by at least 10% samples) for downstream analysis by user

# Running the pipeline 
1. Ensure nextflow and docker are installed and in path
2. Download reference files from this [drive]([url](https://drive.google.com/drive/folders/1DlJm54MVIyoIfV_c5yBBzp0BI_vubVUZ?usp=sharing)) (currently only have hg38)
3. Working directory should look as so:
```
   .
├── bin
│   ├── 00_validate_input.sh
│   ├── Active.tsv
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
5. Try the small, reproducible test set with `./run_nf.sh`
   
   
