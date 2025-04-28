#!/bin/bash

# Initialize variables
show_line_numbers=false
invert_match=false
search_string=""
filename=""

# Function to display help
display_help() {
    echo "Usage: mygrep.sh [OPTIONS] PATTERN [FILE]"
    echo "Search for PATTERN in FILE."
    echo ""
    echo "Options:"
    echo "  -n          show line numbers"
    echo "  -v          invert match (show non-matching lines)"
    echo "  --help      display this help and exit"
    echo ""
    echo "Examples:"
    echo "  mygrep.sh hello file.txt      # Search for 'hello' in file.txt"
    echo "  mygrep.sh -n hello file.txt   # Show line numbers with matches"
    echo "  mygrep.sh -v hello file.txt   # Show lines that don't contain 'hello'"
    exit 0
}

# Parse command line options
while [[ $# -gt 0 ]]; do
    case "$1" in
        --help)
            display_help
            ;;
        -n)
            show_line_numbers=true
            shift
            ;;
        -v)
            invert_match=true
            shift
            ;;
        -nv|-vn)
            show_line_numbers=true
            invert_match=true
            shift
            ;;
        -*)
            echo "Error: Unknown option $1" >&2
            exit 1
            ;;
        *)
            # First non-option argument is the search string
            if [[ -z "$search_string" ]]; then
                search_string="$1"
            else
                # Second non-option argument is the filename
                if [[ -z "$filename" ]]; then
                    filename="$1"
                else
                    echo "Error: Too many arguments" >&2
                    exit 1
                fi
            fi
            shift
            ;;
    esac
done

# Validate input
if [[ -z "$search_string" ]]; then
    echo "Error: Missing search string" >&2
    echo "Usage: mygrep.sh [OPTIONS] PATTERN [FILE]" >&2
    exit 1
fi

if [[ -z "$filename" ]]; then
    echo "Error: Missing filename" >&2
    echo "Usage: mygrep.sh [OPTIONS] PATTERN [FILE]" >&2
    exit 1
fi

if [[ ! -f "$filename" ]]; then
    echo "Error: File '$filename' not found" >&2
    exit 1
fi

# Perform the search
line_number=0
while IFS= read -r line; do
    ((line_number++))
    
    # Case-insensitive match
    if [[ "${line,,}" == *"${search_string,,}"* ]]; then
        match=true
    else
        match=false
    fi
    
    # Handle invert match option (FIXED)
    if [[ $invert_match == true ]]; then
        if [[ $match == true ]]; then
            match=false
        else
            match=true
        fi
    fi
    
    # Print if matched
    if [[ $match == true ]]; then
        if [[ $show_line_numbers == true ]]; then
            printf "%d:" "$line_number"
        fi
        printf "%s\n" "$line"
    fi
done < "$filename"

exit 0
