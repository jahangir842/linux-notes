To run a GPU within a Singularity container, you need to ensure that:

1. **NVIDIA drivers** are installed on the host system.
2. **NVIDIA Container Toolkit** is installed on the host system.
3. The Singularity container has the necessary CUDA and GPU libraries.

Here’s a step-by-step guide to running a GPU within a Singularity container:

---

### **Step 1: Verify NVIDIA Drivers and CUDA on the Host**
1. Check that the NVIDIA drivers are installed:
   ```bash
   nvidia-smi
   ```
   This should display information about your GPU(s).

2. Verify CUDA installation (optional):
   ```bash
   nvcc --version
   ```

---

### **Step 2: Install NVIDIA Container Toolkit**
- https://github.com/jahangir842/docker-notes/tree/main/gpu

If you haven’t already installed the NVIDIA Container Toolkit, follow these steps:

1. Add the NVIDIA repository:
   ```bash
   distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
   curl -s -L https://nvidia.github.io/nvidia-container-runtime/gpgkey | sudo apt-key add -
   curl -s -L https://nvidia.github.io/nvidia-container-runtime/$distribution/nvidia-container-runtime.list | sudo tee /etc/apt/sources.list.d/nvidia-container-runtime.list
   sudo apt-get update
   ```

2. Install the NVIDIA Container Toolkit:
   ```bash
   sudo apt-get install -y nvidia-container-toolkit
   ```

3. Restart Docker (if applicable):
   ```bash
   sudo systemctl restart docker
   ```

---

### **Step 3: Build or Pull a GPU-Enabled Singularity Container**
You can either:
- Pull a pre-built GPU-enabled container from a registry (e.g., Docker Hub).
- Build your own GPU-enabled container.

#### **Option 1: Pull a Pre-Built GPU-Enabled Container**
Singularity can pull containers directly from Docker Hub. For example, to pull an NVIDIA CUDA container:
```bash
singularity pull docker://nvidia/cuda:12.8.1-cudnn-devel-ubuntu22.04
```
This will create a Singularity image file (e.g., `cuda_12.2.2-base.sif`).

#### **Option 2: Build Your Own GPU-Enabled Container**
1. Create a `Singularity` definition file (e.g., `gpu.def`):
   ```bash
   Bootstrap: docker
   From: nvidia/cuda:12.2.2-base

   %post
       # Install additional dependencies if needed
       apt-get update && apt-get install -y \
           python3 \
           python3-pip

       # Install PyTorch with GPU support
       pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118

   %environment
       export PATH=/usr/local/cuda/bin:$PATH
       export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH

   %labels
       Author YourName
       Version v1.0
   ```

2. Build the container:
   ```bash
   sudo singularity build gpu.sif gpu.def
   ```

---

### **Step 4: Run the GPU-Enabled Container**
To run the container with GPU support, use the `--nv` flag, which binds the NVIDIA drivers and libraries from the host into the container.

1. Run the container interactively:
   ```bash
   singularity shell --nv cuda_12.2.2-base.sif
   ```

2. Run a command inside the container:
   ```bash
   singularity exec --nv cuda_12.2.2-base.sif nvidia-smi
   ```

3. Run a Python script with GPU support:
   ```bash
   singularity exec --nv gpu.sif python3 -c "import torch; print(torch.cuda.is_available())"
   ```

---

### **Step 5: Verify GPU Access**
1. Check GPU availability inside the container:
   ```bash
   singularity exec --nv cuda_12.2.2-base.sif nvidia-smi
   ```

2. Test PyTorch GPU support (if installed):
   ```bash
   singularity exec --nv gpu.sif python3 -c "import torch; print(torch.cuda.is_available())"
   ```
   This should return `True`.

---

### **Step 6: Run a GPU Workload**
If you have a GPU-enabled application or script, you can run it inside the container. For example:

1. Create a Python script (`gpu_test.py`):
   ```python
   import torch

   # Check if CUDA is available
   if torch.cuda.is_available():
       device = torch.device("cuda")
       print("CUDA is available. Using GPU.")
   else:
       device = torch.device("cpu")
       print("CUDA is not available. Using CPU.")

   # Perform a simple computation on the GPU
   x = torch.tensor([1.0, 2.0, 3.0]).to(device)
   y = torch.tensor([4.0, 5.0, 6.0]).to(device)
   z = x + y
   print(z)
   ```

2. Run the script inside the container:
   ```bash
   singularity exec --nv gpu.sif python3 gpu_test.py
   ```

---

### **Troubleshooting**
1. **`nvidia-smi` Not Found**:
   - Ensure the NVIDIA Container Toolkit is installed and the `--nv` flag is used.

2. **CUDA Not Available**:
   - Verify that the container has the correct CUDA version and GPU libraries.
   - Ensure the host system has compatible NVIDIA drivers.

3. **Permission Errors**:
   - Run Singularity with `sudo` if necessary.

---

By following these steps, you can successfully run GPU workloads within a Singularity container. Let me know if you encounter any issues!
