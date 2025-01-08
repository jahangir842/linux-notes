## Repairing Kernels

1. **Reinstall the Current Kernel**  
   - On Debian/Ubuntu:  
     ```bash
     sudo apt-get install --reinstall linux-image-$(uname -r)
     ```
   - On RHEL/CentOS:  
     ```bash
     sudo yum reinstall kernel-$(uname -r)
     ```

2. **Boot into Recovery Mode**  
   - Access the GRUB menu during startup by pressing `Shift` or `Esc`.  
   - Select "Advanced options" and boot into an older or recovery kernel.

3. **Using Live Boot Media**  
   - Boot from a live CD/USB.  
   - Mount the root partition:  
     ```bash
     sudo mount /dev/sdXn /mnt
     ```
   - Chroot into the system:  
     ```bash
     sudo chroot /mnt
     ```
   - Reinstall or fix the kernel as needed.

4. **Fixing Broken Kernel Updates**  
   - Remove the problematic kernel:  
     ```bash
     sudo apt remove linux-image-<version>
     ```
   - Install a different version:  
     ```bash
     sudo apt install linux-image-<new-version>
     ```

---

## Updating GRUB for Kernel Changes

After any kernel installation or repair, update GRUB to reflect changes:  
```bash
sudo update-grub
```

---

## Switching Between Kernels

1. **During Boot**  
   - Access the GRUB menu.  
   - Select "Advanced options" and choose the desired kernel version.

2. **Setting a Default Kernel**  
   - Edit `/etc/default/grub`:  
     ```bash
     GRUB_DEFAULT="Advanced options for Ubuntu>Ubuntu, with Linux <version>"
     ```
   - Update GRUB:  
     ```bash
     sudo update-grub
     ```

---

## Managing Multiple Kernels

1. **List Installed Kernels**  
   - On Debian/Ubuntu:  
     ```bash
     dpkg --list | grep linux-image
     ```
   - On RHEL/CentOS:  
     ```bash
     rpm -qa | grep kernel
     ```

2. **Remove Old Kernels**  
   - Identify and remove unused kernels:  
     ```bash
     sudo apt autoremove
     ```
     Or manually:  
     ```bash
     sudo apt remove linux-image-<old-version>
     ```

3. **Prevent Automatic Removal**  
   - Mark a kernel to prevent it from being removed:  
     ```bash
     sudo apt-mark hold linux-image-<version>
     ```

---

## Common Kernel Issues and Fixes

1. **Kernel Panic**  
   - Boot into an older kernel or recovery mode.  
   - Check logs using:  
     ```bash
     dmesg
     sudo less /var/log/syslog
     ```

2. **Missing Kernel Files**  
   - Reinstall the kernel using the package manager.

3. **Full `/boot` Partition**  
   - Remove old kernel files:  
     ```bash
     sudo apt remove linux-image-<old-version>
     ```

4. **GRUB Not Detecting New Kernel**  
   - Regenerate GRUB configuration:  
     ```bash
     sudo update-grub
     ```

---

## Summary

- **Why Multiple Kernels?** To ensure stability, hardware support, and flexibility for testing.  
- **Installing Kernels:** Use package managers or compile manually.  
- **Repairing Kernels:** Reinstall or recover using live media.  
- **Managing Kernels:** Clean up old versions, update GRUB, and maintain a healthy `/boot` directory.  

Understanding and managing kernels is crucial for maintaining a stable and secure Linux environment.
