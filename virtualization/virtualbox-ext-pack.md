### **What is `virtualbox-ext-pack`?**
`virtualbox-ext-pack` (VirtualBox Extension Pack) is an **add-on** for VirtualBox that provides additional features not included in the base VirtualBox installation.

---

### **🔹 Features Provided by `virtualbox-ext-pack`**
1. **USB 2.0 & USB 3.0 Support** – Enables high-speed USB device passthrough to VirtualBox guests.
2. **VirtualBox Remote Desktop Protocol (VRDP)** – Allows remote access to virtual machines.
3. **PCI Passthrough (Experimental)** – Enables direct access to PCI devices.
4. **Disk Image Encryption** – Supports AES-256 encryption for virtual disk images.
5. **NVMe and PXE Boot for Intel Cards** – Allows network booting via Intel PXE ROM.

---

### **🔹 How to Install `virtualbox-ext-pack` on Linux**
#### **1. Install VirtualBox (if not installed)**
```bash
sudo apt update
sudo apt install virtualbox
```
#### **2. Install the Extension Pack**
```bash
sudo apt install virtualbox-ext-pack
```
#### **3. Verify Installation**
```bash
vboxmanage list extpacks
```
It should list the installed extension pack and its version.

---

### **🔹 How to Install `virtualbox-ext-pack` Manually**
If `virtualbox-ext-pack` is not available in your package manager, you can install it manually:
1. Download the **Extension Pack** from the [official VirtualBox website](https://www.virtualbox.org/wiki/Downloads).
2. Install it using:
   ```bash
   sudo vboxmanage extpack install <path-to-extension-pack>.vbox-extpack
   ```
3. Accept the license agreement when prompted.

---

### **🔹 How to Remove `virtualbox-ext-pack`**
To remove the extension pack:
```bash
sudo vboxmanage extpack uninstall "Oracle VM VirtualBox Extension Pack"
```
Or, if installed via APT:
```bash
sudo apt remove virtualbox-ext-pack
```

---

### **🔹 License Note**
The Extension Pack is **not open-source**; it is released under the **Personal Use and Evaluation License (PUEL)**. It is free for personal use but requires a license for commercial use.

---

Would you like instructions for a specific OS (Ubuntu, Debian, Fedora, etc.)? 🚀
