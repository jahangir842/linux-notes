# ⚙️ NVIDIA TAO CLI Installation Guide

The **TAO CLI** provides a Docker-based command-line interface to access NVIDIA TAO Toolkit functionalities. This guide covers the installation and configuration of the TAO CLI on Ubuntu systems.

---

## 📋 Prerequisites

* **Operating System:** Ubuntu 20.04+ (Ubuntu 22.04 recommended)
* **NVIDIA GPU:** CUDA-capable GPU with proper drivers installed
* **Docker:** Installed and configured with NVIDIA Container Toolkit
* **NGC CLI:** Installed and configured for authentication

---

## 🛠 Installation Steps

### Step 1: Install Docker and NVIDIA Container Toolkit

Update package list and install Docker CE:

```bash
sudo apt update
sudo apt install -y docker.io
sudo systemctl enable --now docker
```

Add your user to the Docker group:

```bash
sudo usermod -aG docker $USER
newgrp docker
```

Install NVIDIA Container Toolkit:

```bash
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt update
sudo apt install -y nvidia-docker2
sudo systemctl restart docker
```

Verify installation:

```bash
docker run --rm --gpus all nvidia/cuda:11.0-base nvidia-smi
```

---

### Step 2: Download TAO CLI Docker Image

Login to NVIDIA NGC:

```bash
docker login nvcr.io
```

Pull the latest TAO CLI container image:

```bash
docker pull nvcr.io/nvidia/tao/tao-toolkit:<version>
```

- Replace `<version>` with the desired TAO Toolkit version tag. you can check it from https://catalog.ngc.nvidia.com/orgs/nvidia/teams/tao/containers/tao-toolkit

### Example Enterprise Container (Paid):

```bash
docker pull nvcr.io/nvidia/tao/texttospeech_notebook:v1.1
```

### Example Enterprise Container (Paid):

```bash
docker pull nvcr.io/nvidia/nvhpc:25.5-devel-cuda12.9-ubuntu22.04
```

---

### Step 3: Running TAO CLI Container

Run the TAO CLI container with GPU access and mounting your working directory:

```bash
docker run --gpus all --rm -it \
  -v /path/to/your/data:/workspace/data \
  nvcr.io/nvidia/tao/tao-toolkit:<version> /bin/bash
```

This starts an interactive shell inside the container with your data accessible at `/workspace/data`.

---

## ✅ Usage Example

Once inside the container shell, you can run TAO CLI commands, for example:

```bash
tao detectnet_v2 train -e /workspace/data/experiment_spec.yaml
```

---

## 🔧 Configuration Tips

* Map local directories for datasets and model checkpoints via Docker volume mounts.
* Persist configuration and cache by mounting a local directory to `/root/.tao` inside the container.
* Use `docker-compose` for more complex workflows and easier container management.

---

## 🆘 Troubleshooting

* **Permission denied running Docker:** Confirm your user is added to the Docker group and re-login.
* **GPU not found in container:** Verify NVIDIA drivers, CUDA, and NVIDIA Container Toolkit installation.
* **NGC CLI authentication issues:** Confirm `ngc` CLI is installed and authenticated correctly.

---

## 🔗 Additional Resources

* [NVIDIA TAO Toolkit Documentation](https://docs.nvidia.com/tao)
* [NVIDIA NGC CLI Installation Guide](https://docs.nvidia.com/ngc/ngc-cli-install-guide/index.html)
* [Docker Documentation](https://docs.docker.com/)
* [NVIDIA Container Toolkit Documentation](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html)

---
