# Installing CUDA on Ubuntu 22.04 (Step-by-Step Guide)

If you're doing GPU programming, machine learning, or any high-performance computing on an NVIDIA GPU, you'll need the **CUDA Toolkit**. Here's a clean, step-by-step guide for installing CUDA on **Ubuntu 22.04**.

Whether you're a data scientist or a developer playing with PyTorch or TensorFlow, this guide will get your system ready in no time.

---

## 🛠️ Step 1: Update Your System

Start with making sure your system is up to date.

```bash
sudo apt update && sudo apt upgrade -y
```

It's also good to ensure that required packages for building and installing drivers are present:

```bash
sudo apt install build-essential dkms -y
```

---

## 🎮 Step 2: Install the NVIDIA Graphics Drivers

Before installing CUDA, you need the correct **NVIDIA GPU driver**. Ubuntu 22.04 makes this easy using the `ubuntu-drivers` tool.

### 🔍 Detect available drivers:

```bash
ubuntu-drivers devices
```

You’ll see a list of recommended drivers for your GPU. Install the recommended one:

```bash
sudo ubuntu-drivers autoinstall
```

Then, **reboot** your system:

```bash
sudo reboot
```

### ✅ Verify the driver:

After rebooting, check if the driver is correctly installed:

```bash
nvidia-smi
```

You should see a table showing your GPU, driver version, and other info. If this works — your GPU is alive and ready 🎉

---

## 💾 Step 3: Install the CUDA Toolkit

Now for the fun part — installing the CUDA Toolkit. The best way to ensure compatibility is to download the **official installer** from NVIDIA.

Nvidia provides official [installation](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/) guide but here it is the summarized specifically for **Ubuntu 22.04**:

👉 Go to the official CUDA download page:

🔗 [https://developer.nvidia.com/cuda-downloads](https://developer.nvidia.com/cuda-downloads)

1. Select:
   - **Operating System**: Linux  
   - **Architecture**: x86_64  
   - **Distribution**: Ubuntu  
   - **Version**: 22.04  
   - **Installer Type**: **deb (local)**

2. Follow the instructions shown under *Installation Instructions*. It will look like this:

```bash
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-ubuntu2204.pin
sudo mv cuda-ubuntu2204.pin /etc/apt/preferences.d/cuda-repository-pin-600

sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/3bf863cc.pub

sudo add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/ /"

sudo apt update
sudo apt install cuda -y
```

---

## 🚀 Step 4: Add CUDA to Your Environment Variables

To use CUDA from the terminal, add it to your `PATH` and `LD_LIBRARY_PATH`.

```bash
echo 'export PATH=/usr/local/cuda/bin:$PATH' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH' >> ~/.bashrc
```

Apply the changes:

```bash
source ~/.bashrc
```

---

## ✅ Step 5: Verify CUDA Installation

Run the following to verify that CUDA is available:

```bash
nvcc --version
```

Sample output:

```
nvcc: NVIDIA (R) Cuda compiler driver
Copyright (c) 2005-2023 NVIDIA Corporation
Built on Thu_Sep_21_19:57:00_PDT_2023
Cuda compilation tools, release 12.3, V12.3.52
```

You can also test with the sample CUDA programs:

```bash
cuda-install-samples-12.3.sh ~/
cd ~/NVIDIA_CUDA-12.3_Samples/1_Utilities/deviceQuery
make
./deviceQuery
```

If it prints "Result = PASS", everything is good to go! ✅

---

## 🧹 Optional: Install cuDNN (for Deep Learning)

If you're using frameworks like **TensorFlow** or **PyTorch**, you'll likely need **cuDNN** (CUDA Deep Neural Network library).

1. Visit: [https://developer.nvidia.com/cudnn](https://developer.nvidia.com/cudnn)
2. Log in with your NVIDIA developer account.
3. Choose the cuDNN version that matches your installed CUDA version.
4. Follow installation instructions similar to CUDA.

---

## 🧠 Final Thoughts

You now have a fully working CUDA environment on Ubuntu 22.04! This setup supports deep learning frameworks, GPU-accelerated computing, and any CUDA-based development.

Need help with setting up PyTorch or TensorFlow next? Or want a Dockerized version of this setup? Drop a comment or message — I’ve got you covered.

---

Let me know if you'd like the same in Markdown format for GitHub or blog use!
