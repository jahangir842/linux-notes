# **Linux Compression Tools**  

---

## **1. Introduction**  
Compression tools in Linux are used to reduce file sizes for storage efficiency or faster transfers. This document covers common compression utilities, their usage, and comparisons.

---

## **2. Common Compression Tools**  

### **A. `gzip` (`.gz` files)**  
- **Description**: Fast compression, widely used.  
- **Installation**: Pre-installed on most Linux distros.  
- **Usage**:  
  ```sh
  # Compress a file (original file is replaced)
  gzip file.txt

  # Decompress a file
  gunzip file.txt.gz

  # Keep original file
  gzip -k file.txt

  # Set compression level (1-9, 9=max)
  gzip -9 file.txt
  ```

### **B. `bzip2` (`.bz2` files)**  
- **Description**: Better compression than `gzip` but slower.  
- **Usage**:  
  ```sh
  # Compress a file
  bzip2 file.txt

  # Decompress a file
  bunzip2 file.txt.bz2

  # Keep original file
  bzip2 -k file.txt
  ```

### **C. `xz` (`.xz` files)**  
- **Description**: High compression ratio (better than `gzip`/`bzip2`), slower.  
- **Usage**:  
  ```sh
  # Compress a file
  xz file.txt

  # Decompress a file
  unxz file.txt.xz

  # Keep original file
  xz -k file.txt
  ```

### **D. `zip`/`unzip` (`.zip` files)**  
- **Description**: Cross-platform (Windows/Linux/macOS).  
- **Usage**:  
  ```sh
  # Create a zip file
  zip archive.zip file1.txt file2.txt

  # Extract a zip file
  unzip archive.zip

  # Extract to a specific directory
  unzip archive.zip -d /path/to/dir
  ```

### **E. `tar` (Tape Archive - `.tar`, `.tar.gz`, `.tar.xz`)**  
- **Description**: Combines multiple files into one archive (optionally compressed).  
- **Common flags**:  
  - `-c`: Create archive  
  - `-x`: Extract archive  
  - `-v`: Verbose output  
  - `-f`: Specify filename  
  - `-z`: Use `gzip` compression  
  - `-j`: Use `bzip2` compression  
  - `-J`: Use `xz` compression  

#### **Examples**  
```sh
# Create a tar archive (uncompressed)
tar -cvf archive.tar file1.txt file2.txt

# Extract a tar archive
tar -xvf archive.tar

# Create a compressed tar.gz (gzip)
tar -czvf archive.tar.gz file1.txt file2.txt

# Extract a tar.gz
tar -xzvf archive.tar.gz

# Create a tar.xz (xz compression)
tar -cJvf archive.tar.xz file1.txt file2.txt

# Extract a tar.xz
tar -xJvf archive.tar.xz
```

---

## **3. Comparison of Compression Tools**  

| Tool   | Extension | Compression Speed | Decompression Speed | Compression Ratio | Best For |
|--------|----------|------------------|---------------------|------------------|----------|
| `gzip` | `.gz`    | Fast             | Fast                | Moderate         | General use |
| `bzip2`| `.bz2`   | Slower           | Moderate            | Better than `gzip` | Large files |
| `xz`   | `.xz`    | Slowest          | Slow                | Best             | Archival |
| `zip`  | `.zip`   | Moderate         | Moderate            | Moderate         | Cross-platform |

---

## **4. Advanced Usage**  

### **A. Compressing Directories**  
```sh
# Using tar + gzip
tar -czvf backup.tar.gz /path/to/dir

# Using zip
zip -r archive.zip /path/to/dir
```

### **B. Listing Contents Without Extracting**  
```sh
# For tar archives
tar -tf archive.tar

# For zip files
unzip -l archive.zip
```

### **C. Parallel Compression (Faster)**  
- **`pigz`** (parallel `gzip`):  
  ```sh
  sudo apt install pigz  # Install
  pigz -9 file.txt       # Compress with max level
  ```

- **`pbzip2`** (parallel `bzip2`):  
  ```sh
  sudo apt install pbzip2
  pbzip2 -9 file.txt
  ```

---

## **5. Conclusion**  
- Use **`gzip`** for general-purpose compression (fast, moderate ratio).  
- Use **`bzip2`** or **`xz`** for better compression (slower).  
- Use **`zip`** for cross-platform sharing.  
- Use **`tar` + compression** for archiving multiple files.  

For maximum speed, consider **parallel tools (`pigz`, `pbzip2`)**.  

---

## **6. References**  
- GNU `gzip` Manual: `man gzip`  
- `bzip2` Docs: `man bzip2`  
- `xz` Documentation: `man xz`  
- `tar` Guide: `man tar`  

---

**📝 Notes**:  
- Always verify compressed files (`sha256sum`, `md5sum`).  
- For large backups, consider **split + compress** (`split` + `tar`).  

---
