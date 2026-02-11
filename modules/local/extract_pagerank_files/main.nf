process EXTRACT_PAGERANK_FILES {
    input:
        tuple val(sample_id), path(taiji_output)
    
    output:
        path "${sample_id}_GeneRanks.tsv", emit: pagerank_files, optional: true
    
    script:
    """
    ln -s ${taiji_output}/GeneRanks.tsv ${sample_id}_GeneRanks.tsv
    """
}

