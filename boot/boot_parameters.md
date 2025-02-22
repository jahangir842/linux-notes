# **Boot Parameters in Linux**  

## **1️⃣ What Are Boot Parameters?**  
Boot parameters are **kernel command-line arguments** that modify the behavior of the Linux kernel during system startup. These parameters are passed to the kernel by the bootloader (such as GRUB, Syslinux, or LILO) and help in configuring the system before the operating system fully loads.  

### **📌 Common Use Cases of Boot Parameters**
- **Debugging boot issues**
- **Modifying hardware behavior**
- **Changing root filesystem location**
- **Disabling or enabling specific kernel features**
- **Single-user mode or rescue mode**  

---

## **2️⃣ How to View Current Boot Parameters**  
You can check the current kernel command-line parameters using:
```bash
cat /proc/cmdline
```
🔍 **Example Output:**
```
BOOT_IMAGE=/boot/vmlinuz-5.15.0-76-generic root=UUID=abcd-1234 ro quiet splash
```

---

## **3️⃣ How to Set Boot Parameters**  

### **A. Temporary Boot Parameters (For One-Time Use)**
1️⃣ **Modify in GRUB at Boot Time**  
- Restart your system and hold **`Shift` (for BIOS) or `Esc` (for UEFI)** to enter the GRUB menu.  
- Select the desired kernel and press **`e`** to edit.  
- Find the line starting with **`linux`** and append the desired parameters.  
- Press **`Ctrl + X` or `F10`** to boot with the modified parameters.  

### **B. Persistent Boot Parameters (Permanent Changes)**
1️⃣ **Modify GRUB Configuration**  
- Open the GRUB config file:
  ```bash
  sudo nano /etc/default/grub
  ```
- Find the line:
  ```
  GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"
  ```
- Add or modify parameters:
  ```
  GRUB_CMDLINE_LINUX_DEFAULT="quiet splash nomodeset"
  ```
- Save and exit (`Ctrl + X`, then `Y`, then `Enter`).  
- Update GRUB and reboot:
  ```bash
  sudo update-grub
  sudo reboot
  ```

---

## **4️⃣ Common Boot Parameters in Linux**
### **A. General Boot Parameters**
| Parameter | Description |
|-----------|------------|
| `ro` | Mounts the root filesystem as **read-only** (default) |
| `rw` | Mounts the root filesystem as **read-write** |
| `root=UUID=<UUID>` | Specifies the root filesystem using UUID |
| `root=/dev/sdX` | Specifies the root filesystem device |
| `quiet` | Hides boot messages (reduces verbosity) |
| `splash` | Shows a graphical splash screen instead of boot messages |
| `nomodeset` | Disables Kernel Mode Setting (KMS), useful for graphics troubleshooting |

### **B. Debugging & Recovery Parameters**
| Parameter | Description |
|-----------|------------|
| `single` | Boots into **single-user mode** (useful for maintenance) |
| `systemd.unit=rescue.target` | Boots into **rescue mode** |
| `systemd.unit=emergency.target` | Boots into **emergency mode** |
| `debug` | Increases kernel debugging output |
| `loglevel=3` | Controls the verbosity of boot logs (0-7, where 0=quietest, 7=most verbose) |
| `init=/bin/bash` | Boots directly into a **bash shell** instead of systemd/init |

### **C. Hardware-Specific Parameters**
| Parameter | Description |
|-----------|------------|
| `acpi=off` | Disables ACPI (useful for power management issues) |
| `pci=noacpi` | Disables ACPI for PCI devices |
| `noapic` | Disables the APIC (Advanced Programmable Interrupt Controller) |
| `nolapic` | Disables the Local APIC |
| `irqpoll` | Fixes IRQ issues by polling |

### **D. Networking Parameters**
| Parameter | Description |
|-----------|------------|
| `ip=dhcp` | Configures the system to use DHCP at boot |
| `net.ifnames=0` | Uses traditional network interface names (`eth0`, `wlan0`) |
| `biosdevname=0` | Disables BIOS device naming |

### **E. Kernel Module Parameters**
| Parameter | Description |
|-----------|------------|
| `modprobe.blacklist=<module>` | Prevents a specific kernel module from loading |
| `nouveau.modeset=0` | Disables the Nouveau driver (useful for NVIDIA graphics issues) |
| `radeon.modeset=0` | Disables the Radeon driver |

### **F. Filesystem & Storage Parameters**
| Parameter | Description |
|-----------|------------|
| `fsck.mode=force` | Forces a filesystem check (`fsck`) at boot |
| `fsck.repair=yes` | Automatically repairs filesystem issues |
| `elevator=deadline` | Sets the I/O scheduler to **deadline** |
| `elevator=cfq` | Sets the I/O scheduler to **Completely Fair Queueing (CFQ)** |

---

## **5️⃣ Example Boot Scenarios**
### **🛠 Scenario 1: Booting into Single-User Mode**
If you forgot your root password and need to reset it:  
1. Edit the GRUB menu and add:  
   ```
   init=/bin/bash
   ```
2. Boot into the system and reset the password:
   ```bash
   passwd root
   reboot
   ```

### **🛠 Scenario 2: Fixing a Black Screen on Boot (NVIDIA Issues)**
Modify GRUB and add:
```
nomodeset
```

### **🛠 Scenario 3: Enabling Full Debugging Mode**
Modify GRUB and add:
```
debug loglevel=7
```

---

## **6️⃣ Advanced Usage: Kernel Boot Parameter Scripting**
You can modify boot parameters dynamically using **sysctl** or **GRUB scripts**.

🔹 **Check Current Parameters:**
```bash
cat /proc/cmdline
```

🔹 **Modify Parameters Dynamically (Temporary)**
```bash
sudo sysctl -w kernel.printk=3
```

🔹 **Make Changes Permanent**
Edit `/etc/sysctl.conf`:
```
kernel.printk = 3
```

---

## **7️⃣ Summary**
- **Boot parameters** are passed to the Linux kernel at startup to modify its behavior.
- They can be set **temporarily** (via GRUB) or **permanently** (via `/etc/default/grub`).
- Common categories include **debugging, networking, hardware settings, and filesystem options**.
- **GRUB commands** like `update-grub` help apply persistent changes.
- **Kernel parameters** can be viewed using `cat /proc/cmdline`.

Would you like more details on a specific parameter? 🚀
