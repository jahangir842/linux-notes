## **1. Install NVIDIA Drivers**
Ensure that your host machine has NVIDIA drivers installed.

Check the installed drivers:
```bash
nvidia-smi
```
If not installed, install them [using](https://github.com/jahangir842/linux-notes/blob/main/drivers/ubuntu/nvidia-graphics-drivers.md):

---

## **2. Install NVIDIA Container Toolkit**
To enable GPU access in Docker, install the **NVIDIA Container Toolkit**.

### **Ubuntu (Debian-based)**
```bash
curl -fsSL https://nvidia.github.io/nvidia-container-runtime/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-runtime-keyring.gpg
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-container-runtime/$distribution/nvidia-container-runtime.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-runtime-keyring.gpg] https://#' | \
    sudo tee /etc/apt/sources.list.d/nvidia-container-runtime.list
sudo apt update
sudo apt install -y nvidia-container-toolkit
sudo systemctl restart docker
```

### **RHEL/CentOS**
```bash
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-container-runtime/$distribution/nvidia-container-runtime.repo | sudo tee /etc/yum.repos.d/nvidia-container-runtime.repo
sudo yum install -y nvidia-container-toolkit
sudo systemctl restart docker
```

---

## **3. Verify GPU Support in Docker**
Run the following command to check if Docker can detect the GPU:
```bash
docker run --rm --gpus all nvidia/cuda:12.8.1-cudnn-devel-ubuntu22.04 nvidia-smi
```
This should output details about your GPU.

---

## **4. Use GPU in Docker Containers**
### **Run a container with GPU access**
```bash
docker run --rm --gpus all ubuntu nvidia-smi
```
or specify a specific GPU (e.g., GPU `0`):
```bash
docker run --rm --gpus '"device=0"' ubuntu nvidia-smi
```

### **Use NVIDIA runtime in `docker-compose.yml`**
```yaml
version: '3.8'
services:
  my_app:
    image: nvidia/cuda:12.8.1-cudnn-devel-ubuntu22.04
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: all
              capabilities: [gpu]
```
Run:
```bash
docker-compose up
```

---

## **5. Check GPU in Running Container**
After starting a container, you can check GPU usage inside it:
```bash
docker exec -it <container_id> nvidia-smi
```

Let me know if you need further assistance! 🚀
