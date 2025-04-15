## 🧰 What is **DKMS**?

**DKMS** stands for **Dynamic Kernel Module Support**. It's a **framework that automatically rebuilds kernel modules** when a new kernel is installed on your Linux system.

This is especially useful for things like:

- **NVIDIA GPU drivers**
- **VirtualBox kernel modules**
- **ZFS on Linux**
- Any other **out-of-tree kernel module** (not included in the mainline Linux kernel)

---

## 🧠 Why You Need It

When your Linux system updates and installs a **new kernel**, your previously installed kernel modules might stop working unless they are recompiled for the new version. Without DKMS, you'd have to manually rebuild these modules every time.

DKMS **automates** this process. It watches for kernel upgrades and ensures that all registered modules are rebuilt for the new kernel.

---

## 🧪 Example Use Case

Suppose you installed NVIDIA drivers manually or using a `.run` file (not via the Ubuntu package manager). When the kernel updates, your graphics might break after a reboot — unless you used DKMS.

With DKMS:

```bash
sudo apt install dkms
```

You register a module like:

```bash
sudo dkms add -m nvidia -v 470.141
sudo dkms build -m nvidia -v 470.141
sudo dkms install -m nvidia -v 470.141
```

Now, when the kernel updates:

✅ The NVIDIA module is rebuilt automatically  
✅ No broken drivers after reboot  
✅ Happy GPU life 😄

---

## 🔍 Commands You Can Use

- List all DKMS modules:
  ```bash
  dkms status
  ```

- Manually build/install a module:
  ```bash
  dkms build -m <module> -v <version>
  dkms install -m <module> -v <version>
  ```

- Remove a module:
  ```bash
  dkms remove -m <module> -v <version> --all
  ```

---

## 📦 Summary

| Feature        | Description                                           |
|----------------|-------------------------------------------------------|
| Full Name      | Dynamic Kernel Module Support                         |
| Main Use       | Automatically rebuild kernel modules on updates       |
| Benefit        | Prevents breakage after kernel upgrades               |
| Common Use     | NVIDIA drivers, VirtualBox, ZFS, custom drivers       |
| Command-line   | `dkms add`, `dkms build`, `dkms install`, `dkms status` |

---

Absolutely! Let’s walk through a **real-world DKMS example** using **VirtualBox kernel modules**, since it's one of the most common use cases alongside NVIDIA drivers.

---

## ✅ Real-World DKMS Example: VirtualBox on Ubuntu

When you install **VirtualBox**, it includes kernel modules (like `vboxdrv`) that need to match your current Linux kernel.

Without DKMS, these modules break every time the kernel is upgraded.

---

### 🧱 Step-by-Step DKMS Use with VirtualBox

### 🔧 Step 1: Install Required Packages

```bash
sudo apt update
sudo apt install virtualbox dkms -y
```

Ubuntu will automatically install the correct module version and register it with DKMS.

---

### 🔍 Step 2: Check DKMS Status

After installing VirtualBox, you can check that the module is registered and compiled:

```bash
dkms status
```

✅ You’ll see something like:

```
vboxhost, 6.1.38, 5.15.0-84-generic, x86_64: installed
```

This means:

- Module name: `vboxhost`
- Version: `6.1.38`
- Kernel version: `5.15.0-84-generic`
- Architecture: `x86_64`
- Status: `installed`

---

### 📦 Step 3: DKMS in Action After Kernel Update

Now, suppose Ubuntu upgrades your kernel to `5.15.0-90`. After reboot, **DKMS automatically rebuilds the `vboxhost` module for the new kernel**.

You can confirm this with:

```bash
dkms status
```

You’ll now see entries for both kernel versions:

```
vboxhost, 6.1.38, 5.15.0-84-generic, x86_64: installed
vboxhost, 6.1.38, 5.15.0-90-generic, x86_64: installed
```

No manual action needed — VirtualBox continues to work smoothly 🎉

---

### 🧼 Step 4: Manually Rebuild (if needed)

If for some reason DKMS didn't auto-build after an update, you can do it manually:

```bash
sudo dkms build -m vboxhost -v 6.1.38
sudo dkms install -m vboxhost -v 6.1.38
```

---

## 🧠 Summary

| Action            | DKMS Benefit                                     |
|-------------------|--------------------------------------------------|
| Kernel upgrades   | Auto-recompiles modules to match new kernel      |
| Custom modules    | Makes maintaining out-of-tree modules effortless |
| Stability         | Prevents boot issues or broken drivers           |

---
