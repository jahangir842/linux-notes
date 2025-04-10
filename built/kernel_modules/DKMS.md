**DKMS (Dynamic Kernel Module Support)** in Linux is a **framework that allows kernel modules to be automatically rebuilt and installed when the kernel is upgraded**. This is very useful for third-party modules (like graphics drivers, Wi-Fi drivers, or virtual drivers like VirtualBox or ZFS) that are not part of the official kernel tree.

---

### 🔧 **Why is DKMS important?**
When you upgrade your kernel, any custom kernel modules (like NVIDIA drivers, VirtualBox modules, etc.) must be recompiled for the new kernel version. DKMS automates this.

---

### 📦 **Use Case Example: Installing VirtualBox**

Let’s say you install VirtualBox, which has its own kernel modules:

```bash
sudo apt install virtualbox virtualbox-dkms
```

- `virtualbox-dkms` ensures that VirtualBox kernel modules are recompiled automatically whenever a new kernel is installed.

---

### 🧠 **How DKMS Works**

1. The module source code is stored in `/usr/src/<module-name>-<version>/`
2. When a new kernel is installed, DKMS:
   - Detects the kernel change.
   - Rebuilds any registered DKMS modules against the new kernel.
   - Installs them in the appropriate `/lib/modules/<kernel-version>/` path.

---

### 🔍 **Basic DKMS Commands**

| Command | Description |
|--------|-------------|
| `dkms status` | View registered DKMS modules |
| `dkms add -m <module-name> -v <version>` | Add a module to DKMS |
| `dkms build -m <module-name> -v <version>` | Compile the module |
| `dkms install -m <module-name> -v <version>` | Install the compiled module |
| `dkms remove -m <module-name> -v <version> --all` | Remove a module from DKMS |

---

### 📁 **Directory Structure**

| Path | Purpose |
|------|---------|
| `/usr/src/` | Contains source code of DKMS-managed modules |
| `/var/lib/dkms/` | Stores build logs, compiled objects, and DKMS metadata |

---

### ✅ **Example Scenario**

Suppose you're using a custom Wi-Fi driver like `rtl8821ce`, and you’ve cloned the repo into `/usr/src/rtl8821ce-1.0/`. To add and build it via DKMS:

```bash
sudo dkms add -m rtl8821ce -v 1.0
sudo dkms build -m rtl8821ce -v 1.0
sudo dkms install -m rtl8821ce -v 1.0
```

---

### 💡 Summary

- DKMS = Auto-recompiler for out-of-tree kernel modules.
- Very useful for NVIDIA drivers, VirtualBox, ZFS, custom Wi-Fi/Bluetooth drivers, etc.
- Saves you from manually recompiling drivers after every kernel update.

Want a working example with a real driver like `rtl8821ce` or ZFS?
