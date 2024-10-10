## NVIDIA drivers installation

Here’s a rewritten version of the instructions:

1. **Install Recommended Drivers**: 
   - Open "Additional Drivers" in Ubuntu and install the recommended drivers for your NVIDIA GPU.

2. **Install NVIDIA Toolkit**: 
   - Download and install the NVIDIA CUDA Toolkit from [here](https://developer.nvidia.com/cuda-downloads).

3. **Set Environment Variables**: 
   - Follow this guide to configure the necessary environment variables: [Setting up NVIDIA Drivers and CUDA](https://medium.com/@mertguvencli/how-to-setup-nvidia-driver-cuda-toolkit-and-cudnn-in-ubuntu-20-4-ac5efedb4427).

4. **Download cuDNN**: 
   - Download cuDNN from the [NVIDIA cuDNN Archive](https://developer.nvidia.com/rdp/cudnn-archive).

5. **Install zlib and cuDNN**: 
   - Install zlib and then install cuDNN by following the steps in the [NVIDIA cuDNN Installation Guide](https://docs.nvidia.com/deeplearning/cudnn/archives/cudnn-895/install-guide/index.html).

## Mannually Installation:

https://ubuntu.com/server/docs/nvidia-drivers-installation#nvidia-drivers-releases

https://www.nvidia.com/en-us/geforce/drivers/

### NVIDIA drivers releases 

NVIDIA package two types of NVIDIA drivers:

**Unified Driver Architecture (UDA) drivers** - which are recommended for the generic desktop use, and which you can also find on the NVIDIA website.

**Enterprise Ready Drivers (ERD)** - which are recommended on servers and for computing tasks. Their packages can be recognised by the -server suffix. You can read more about these drivers in the NVIDIA documentation.


### Check driver versions

To check the version of your currently running driver:
```
cat /proc/driver/nvidia/version
```

### Check Configuration

cat /lib/modprobe.d/nvidia-graphics-drivers.conf

The output will be like this:
```
blacklist nouveau
blacklist lbm-nouveau
alias nouveau off
alias lbm-nouveau off
```


### Check the available drivers for your hardware

**For desktop:**

```
sudo ubuntu-drivers list


ubuntu-drivers devices
```

**for servers:**

```
sudo ubuntu-drivers list --gpgpu

```
You should see a list such as the following:
```

nvidia-driver-470
nvidia-driver-470-server
nvidia-driver-535
nvidia-driver-535-open
nvidia-driver-535-server
nvidia-driver-535-server-open
nvidia-driver-550
nvidia-driver-550-open
nvidia-driver-550-server
nvidia-driver-550-server-open
```

### Installing the drivers for generic use (e.g. desktop and gaming)

You can either rely on automatic detection, which will install the driver that is considered the ``best match`` for your hardware:

```
sudo apt update
sudo ubuntu-drivers install
```

Or you can tell the ubuntu-drivers tool which driver you would like installed. If this is the case, you will have to use the driver version (such as 535) that you saw when you used the ubuntu-drivers list command.

Let’s assume we want to install the 535 driver:

```
sudo apt update
sudo ubuntu-drivers install nvidia:535
```


### Installing the drivers on servers and/or for computing purposes

You can either rely on automatic detection, which will install the driver that is considered the best match for your hardware:

```
sudo ubuntu-drivers install --gpgpu
```

Or you can tell the ubuntu-drivers tool which driver you would like installed. If this is the case, you will have to use the driver version (such as 535) and the -server suffix that you saw when you used the ubuntu-drivers list --gpgpu command.

Let’s assume we want to install the 535-server driver (listed as nvidia-driver-535-server):

```
sudo ubuntu-drivers install --gpgpu nvidia:535-server
```

You will also want to install the following additional components:

```
sudo apt install nvidia-utils-535-server
```
 ---

## BIOS settings

Graphics driver problems can sometimes be related to BIOS settings. Key factors include:

1. **Integrated vs. Dedicated Graphics**: Incorrect BIOS settings may prevent the system from using the correct GPU, causing driver issues.
2. **Secure Boot**: If enabled, Secure Boot may block unsigned drivers, leading to installation problems, especially with proprietary drivers like NVIDIA's.
3. **PCIe Slot Settings**: Incorrect PCIe slot configuration in the BIOS can cause the GPU to not be detected or function improperly.
4. **Legacy vs. UEFI Mode**: The wrong boot mode (Legacy vs. UEFI) may cause incompatibilities with modern or older graphics drivers.
5. **Fast Boot**: Enabling Fast Boot might skip hardware initialization, potentially causing driver or GPU recognition issues.

Checking and adjusting BIOS settings can help resolve graphics driver problems in these cases.
