nextflow run main.nf \
    --inputs 'data/taiji_small_sample.tsv' \
    --output 'test_nextflow_output/' \
    --genome 'hg38' \
    --system 'macos' \
    --wd $(realpath .) \
    -resume 

