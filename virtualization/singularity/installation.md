### Installation

Reference: 
- https://github.com/sylabs/singularity/blob/main/INSTALL.md
- https://docs.sylabs.io/guides/3.0/user-guide/installation.html

### **Installing Go 1.24.1 on Linux**  

To install **Go 1.24.1** on Linux manually, follow these steps:

### **Step 1: Download Go 1.24.1**
Run the following command to download the Go binary package:  
```bash
wget https://go.dev/dl/go1.24.1.linux-amd64.tar.gz
```
*(Make sure to check [Go’s official website](https://go.dev/dl/) for the latest version.)*

### **Step 2: Remove Any Previous Go Installation**  
If you have an older version installed, remove it first:  
```bash
sudo rm -rf /usr/local/go
```

### **Step 3: Extract and Install Go**  
Extract the downloaded archive to `/usr/local`:  
```bash
sudo tar -C /usr/local -xzf go1.24.1.linux-amd64.tar.gz
```

### **Step 4: Configure Environment Variables**  
Add Go’s binary path to your shell profile (`~/.bashrc`, `~/.profile`, or `~/.zshrc`):  
```bash
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
echo 'export GOPATH=$HOME/go' >> ~/.bashrc
echo 'export PATH=$PATH:$GOPATH/bin' >> ~/.bashrc
source ~/.bashrc
```

---

### **Step 5: Verify Installation**  
Check if Go is installed correctly:  
```bash
go version
```
Expected output:  
```
go version go1.24.1 linux/amd64
```

---

### Singularity Installation:

### **Step 1: Update the System**
Before starting, ensure your system is up to date:
```bash
sudo apt-get update
sudo apt-get upgrade -y
```

### **Step 2: Install Dependencies**
Install the required dependencies for building Singularity:

```bash
# Ensure repositories are up-to-date
sudo apt-get update
# Install debian packages for dependencies
sudo apt-get install -y \
    autoconf \
    automake \
    cryptsetup \
    fuse2fs \
    git \
    fuse \
    libfuse-dev \
    libseccomp-dev \
    libtool \
    pkg-config \
    runc \
    squashfs-tools \
    squashfs-tools-ng \
    uidmap \
    wget \
    zlib1g-dev
```
### **Step 3: Install Aditional Dependencies**
On Ubuntu 24.04 and above install additional libsubid headers:

```bash
sudo apt-get install -y libsubid-dev
```

### **Step 4: Download Singularity Source Code**
Clone the SingularityCE repository from GitHub:
```bash
wget https://github.com/sylabs/singularity/releases/download/v4.3.0/singularity-ce-4.3.0.tar.gz
tar -xvzf singularity-ce-4.3.0.tar.gz
cd singularity-ce-4.3.0
```
- **Note**: you can use the different version from https://github.com/sylabs/singularity/releases

### **Step 5: Configure Singularity**
Run the configuration script to prepare the build:
```bash
./mconfig
```

If some error while configuring, then use this command:
```bash
./mconfig --without-libsubid
```

This will generate a `builddir` directory with the necessary build files.

---

### **Step 6: Build and Install Singularity**
1. Navigate to the `builddir` directory:
   ```bash
   cd builddir
   ```

2. Build Singularity:
   ```bash
   make
   ```

3. Install Singularity:
   ```bash
   sudo make install
   ```

---

### **Step 7: Verify the Installation**
Check that Singularity is installed correctly:
```bash
singularity --version
```

You should see output like:
```
singularity-ce version 4.3.0
```

---

### **Step 8: Test Singularity**
Run a simple test to ensure Singularity works:

1. Pull a test container:
   ```bash
   singularity pull docker://alpine
   ```

2. Run the container:
   ```bash
   singularity run alpine_latest.sif
   ```

You should see a shell inside the Alpine container.

---

### Singularity Today
In 2021, the original Singularity project split: Sylabs maintains a commercial version, while the open-source community version became **Apptainer**. Both are functionally similar, though Apptainer is more common in academic and open-source settings now. Commands remain largely the same, though you might see `apptainer` instead of `singularity` in newer documentation.

---

In short, Singularity containers provide a secure, portable, and HPC-friendly way to package and run software. They’re ideal for anyone needing reproducible workflows in environments where traditional container tools fall short. Let me know if you’d like a deeper dive into building or using them!
