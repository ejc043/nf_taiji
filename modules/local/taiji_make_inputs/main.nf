process TAIJI_MAKE_INPUTS {
    publishDir "${params.output}", mode: 'copy', pattern: '*_taiji_inputs'

    when: 
        params.genome != null
    
    input:
        path inputs
        path template
        path bin
    
    output: 
        path "*_taiji_inputs", emit: sample_dirs
    
    script:
    """
    reference=${params.wd}/database/${params.genome}/${params.genome}.fa
    gtf=${params.wd}/database/${params.genome}/${params.genome}.gtf
    meme=${params.wd}/database/${params.genome}/cisbp_human_2.meme
    genome_index=${params.wd}/database/${params.genome}/${params.genome}.index

    output_parent=$params.wd/outputs
    mkdir -p "\$output_parent"

    bash ${bin}/write_inputs.sh $inputs "\$reference" "\$gtf" "\$meme" "\$genome_index" "\$output_parent" "$template"

    mv "\$output_parent"/*_taiji_inputs .
    """
}

