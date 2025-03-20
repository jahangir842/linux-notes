To install the **NVIDIA Container Toolkit** on an offline PC, follow these steps:

---

## **1. Download Required Packages on an Online PC**
Since your target system is offline, you need to download all required packages on a machine with internet access.

### **Step 1: Determine Your OS and Docker Version**
Run the following on the offline machine:
```bash
lsb_release -a   # Check OS version
docker --version # Check Docker version
```

### **Step 2: Download NVIDIA Container Toolkit Packages**
On an online machine, download the required `.deb` or `.rpm` packages:

https://github.com/NVIDIA/nvidia-container-toolkit/releases

---

## **2. Transfer Packages to the Offline PC**
Copy the downloaded `.deb` or `.rpm` files to the offline PC using a USB drive, SCP, or any other method.

Example using SCP:
```bash
scp *.deb user@offline-pc:/home/user/
```

---

## **3. Install the Packages on the Offline PC**
Once transferred, install them:

#### **For Ubuntu/Debian**
```bash
cd /home/user/
sudo dpkg -i *.deb
```
If there are missing dependencies, install them manually:
```bash
sudo apt-get install -f
```

#### **For RHEL/CentOS/Rocky Linux**
```bash
cd /home/user/
sudo rpm -ivh *.rpm
```
If there are missing dependencies, manually download and install them.

---

## **4. Configure Docker to Use NVIDIA Runtime**
Edit the Docker daemon config file:
```bash
sudo nano /etc/docker/daemon.json
```
Add or modify it to include:
```json
{
    "runtimes": {
        "nvidia": {
            "path": "/usr/bin/nvidia-container-runtime",
            "runtimeArgs": []
        }
    }
}
```

Save and exit.

Restart Docker:
```bash
sudo systemctl restart docker
```

---

## **5. Test GPU Access in Docker**
Run:
```bash
docker run --rm --gpus all nvidia/cuda:12.2.0-base-ubuntu22.04 nvidia-smi
```

If successful, you should see your GPU details.

---

### **Alternative: Use a Local Package Repository (Advanced)**
If you need to install multiple packages with dependencies, you can set up a local package repository using `dpkg-scanpackages` (for Debian-based systems) or `createrepo` (for RPM-based systems).

Let me know if you need further guidance! 🚀
