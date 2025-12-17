#!/bin/bash
set -e

# Input arguments from Nextflow process
INPUT_FILE="$1"
REFERENCE="$2"
GTF="$3"
MEME="$4"
GENOME_INDEX="$5"
PARENT_DIR="$6"
TEMPLATE="$7"


# Create parent directory
mkdir -p "$PARENT_DIR"

tail -n +2 "$INPUT_FILE" | cut -f3 | sort -u | while read -r sample; do
    input_dir="${PARENT_DIR}/${sample}_taiji_inputs"
    mkdir -p "${input_dir}"
    output_dir="${sample}_taiji_outputs"
    mkdir -p "${output_dir}"

    custom_input="${sample}_input.tsv"
    OUTPUT_CONFIG="${input_dir}/${sample}_config.yml"

    # Get header
    header=$(head -n 1 "$INPUT_FILE")
    
    # Get rows for this sample
    echo "$header" > "${input_dir}/${custom_input}"
    grep "${sample}" "$INPUT_FILE" >> "${input_dir}/${custom_input}" || true
    
    tmp="${input_dir}/test_tmp"
    mkdir -p "$tmp"

    # Replace placeholders in the YAML file
    sed -e "s|\[insert_input_filepath_here\]|${custom_input}|g" \
        -e "s|\[insert_output_directory_here\]|${output_dir}|g" \
        -e "s|\[insert_tmp_directory_here\]|${tmp}|g" \
        -e "s|\[insert_genome_filepath_here\]|${REFERENCE}|g" \
        -e "s|\[insert_gtf_filepath_here\]|${GTF}|g" \
        -e "s|\[insert_genome_index_here\]|${GENOME_INDEX}|g" \
        -e "s|\[insert_motif_filepath_here\]|${MEME}|g" \
        "$TEMPLATE" > "$OUTPUT_CONFIG"
    
    echo "Created config for sample: $sample"
done

echo "All configuration files created successfully"
