**Singularity containers** (now often referred to as **Apptainer**, though the original name "Singularity" is still widely recognized) are a type of containerization technology designed specifically for high-performance computing (HPC), scientific workflows, and environments where security and reproducibility are critical. Unlike general-purpose container platforms like Docker, Singularity is tailored to meet the needs of researchers, scientists, and system administrators working on shared, multi-user systems such as clusters or supercomputers.

Here’s a breakdown of what Singularity containers are, their key features, and how they differ from other container solutions.

---

### What Are Singularity Containers?
A Singularity container is a lightweight, portable, and self-contained software environment that encapsulates an application, its dependencies (libraries, binaries, etc.), and sometimes an entire operating system stack. Containers allow users to run software consistently across different systems without worrying about differences in underlying hardware, operating systems, or installed libraries.

Singularity was originally developed by Lawrence Berkeley National Laboratory and is now maintained as an open-source project (with its fork Apptainer managed by the Linux Foundation). It’s widely used in scientific computing, machine learning, and data analysis.

---

### Key Features of Singularity Containers
1. **No Root Privileges Required**:
   - Unlike Docker, which often requires root access to run containers, Singularity allows unprivileged users to execute containers. This is a huge advantage in HPC environments where users typically don’t have administrative rights.

2. **Security Focus**:
   - Singularity runs containers as the calling user, not as a privileged process. This reduces the risk of privilege escalation, making it safer for multi-user systems.

3. **Integration with HPC Systems**:
   - Designed for clusters and supercomputers, Singularity supports MPI (Message Passing Interface) for parallel computing, GPU access (e.g., NVIDIA GPUs), and integration with job schedulers like SLURM, PBS, or LSF.

4. **Single-File Images**:
   - Singularity uses a single-file image format (`.sif`, Singularity Image Format), which is immutable, reproducible, and easy to share or archive.

5. **Compatibility with Docker**:
   - Singularity can import and run Docker containers, converting them into its own format, making it versatile for users familiar with Docker workflows.

6. **Reproducibility**:
   - By bundling all dependencies into the container, Singularity ensures that software runs the same way regardless of the host environment—crucial for scientific experiments.

7. **Filesystem Isolation**:
   - While the container’s filesystem is isolated, Singularity binds the host’s home directory, `/tmp`, and other key directories by default, allowing seamless access to files outside the container.

---

### How Does Singularity Work?
- **Building a Container**: You define a container using a recipe file (e.g., `Singularity.def`), which specifies the base OS, dependencies, and setup commands. The `singularity build` command creates the `.sif` image.
- **Running a Container**: Use `singularity run`, `singularity exec`, or `singularity shell` to interact with the container. For example:
  - `singularity run myimage.sif`: Runs the default command in the container.
  - `singularity exec myimage.sif <command>`: Executes a specific command.
  - `singularity shell myimage.sif`: Opens an interactive shell inside the container.

---

### Singularity vs. Docker
| Feature                | Singularity                          | Docker                             |
|------------------------|--------------------------------------|------------------------------------|
| **Target Audience**    | HPC, scientific computing           | General-purpose, web/dev ops       |
| **Root Privileges**    | Not required                        | Often required (root daemon)       |
| **Security Model**     | User-space, no escalation           | Root daemon, potential risks       |
| **Image Format**       | Single `.sif` file                  | Layered images                     |
| **HPC Support**        | Native (MPI, GPU, schedulers)       | Limited without workarounds        |
| **Filesystem**         | Host integration by default         | Fully isolated by default          |

Docker is great for isolated, service-oriented applications (e.g., web servers), while Singularity shines in HPC where users need to run complex, resource-intensive workloads without compromising security.

---

### Example Use Case
Imagine you’re a researcher running a machine learning model that requires Python 3.8, specific CUDA libraries, and TensorFlow. Your university’s cluster has an older OS and no GPU support installed globally. With Singularity:
1. You create a container with Ubuntu, CUDA, and TensorFlow.
2. Build it into a `.sif` file.
3. Run it on the cluster, leveraging the GPU, without needing admin rights or altering the host system.

---

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
🧠 Explanation:

- /usr/local/go/bin contains the Go toolchain (go, gofmt, etc.)
- $GOPATH is where your Go projects and packages live.
- $GOPATH/bin contains binaries installed via go install.

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
tar -xzf singularity-ce-4.3.0.tar.gz
cd singularity-ce-4.3.0
```


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
