process TAIJI_BASIC_VERIFY_INPUT {
    input:
        path inputs
        path bin 
    
    output:
        stdout
    
    script:
    """
    set -e 
    ${bin}/00_validate_input.sh $inputs
    echo "Validation passed for $inputs"
    """
}

