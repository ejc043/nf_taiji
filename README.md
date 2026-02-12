# choi/nftaiji

## Introduction

**choi/nftaiji** takes one input file and runs taiji given a reference i.e. hg38. It can be run locally or on hpc cluster. 

<!-- TODO nf-core:
   Complete this sentence with a 2-3 sentence summary of what types of data the pipeline ingests, a brief overview of the
   major pipeline sections and the types of output it produces. You're giving an overview to someone new
   to nf-core here, in 15-20 seconds. For an example, see https://github.com/nf-core/rnaseq/blob/master/README.md#introduction
-->

<!-- TODO nf-core: Include a figure that guides the user through the major workflow steps. Many nf-core
     workflows use the "tube map" design for that. See https://nf-co.re/docs/guidelines/graphic_design/workflow_diagrams#examples for examples.   -->
<!-- TODO nf-core: Fill in short bullet-pointed list of the default steps in the pipeline -->

## Usage

> [!NOTE]
> If you are new to Nextflow and nf-core, please refer to [this page](https://nf-co.re/docs/usage/installation) on how to set-up Nextflow. 

Please the download [dependencies](https://doi.org/10.5281/zenodo.18615384) in your current working directory (soft link should be OK). 

Your working directory should look like this: 
```bash 
.
├── bin 
├── binaries 
├── data 
├── database 
├── main.nf
├── modules
│   └── local
│       ├── extract_network_files
│       │   └── main.nf
│       ├── extract_pagerank_files
│       │   └── main.nf
│       ├── preprocess_network
│       │   └── main.nf
│       ├── run_taiji
│       │   └── main.nf
│       ├── run_taiji_singularity
│       │   └── main.nf
│       ├── taiji_make_inputs
│       │   └── main.nf
│       └── taiji_verify_input
│           └── main.nf
├── nextflow.config
├── README.md
├── run_nf.sh

```
<!-- TODO nf-core: Describe the minimum required steps to execute the pipeline, e.g. how to prepare samplesheets.
     Explain what rows and columns represent. For instance (please edit as appropriate):

First, prepare a samplesheet with your input data that looks as follows:

`samplesheet.csv`:

```csv
sample,fastq_1,fastq_2
CONTROL_REP1,AEG588A1_S1_L002_R1_001.fastq.gz,AEG588A1_S1_L002_R2_001.fastq.gz
```

Each row represents a fastq file (single-end) or a pair of fastq files (paired end).

-->
The input file looks something like this: 
```bash
type    id      group   rep     path    tags    format  cohort
HiC     HiC_OA_02       OA_02   1       /data/OA_02_hicloops_chr22.bedpe   ChromosomeLoop          OA
HiC     HiC_RA_11       RA_11   1       /data/RA_11_hicloops_chr22.bedpe   ChromosomeLoop          RA
RNA-seq RNA-OA_02       OA_02   1       /data/OA_02_RNA.tsv        GeneQuant               OA
RNA-seq RNA-RA_11       RA_11   1       /data/RA_11_RNA.tsv        GeneQuant               RA
ATAC-seq        ATAC-OA_02      OA_02   1      /data/OA_02_REP1.mLb.clN_peaks_small.narrowPeak            NarrowPeak      OA
ATAC-seq        ATAC-RA_11      RA_11   1       /data/RA_11_REP1.mLb.clN_peaks_small.narrowPeak            NarrowPeak      RA
```
Minimally, you only need RNA-seq and ATAC-seq (or ChipSeq). Make sure you input the absolute path in the `path` column. 
Now, you can run the pipeline using:

<!-- TODO nf-core: update the following command to include all required parameters for a minimal example -->

```bash
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

```
`system` is set for the binary that runs taiji and can be set to `singularity`, `macos`, `centos`, `ubuntu`. `profile` can be set to `slurm` for distributed runs or `local` if you're running it locally. 
The test dataset will take ~15 minutes to run. The output should look like this: 
```bash
.
├── filtered_edges_combined.csv
├── OA_02_taiji_inputs
│   ├── OA_02_config.yml
│   ├── OA_02_input.tsv
│   └── test_tmp
├── RA_11_taiji_inputs
│   ├── RA_11_config.yml
│   ├── RA_11_input.tsv
│   └── test_tmp
└── taiji_results
    ├── OA_02
    │   └── OA_02_taiji_inputs
    │       └── OA_02_taiji_outputs
    │           ├── ATACSeq
    │           │   ├── Download
    │           │   ├── openChromatin.bed.gz
    │           │   └── TFBS
    │           │       ├── ATAC-OA_02_rep1.bed.gz
    │           │       ├── motif_sites_part.bed3575784-0.gz
    │           │       ├── motif_sites_part.bed3575784-10.gz
    │           │       ├── motif_sites_part.bed3575784-11.gz
    │           │       ├── motif_sites_part.bed3575784-12.gz
    │           │       ├── motif_sites_part.bed3575784-13.gz
    │           │       ├── motif_sites_part.bed3575784-14.gz
    │           │       ├── motif_sites_part.bed3575784-15.gz
    │           │       ├── motif_sites_part.bed3575784-16.gz
    │           │       ├── motif_sites_part.bed3575784-17.gz
    │           │       ├── motif_sites_part.bed3575784-18.gz
    │           │       ├── motif_sites_part.bed3575784-19.gz
    │           │       ├── motif_sites_part.bed3575784-1.gz
    │           │       ├── motif_sites_part.bed3575784-20.gz
    │           │       ├── motif_sites_part.bed3575784-21.gz
    │           │       ├── motif_sites_part.bed3575784-22.gz
    │           │       ├── motif_sites_part.bed3575784-23.gz
    │           │       ├── motif_sites_part.bed3575784-24.gz
    │           │       ├── motif_sites_part.bed3575784-25.gz
    │           │       ├── motif_sites_part.bed3575784-26.gz
    │           │       ├── motif_sites_part.bed3575784-27.gz
    │           │       ├── motif_sites_part.bed3575784-28.gz
    │           │       ├── motif_sites_part.bed3575784-29.gz
    │           │       ├── motif_sites_part.bed3575784-2.gz
    │           │       ├── motif_sites_part.bed3575784-30.gz
    │           │       ├── motif_sites_part.bed3575784-31.gz
    │           │       ├── motif_sites_part.bed3575784-32.gz
    │           │       ├── motif_sites_part.bed3575784-33.gz
    │           │       ├── motif_sites_part.bed3575784-34.gz
    │           │       ├── motif_sites_part.bed3575784-35.gz
    │           │       ├── motif_sites_part.bed3575784-36.gz
    │           │       ├── motif_sites_part.bed3575784-37.gz
    │           │       ├── motif_sites_part.bed3575784-38.gz
    │           │       ├── motif_sites_part.bed3575784-39.gz
    │           │       ├── motif_sites_part.bed3575784-3.gz
    │           │       ├── motif_sites_part.bed3575784-40.gz
    │           │       ├── motif_sites_part.bed3575784-41.gz
    │           │       ├── motif_sites_part.bed3575784-42.gz
    │           │       ├── motif_sites_part.bed3575784-43.gz
    │           │       ├── motif_sites_part.bed3575784-44.gz
    │           │       ├── motif_sites_part.bed3575784-4.gz
    │           │       ├── motif_sites_part.bed3575784-5.gz
    │           │       ├── motif_sites_part.bed3575784-6.gz
    │           │       ├── motif_sites_part.bed3575784-7.gz
    │           │       ├── motif_sites_part.bed3575784-8.gz
    │           │       └── motif_sites_part.bed3575784-9.gz
    │           ├── GeneRanks_PValues.tsv
    │           ├── GeneRanks.tsv
    │           ├── Network
    │           │   └── OA_02
    │           │       ├── edges_binding.csv
    │           │       ├── edges_combined.csv
    │           │       └── nodes.csv
    │           ├── RNASeq
    │           │   ├── Download
    │           │   ├── expression_profile.tsv
    │           │   └── RNA-OA_02_rep1_gene_quant.tsv
    │           └── SCATACSeq
    │               ├── Feature
    │               │   ├── Gene
    │               │   └── Peak
    │               └── Spectral
    └── RA_11
        └── RA_11_taiji_inputs
            └── RA_11_taiji_outputs
                ├── ATACSeq
                │   ├── Download
                │   ├── openChromatin.bed.gz
                │   └── TFBS
                │       ├── ATAC-RA_11_rep1.bed.gz
                │       ├── motif_sites_part.bed197566-0.gz
                │       ├── motif_sites_part.bed197566-10.gz
                │       ├── motif_sites_part.bed197566-11.gz
                │       ├── motif_sites_part.bed197566-12.gz
                │       ├── motif_sites_part.bed197566-13.gz
                │       ├── motif_sites_part.bed197566-14.gz
                │       ├── motif_sites_part.bed197566-15.gz
                │       ├── motif_sites_part.bed197566-16.gz
                │       ├── motif_sites_part.bed197566-17.gz
                │       ├── motif_sites_part.bed197566-18.gz
                │       ├── motif_sites_part.bed197566-19.gz
                │       ├── motif_sites_part.bed197566-1.gz
                │       ├── motif_sites_part.bed197566-20.gz
                │       ├── motif_sites_part.bed197566-21.gz
                │       ├── motif_sites_part.bed197566-22.gz
                │       ├── motif_sites_part.bed197566-23.gz
                │       ├── motif_sites_part.bed197566-24.gz
                │       ├── motif_sites_part.bed197566-25.gz
                │       ├── motif_sites_part.bed197566-26.gz
                │       ├── motif_sites_part.bed197566-27.gz
                │       ├── motif_sites_part.bed197566-28.gz
                │       ├── motif_sites_part.bed197566-29.gz
                │       ├── motif_sites_part.bed197566-2.gz
                │       ├── motif_sites_part.bed197566-30.gz
                │       ├── motif_sites_part.bed197566-31.gz
                │       ├── motif_sites_part.bed197566-32.gz
                │       ├── motif_sites_part.bed197566-33.gz
                │       ├── motif_sites_part.bed197566-34.gz
                │       ├── motif_sites_part.bed197566-35.gz
                │       ├── motif_sites_part.bed197566-36.gz
                │       ├── motif_sites_part.bed197566-37.gz
                │       ├── motif_sites_part.bed197566-38.gz
                │       ├── motif_sites_part.bed197566-39.gz
                │       ├── motif_sites_part.bed197566-3.gz
                │       ├── motif_sites_part.bed197566-40.gz
                │       ├── motif_sites_part.bed197566-41.gz
                │       ├── motif_sites_part.bed197566-42.gz
                │       ├── motif_sites_part.bed197566-43.gz
                │       ├── motif_sites_part.bed197566-44.gz
                │       ├── motif_sites_part.bed197566-4.gz
                │       ├── motif_sites_part.bed197566-5.gz
                │       ├── motif_sites_part.bed197566-6.gz
                │       ├── motif_sites_part.bed197566-7.gz
                │       ├── motif_sites_part.bed197566-8.gz
                │       └── motif_sites_part.bed197566-9.gz
                ├── GeneRanks_PValues.tsv
                ├── GeneRanks.tsv
                ├── Network
                │   └── RA_11
                │       ├── edges_binding.csv
                │       ├── edges_combined.csv
                │       └── nodes.csv
                ├── RNASeq
                │   ├── Download
                │   ├── expression_profile.tsv
                │   └── RNA-RA_11_rep1_gene_quant.tsv
                └── SCATACSeq
                    ├── Feature
                    │   ├── Gene
                    │   └── Peak
                    └── Spectral
```

> [!WARNING]
> Please provide pipeline parameters via the CLI or Nextflow `-params-file` option. Custom config files including those provided by the `-c` Nextflow option can be used to provide any configuration _**except for parameters**_; see [docs](https://nf-co.re/docs/usage/getting_started/configuration#custom-configuration-files).

## Credits

choi/nftaiji was originally written by Eunice Choi.


<!-- TODO nf-core: If applicable, make list of people who have also contributed -->

## Contributions and Support

If you would like to contribute to this pipeline, please see the [contributing guidelines](.github/CONTRIBUTING.md).

## Citations

<!-- TODO nf-core: Add citation for pipeline after first release. Uncomment lines below and update Zenodo doi and badge at the top of this file. -->
<!-- If you use choi/nftaiji for your analysis, please cite it using the following doi: [10.5281/zenodo.XXXXXX](https://doi.org/10.5281/zenodo.XXXXXX) -->



This pipeline uses code and infrastructure developed and maintained by the [nf-core](https://nf-co.re) community, reused here under the [MIT license](https://github.com/nf-core/tools/blob/main/LICENSE).

> **The nf-core framework for community-curated bioinformatics pipelines.**
>
> Philip Ewels, Alexander Peltzer, Sven Fillinger, Harshil Patel, Johannes Alneberg, Andreas Wilm, Maxime Ulysse Garcia, Paolo Di Tommaso & Sven Nahnsen.
>
> _Nat Biotechnol._ 2020 Feb 13. doi: [10.1038/s41587-020-0439-x](https://dx.doi.org/10.1038/s41587-020-0439-x).
# nftaiji
