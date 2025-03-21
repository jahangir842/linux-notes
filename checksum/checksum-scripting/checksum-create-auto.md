### Automating Checksum Generation

To create checksums for multiple files and store them in a single file, you can use a shell script with utilities like `sha256sum`, `md5sum`, or `sha1sum`. Below is a script that generates SHA256 checksums for all files in a specified directory and saves them in an output file.

---

### Example Script
Create a script named `generate_checksums.sh` and insert the following code:

```bash
#!/bin/bash

# Define the directory containing files to checksum
directory="./files"
# Define the output checksum file
output_file="checksums.sha256"

# Ensure the directory exists
if [[ ! -d "$directory" ]]; then
  echo "Error: Directory $directory does not exist."
  exit 1
fi

# Clear the output file if it exists
> "$output_file"

# Generate checksums for all files in the directory
for file in "$directory"/*; do
  if [[ -f "$file" ]]; then
    sha256sum "$file" >> "$output_file"
  fi
done

echo "Checksums have been saved in $output_file."
```

---

### Steps to Execute
#### 1. Make the Script Executable
```bash
chmod +x generate_checksums.sh
```

#### 2. Run the Script
```bash
./generate_checksums.sh
```

---

### Script Explanation
- `directory="./files"` → Specifies the folder containing files for checksum generation.
- `output_file="checksums.sha256"` → Defines the file where checksums will be stored.
- `if [[ ! -d "$directory" ]]; then ... fi` → Checks if the directory exists before proceeding.
- `> "$output_file"` → Clears the existing output file to prevent duplicate entries.
- `for file in "$directory"/*; do ... done` → Iterates over each file in the directory.
- `if [[ -f "$file" ]]; then ... fi` → Ensures that only files (not directories) are processed.
- `sha256sum "$file" >> "$output_file"` → Computes the SHA256 checksum and appends it to the output file.

---

### Example Directory Structure
```
.
├── generate_checksums.sh
└── files
    ├── file1.txt
    ├── file2.txt
    └── file3.txt
```

---

### Sample Output
After running the script, the `checksums.sha256` file will contain entries like:
```bash
$ cat checksums.sha256
e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855  ./files/file1.txt
d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2  ./files/file2.txt
b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3  ./files/file3.txt
```

---

### Customization
To use a different hashing algorithm, replace `sha256sum` with `md5sum` or `sha1sum`:
```bash
md5sum "$file" >> "$output_file"
```
```bash
sha1sum "$file" >> "$output_file"
```

This script helps automate checksum generation, ensuring file integrity verification in a simple and efficient manner.

