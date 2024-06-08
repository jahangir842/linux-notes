#!/bin/bash

# Directory containing files to checksum
directory="./files"
# Output checksum file
output_file="checksums.sha256"

# Check if the directory exists
if [[ ! -d "$directory" ]]; then
  echo "Directory $directory does not exist."
  exit 1
fi

# Clear the output file if it exists
> "$output_file"

# Loop through all files in the directory
for file in "$directory"/*; 
do
  # Check if it is a file
  if [[ -f "$file" ]]; then
    # Generate SHA256 checksum and append to the output file
    sha256sum "$file" >> "$output_file"
  fi
done

echo "Checksums have been written to $output_file"

