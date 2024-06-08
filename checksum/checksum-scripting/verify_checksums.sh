#!/bin/bash

# Checksum file
checksum_file="checksums.sha256"

# Check if the checksum file exists
if [[ ! -f "$checksum_file" ]]; then
  echo "Checksum file $checksum_file does not exist."
  exit 1
fi

# Verify the checksums
sha256sum --check "$checksum_file"

# Capture the result
if [[ $? -eq 0 ]]; then
  echo "All checksums are correct."
else
  echo "Some checksums are incorrect."
  exit 1
fi

