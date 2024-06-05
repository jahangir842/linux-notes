#!/bin/bash

# Function to calculate MD5 hash of a file
calculate_md5() {
    md5sum "$1" | awk '{print $1}'
}

# Directory to search for duplicates
directory="/path/to/your/directory"

# Find all files in the directory and calculate their MD5 hashes
find "$directory" -type f -exec md5sum {} + | sort | \
    awk 'BEGIN {prev_hash = ""} $1 == prev_hash {print $2} {prev_hash = $1}' | \
    while read -r file; do
        echo "Duplicate file: $file"
    done
