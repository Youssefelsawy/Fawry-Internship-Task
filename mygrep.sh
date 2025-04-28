#!/bin/bash

# Initialize variables
show_line_numbers=false
invert_match=false
search_string=""
filename=""

display_help() {
    echo "Usage: mygrep.sh [OPTIONS] PATTERN [FILE]"
    echo "Search for PATTERN in FILE (case-insensitive)"
    echo ""
    echo "Options:"
    echo "  -n          Show line numbers"
    echo "  -v          Invert match (non-matching lines)"
    echo "  --help      Display this help"
    echo ""
    echo "Examples:"
    echo "  mygrep.sh hello file.txt"
    echo "  mygrep.sh -nv test file.txt"
    exit 0
}

# Handle --help before getopts
for arg in "$@"; do
    if [[ "$arg" == "--help" ]]; then
        display_help
    fi
done

# Parse options with getopts
while getopts ":nv" opt; do
    case "$opt" in
        n) show_line_numbers=true ;;
        v) invert_match=true ;;
        \?) echo "Error: Invalid option '-$OPTARG'" >&2; exit 1 ;;
    esac
done
shift $((OPTIND-1))

# Validate arguments
if [[ $# -lt 2 ]]; then
    echo "Error: Missing arguments" >&2
    display_help
    exit 1
fi

search_string="$1"
filename="$2"

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

    # Invert match if needed
    if [[ "$invert_match" == true ]]; then
        if [[ "$match" == true ]]; then
            match=false
        else
            match=true
        fi
    fi

    # Print results
    if [[ "$match" == true ]]; then
        if [[ "$show_line_numbers" == true ]]; then
            printf "%d:" "$line_number"
        fi
        printf "%s\n" "$line"
    fi
done < "$filename"

exit 0