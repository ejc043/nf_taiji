process EXTRACT_NETWORK_FILES {
    input:
        tuple val(sample_id), path(taiji_output)
    
    output:
        path "${sample_id}_edges_combined.csv", emit: network_files, optional: true
    
    script:
    """
    ln -s ${taiji_output}/Network/${sample_id}/edges_combined.csv ${sample_id}_edges_combined.csv
    """
}

