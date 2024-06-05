import os
import hashlib

def find_duplicates(directory):
    # Dictionary to store file hashes and their corresponding paths
    hash_dict = {}

    # Traverse the directory
    for root, dirs, files in os.walk(directory):
        for filename in files:
            filepath = os.path.join(root, filename)
            # Calculate hash for each file
            with open(filepath, 'rb') as f:
                file_hash = hashlib.md5(f.read()).hexdigest()

            # Add hash and file path to dictionary
            if file_hash in hash_dict:
                hash_dict[file_hash].append(filepath)
            else:
                hash_dict[file_hash] = [filepath]

    # Filter out unique files
    duplicates = {hash: paths for hash, paths in hash_dict.items() if len(paths) > 1}

    return duplicates

# Example usage
directory = './'
duplicates = find_duplicates(directory)

if duplicates:
    print("Duplicate files found:")
    for hash, paths in duplicates.items():
        print(f"Hash: {hash}")
        for path in paths:
            print(f" - {path}")
else:
    print("No duplicate files found.")
