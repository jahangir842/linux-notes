## **What is KVM (Kernel-based Virtual Machine)?**  

**KVM (Kernel-based Virtual Machine)** is a **Linux kernel module** that turns your Linux system into a **Type 1 hypervisor** (bare-metal) while still functioning as a regular operating system. It allows you to create and manage **fully virtualized** VMs (Guest OS) that run alongside the host OS with near-native performance.  

💡 **Think of KVM as a built-in virtualization feature inside Linux that competes with VMware ESXi and Microsoft Hyper-V.**  

---

## **Key Features of KVM**
✅ **Full Virtualization** – Can run **Windows, Linux, BSD, macOS** as guest VMs  
✅ **Uses Hardware Virtualization** – Requires **Intel VT-x** or **AMD-V** CPU support  
✅ **Type 1 Hypervisor** – Runs directly on the hardware (like VMware ESXi), making it **faster** than VirtualBox  
✅ **Integrated with Linux Kernel** – No additional software required  
✅ **Live Migration** – Move running VMs between hosts with **zero downtime**  
✅ **Memory & CPU Allocation** – Assign **dedicated vCPUs and RAM** to each VM  
✅ **Storage & Networking Virtualization** – Supports virtual disks, bridges, and VLANs  
✅ **Security** – Uses **SELinux & AppArmor** for VM isolation  

---

## **How KVM Works**
1. **KVM Module (`kvm.ko`) Loads in the Linux Kernel**
   - KVM converts the Linux kernel into a **hypervisor**  
2. **QEMU (User-Space Emulator) Manages VM Hardware**
   - **QEMU** provides **virtual CPUs, disks, NICs, and more**  
3. **VMs Run as Independent Processes**
   - Each VM runs as a separate process on the host  
4. **Hardware Virtualization Improves Performance**
   - Uses **VT-x (Intel) or AMD-V (AMD)** for near-native speeds  

💡 **KVM + QEMU = Full Virtualization Solution**  
**QEMU** is used to emulate hardware devices, while **KVM** handles CPU/memory virtualization.

---

## **KVM vs Other Hypervisors**
| Feature         | KVM             | VirtualBox        | VMware ESXi      | Hyper-V          |
|---------------|----------------|------------------|----------------|----------------|
| **Type**      | Type 1 (Bare-Metal) | Type 2 (Hosted)  | Type 1 (Bare-Metal) | Type 1 (Bare-Metal) |
| **Performance** | ✅ Near-Native | ❌ Slower (Emulated) | ✅ Near-Native | ✅ Near-Native |
| **Open Source?** | ✅ Yes | ✅ Yes | ❌ No (Proprietary) | ❌ No (Microsoft) |
| **Best for**   | **Cloud & Servers** | **Desktops** | **Enterprise & Cloud** | **Windows Environments** |
| **Networking** | ✅ Advanced (Bridges, VLANs) | ❌ Basic (NAT) | ✅ Advanced | ✅ Advanced |
| **Live Migration** | ✅ Yes | ❌ No | ✅ Yes | ✅ Yes |

---

## **KVM Architecture**
### **Main Components:**
1. **`kvm.ko`** – Kernel module for virtualization  
2. **QEMU** – Provides virtual hardware  
3. **`libvirt`** – Manages VMs (via `virsh`, `virt-manager`, etc.)  
4. **`virtio` Drivers** – Improves guest OS performance  
5. **SPICE/VNC** – Enables remote access to VMs  

💡 **You can manage KVM with:**  
- `virsh` (CLI)  
- `virt-manager` (GUI)  
- `virt-install` (CLI for creating VMs)  

---

## **Installing KVM on Ubuntu**
### **1️⃣ Check if Your CPU Supports Virtualization**
Run:

```bash
egrep -c '(vmx|svm)' /proc/cpuinfo
```
- If the output is **1 or more**, your CPU supports **VT-x (Intel)** or **AMD-V**.

### **2️⃣ Install KVM & Required Packages**
```bash
sudo apt update
sudo apt install -y qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virt-manager
```

### **3️⃣ Add Your User to the `libvirt` Group**
```bash
sudo usermod -aG libvirt,kvm $(whoami)
```
Log out and log back in to apply changes.

### **4️⃣ Start and Enable Libvirt**
```bash
sudo systemctl enable --now libvirtd
```

### **5️⃣ Verify KVM Installation**
```bash
sudo virsh list --all
```
If it works, KVM is properly set up! 🎉

---

## **Creating a VM with KVM**
### **1️⃣ Using `virt-install` (Command Line)**
```bash
virt-install \
--name ubuntu-vm \
--vcpus 2 --memory 4096 \
--cdrom /path/to/ubuntu.iso \
--disk size=20,path=/var/lib/libvirt/images/ubuntu.qcow2 \
--network bridge=virbr0 \
--graphics vnc
```
- Allocates **2 CPUs, 4GB RAM, and 20GB disk**
- Uses **Ubuntu ISO for installation**
- Connects the VM to the network via **`virbr0` (default bridge)**

### **2️⃣ Using `virt-manager` (Graphical UI)**
Run:
```bash
virt-manager
```
- Click **"Create a new VM"**
- Select **ISO file**
- Configure **CPU, RAM, disk size**
- Click **"Finish"** to create the VM

---

## **Managing KVM VMs with `virsh`**
| Command | Description |
|---------|------------|
| `virsh list --all` | Show all VMs |
| `virsh start <vm-name>` | Start a VM |
| `virsh shutdown <vm-name>` | Shut down a VM |
| `virsh destroy <vm-name>` | Force stop a VM |
| `virsh undefine <vm-name>` | Remove a VM |

---

## **Conclusion**
✅ **KVM is a powerful, open-source virtualization solution built into Linux**  
✅ **It offers near-native performance and is ideal for servers and cloud environments**  
✅ **With tools like `virsh` and `virt-manager`, managing KVM is easy**  
✅ **It competes with VMware ESXi and Hyper-V while remaining free and open-source**  

🚀 **If you need to run VMs on Linux with great performance, KVM is the best choice!**
