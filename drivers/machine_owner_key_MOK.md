The situation here means Ubuntu *thinks* the drivers are installed, but the NVIDIA kernel module is either not loaded, mismatched, or failed to initialize.
This usually happens if:

* The driver version doesn’t match the kernel modules actually built.
* Secure Boot is enabled and the module isn’t signed.
* The wrong “open” vs “proprietary” driver variant is being used.
* Kernel updates happened, but the NVIDIA DKMS module didn’t rebuild correctly.
* There’s another GPU driver (like `nouveau`) conflicting.

---

### **Step-by-step fix**

We’ll verify driver, DKMS, and kernel module status.

#### **1. Check Secure Boot**

```bash
mokutil --sb-state
```

If it says `SecureBoot enabled`, either disable Secure Boot in BIOS **or** sign the NVIDIA kernel module manually (signing is trickier).

---

#### **2. See what driver is in use**

```bash
ubuntu-drivers devices
```

This will show which driver Ubuntu *recommends*. Take note of `recommended` tag.

---

#### **3. Remove conflicting drivers**

```bash
sudo apt purge 'nvidia-*' 'libnvidia-*'
sudo apt purge 'linux-modules-nvidia-*'
```

Also blacklist Nouveau:

```bash
echo -e "blacklist nouveau\noptions nouveau modeset=0" | sudo tee /etc/modprobe.d/blacklist-nouveau.conf
sudo update-initramfs -u
```

---

#### **4. Install recommended driver cleanly**

Example if `nvidia-driver-550` is recommended:

```bash
sudo apt install nvidia-driver-550
```

*(Avoid `-open` unless you specifically want the open kernel modules — the proprietary ones are generally more stable.)*

---

#### **5. Reboot and test**

```bash
sudo reboot
```

After reboot:

```bash
nvidia-smi
```

It should show GPU details.

---

#### **6. If still failing — check module**

```bash
lsmod | grep nvidia
sudo dmesg | grep -i nvidia
```

If it says “module not found” → DKMS didn’t build for your kernel.

---

#### **7. Rebuild the kernel module manually**

```bash
sudo dkms remove -m nvidia -v <version> --all
sudo dkms install -m nvidia -v <version>
```

Replace `<version>` with what you see in:

```bash
dkms status
```

---

💡 **Example:**
If you just upgraded to kernel `6.8.0-45` and installed `nvidia-driver-550` but didn’t reboot, the driver may fail until you restart with the new kernel.

---

If you want, I can give you **exact purge & reinstall commands** based on your current `ubuntu-drivers devices` output so it matches the correct NVIDIA driver for your GPU. This avoids installing all these extra versions at once, which might be part of the problem.

Do you want me to prepare that exact fix?
