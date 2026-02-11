process RUN_TAIJI {
    publishDir "${params.output}/taiji_results/${sample_id}", 
        mode: 'copy'

    input:
        tuple val(sample_id), path(sample_dir), val(binary_path)
    
    output:
        tuple val(sample_id), path("${sample_dir}/${sample_id}_taiji_outputs"), emit: results
    
    script:
    """
    echo "=========================================="
    echo "Processing ${sample_id} with native binary"
    echo "Allocated CPUs: ${task.cpus}"
    echo "Allocated Memory: ${task.memory}"
    echo "Binary path: ${binary_path}"
    echo "=========================================="
    cd ${sample_dir}
    ${binary_path} run --config ${sample_id}_config.yml -n 12 +RTS -N${task.cpus}
    """
}
