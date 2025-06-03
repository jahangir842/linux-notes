# 🧰 NVIDIA TAO Launcher Installation Guide

The **TAO Launcher** provides a convenient Python virtual environment to run TAO Toolkit commands locally without requiring Docker directly. This guide outlines the steps to install and configure the TAO Launcher on a supported Linux system.

---

**Official Guide:** https://www.youtube.com/watch?v=kErfKDZ50To&list=PL5B692fm6--uVOY7csa54jjkjE1NYf1Un

---

## 📋 Prerequisites

* **Operating System:** Ubuntu 20.04+ (Ubuntu 22.04 recommended)
* **NVIDIA GPU:** CUDA-capable GPU with appropriate drivers installed
* **Python:** Version 3.8 to 3.10 installed
* **CUDA Toolkit and cuDNN:** Compatible versions installed and configured
* **NVIDIA Container Toolkit:** For any containerized workflow dependencies
* **NGC CLI:** Installed and configured (for downloading pretrained models and specs)

---

## 🛠 Installation Steps

### Step 1: Prepare System Dependencies

Update package lists and install required system packages:

```bash
sudo apt update && sudo apt install -y python3-venv python3-pip git
```

Ensure NVIDIA drivers and CUDA toolkit are installed and properly configured:

```bash
nvidia-smi
```

Should display GPU status without error.

---

### Step 2: Create Python Virtual Environment

Create a directory for the TAO Launcher virtual environment, e.g.:

```bash
sudo mkdir -p /opt/tao-venv
sudo chown $USER:$USER /opt/tao-venv
python3 -m venv /opt/tao-venv
```

---

### Step 3: Activate the Virtual Environment and Install TAO Packages

Activate the environment:

```bash
source /opt/tao-venv/bin/activate
```

Upgrade pip and install required Python packages for TAO Launcher (replace with the latest versions as needed):

```bash
pip install --upgrade pip setuptools wheel
pip install nvidia-tao-toolkit
```

---

### Step 4: Configure Environment Variables

Ensure the environment variables for CUDA and TAO CLI are set correctly. Add the following lines to your shell profile (`~/.bashrc` or `~/.zshrc`):

```bash
export PATH=/opt/tao-venv/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
```

Reload the profile:

```bash
source ~/.bashrc
```

---

### Step 5: Verify Installation

Check that `tao` command is available:

```bash
tao --help
```

This should display TAO CLI usage and commands.

---

## ⚙️ Post-Installation Notes

* Keep your virtual environment up to date by periodically running:

```bash
source /opt/tao-venv/bin/activate
pip install --upgrade nvidia-tao-toolkit
```

* For managing GPU dependencies and Docker workflows, ensure the NVIDIA Container Toolkit and Docker are installed and configured.

---

## 🆘 Troubleshooting

* **Command not found:** Ensure the virtual environment is activated and `$PATH` includes `/opt/tao-venv/bin`.
* **CUDA errors:** Verify NVIDIA drivers and CUDA versions are compatible and correctly installed.
* **Permission issues:** Confirm you have appropriate permissions on `/opt/tao-venv`.

---

## 🔗 Additional Resources

* [NVIDIA TAO Toolkit Documentation](https://docs.nvidia.com/tao)
* [NVIDIA NGC CLI Installation Guide](https://docs.nvidia.com/ngc/ngc-cli-install-guide/index.html)
* [NVIDIA Developer Forums](https://forums.developer.nvidia.com/)

---
