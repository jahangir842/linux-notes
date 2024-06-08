************************************************************
		       Checksum Auto
************************************************************
To create checksums for multiple files and save them in a single file, you can use a shell script with tools like `sha256sum`, `md5sum`, or `sha1sum`. Here's an example script to generate SHA256 checksums for all files in a directory and save them in a single checksum file.
************************************************************
Example Script
Create a script called `generate_checksums.sh` and write the following code:

************************************************************
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

************************************************************
#Step 2: Make the Script Executable
	chmod +x generate_checksums.sh
************************************************************
#Step 3: Run the Script
	./generate_checksums.sh
************************************************************
Explanation

- `directory="./files"`: This variable specifies the directory containing the files for which you want to generate checksums.
- `output_file="checksums.sha256"`: This variable defines the name of the output file where the checksums will be saved.
- `if [[ ! -d "$directory" ]]; then ... fi`: This block checks if the specified directory exists.
- `> "$output_file"`: This command clears the contents of the output file if it already exists.
- `for file in "$directory"/*; do ... done`: This loop iterates through all files in the specified directory.
- `if [[ -f "$file" ]]; then ... fi`: This block checks if the current item in the loop is a file.
- `sha256sum "$file" >> "$output_file"`: This command generates the SHA256 checksum of the file and appends it to the output file.
************************************************************
Example Directory Structure
.
├── generate_checksums.sh
└── files
    ├── file1.txt
    ├── file2.txt
    └── file3.txt
************************************************************
Running the Script
After running the script, the `checksums.sha256` file will contain the checksums of all files in the `files` directory:
************************************************************

$ cat checksums.sha256
e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855  ./files/file1.txt
d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2  ./files/file2.txt
b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3  ./files/file3.txt

************************************************************
Replace `sha256sum` with `md5sum` or `sha1sum` if you prefer a different checksum algorithm.
************************************************************
