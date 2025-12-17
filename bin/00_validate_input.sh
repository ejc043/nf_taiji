#!/bin/bash
input_file=$1


### expected format
expected_header="type	id	group	rep	path	tags	format	cohort"
header_line="$(head -1 "$input_file")"
if [ "$header_line" != "$expected_header" ]; then
  echo "Error: Header does not match expected columns. Are they in the same order and spelled correctly?"
  echo "Found:   $header_line"
  echo "Expected: $expected_header"
  exit 1
fi

### no quotes
grep -n -e '"' -e "'" "$input_file"
if [ $? -eq 0 ]; then
  echo "Error: found quotes in the file."
  exit 1
fi

## verify for each assay there are the same number of samples 
counts=$(cat $input_file | tail -n +2  | awk -F"\t" '{print $1}'  | sort | uniq -c | sort -nr | awk -F" " '{print $1}' | sort -u | wc -l)
if [ $counts -ne 1 ] ; then 
    echo "Error: different number of samples per assay found."
    cat $input_file | tail -n +2  | awk -F"\t" '{print $1}'  | sort | uniq -c
    exit 1
fi
echo "Input file validation passed."
