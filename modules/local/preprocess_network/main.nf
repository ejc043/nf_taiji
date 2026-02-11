process PREPROCESS_NETWORK {
    publishDir "${params.output}", mode: 'copy'
    
    input: 
        path inputs 
        path edge_files
    
    output: 
        path "filtered_edges_combined.csv", emit: filtered_network
    
    script:
    '''
    num_samples=$(cat *tsv | grep RNA-seq | wc -l)
    lim=$((num_samples / 10))

    cat *_edges_combined.csv | awk -F"," '{print $1"_"$2}' | sort | uniq -c | awk -v threshold="$lim" '$1 >= threshold' | sed 's/^[[:space:]]*//' | awk '{print $1"\t"$2}' > parent_filt.csv

    awk -F"," 'NR==FNR {FS="\t"; freq[$2]=$1; next} {FS=","; key=$1"_"$2} key in freq {print $0","FILENAME","freq[key]}' parent_filt.csv *_edges_combined.csv > filtered_edges_combined.csv
    '''
}

