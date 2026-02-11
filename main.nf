#!/usr/bin/env nextflow
nextflow.enable.dsl=2

// Import all modules  
include { TAIJI_BASIC_VERIFY_INPUT } from './modules/local/taiji_verify_input'
include { TAIJI_MAKE_INPUTS } from './modules/local/taiji_make_inputs'
include { RUN_TAIJI } from './modules/local/run_taiji'
include { RUN_TAIJI_SINGULARITY } from './modules/local/run_taiji_singularity'
include { EXTRACT_NETWORK_FILES } from './modules/local/extract_network_files'
include { EXTRACT_PAGERANK_FILES } from './modules/local/extract_pagerank_files'
include { PREPROCESS_NETWORK } from './modules/local/preprocess_network'

// Parameters and initialization
params.inputs = null 
params.output = null
params.genome = null
params.wd = null
params.bin = "bin"
params.template = "database/taiji_config_formulafile.yml"
params.system = null

// System-specific binary selection using workflow variable
def getBinaryPath() {
    if (params.system == 'macos'){
        return file("${workflow.projectDir}/binaries/taiji-macOS-Catalina-10.15").toString()
    } else if (params.system == 'centos'){
        return file("${workflow.projectDir}/binaries/taiji-CentOS-x86_64").toString()
    } else if (params.system == 'ubuntu'){
        return file("${workflow.projectDir}/binaries/taiji-Ubuntu-x86_64").toString()
    } else if (params.system == 'singularity'){
        return file("${workflow.projectDir}/binaries/taiji.1.3.0.sif").toString()
    }
}

def binary_path = getBinaryPath()
println "Binary path: ${binary_path}"
println "Inputs: ${params.inputs}"

workflow {
    input_ch = Channel.fromPath(params.inputs, checkIfExists: true)
    bin_ch = Channel.fromPath(params.bin, checkIfExists: true)
    template_ch = Channel.fromPath(params.template, checkIfExists: true)
    
    TAIJI_BASIC_VERIFY_INPUT(input_ch, bin_ch)
    
    taiji_inputs = TAIJI_MAKE_INPUTS(input_ch, template_ch, bin_ch)
    
    sample_dirs = taiji_inputs
        .flatten()
        .map { dir -> 
            def sample_id = dir.name.replaceAll('_taiji_inputs$', '')
            return tuple(sample_id, dir, binary_path)  // Add binary_path to tuple
        }

    // Conditional execution based on params.system
    if (params.system == 'singularity') {
        taiji_output = RUN_TAIJI_SINGULARITY(sample_dirs)
    } else {
        taiji_output = RUN_TAIJI(sample_dirs)
    }
    
    extract_outputs = EXTRACT_NETWORK_FILES(taiji_output)
    files_ch = extract_outputs.network_files
        .view { "Found network file: $it" }
    
    all_network_files = files_ch.collect()
    
    PREPROCESS_NETWORK(input_ch, all_network_files)
}
