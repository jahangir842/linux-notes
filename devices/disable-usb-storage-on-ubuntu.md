# Disable USB Storage on Ubuntu

> **Purpose:** Prevent users from using USB storage devices (USB drives, external hard drives) on Ubuntu systems for security and data protection purposes.

---

## Table of Contents
1. [Method 1: Blacklist USB Storage Module (Kernel Level)](#method-1-blacklist-usb-storage-module-kernel-level)
2. [Method 2: Using Udev Rules](#method-2-using-udev-rules)
3. [Method 3: Disable USB Ports via GRUB](#method-3-disable-usb-ports-via-grub)
4. [Method 4: Using USBGuard](#method-4-using-usbguard)
5. [Verification & Testing](#verification--testing)
6. [Rollback Instructions](#rollback-instructions)

---

## Method 1: Blacklist USB Storage Module (Kernel Level)

This is the **most straightforward method** that prevents the kernel from loading the USB storage driver.

### Step 1: Create/Edit Blacklist Configuration

```bash
sudo nano /etc/modprobe.d/blacklist-usb-storage.conf
```

### Step 2: Add the Following Lines

```bash
# Disable USB storage devices
blacklist usb_storage
blacklist uas
```

**Explanation:**
- `usb_storage` - Main USB storage driver
- `uas` - USB Attached SCSI protocol (newer USB storage interface)

### Step 3: Update Initramfs

```bash
sudo update-initramfs -u
```

### Step 4: Reboot

```bash
sudo reboot
```

### Verify the Module is Blacklisted

```bash
lsmod | grep usb_storage
```

If no output appears, the module is successfully blacklisted. ✓

---

## Method 2: Using Udev Rules

This method uses **udev rules** to block USB storage devices at the device level.

### Step 1: Create Udev Rule File

```bash
sudo nano /etc/udev/rules.d/80-disable-usb-storage.rules
```

### Step 2: Add the Following Rule

```bash
# Block all USB storage devices
ACTION=="add", SUBSYSTEMS=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{bDeviceClass}=="00", PROGRAM="/bin/sh -c 'echo 0 > /sys$DEVPATH/bConfigurationValue'"
```

Or a simpler approach:

```bash
# Disable mass storage functionality on all USB devices
ACTION=="add", SUBSYSTEM=="usb", ATTR{bDeviceClass}=="08", RUN+="/bin/sh -c 'echo 0 > /sys$DEVPATH/bConfigurationValue'"
```

**Explanation:**
- `SUBSYSTEM=="usb"` - Applies to USB devices
- `ATTR{bDeviceClass}=="08"` - Mass storage class (0x08)
- Resets the USB device configuration, effectively disabling it

### Step 3: Reload Udev Rules

```bash
sudo udevadm control --reload-rules
sudo udevadm trigger
```

### Step 4: Test (No Reboot Required)

Plug in a USB device and check if it's recognized:

```bash
lsblk
dmesg | tail -20
```

---

## Method 3: Disable USB Ports via GRUB

This method **disables all USB ports** at the firmware level.

### Step 1: Edit GRUB Configuration

```bash
sudo nano /etc/default/grub
```

### Step 2: Add USB Disable Parameters

Find the line starting with `GRUB_CMDLINE_LINUX_DEFAULT` and add:

```bash
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash usbcore.autosuspend=-1 usb-storage.quirks=0123:4567:m"
```

Or to disable all USB ports entirely:

```bash
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash usbcore.disable_hub_initiated_lpm=1 nousb"
```

**Explanation:**
- `nousb` - Disables all USB subsystem (most aggressive)
- `usbcore.autosuspend=-1` - Prevents USB autosuspend
- `usb-storage.quirks=0123:4567:m` - Blacklist specific USB device IDs

### Step 3: Update GRUB

```bash
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

### Step 4: Reboot

```bash
sudo reboot
```

### Verify

```bash
dmesg | grep -i "usb\|disabled"
```

---

## Method 4: Using USBGuard

**USBGuard** is a userspace utility to protect your computer against rogue USB devices.

### Step 1: Install USBGuard

```bash
sudo apt update
sudo apt install usbguard
```

### Step 2: Generate Default Policy

First, generate a policy from currently connected USB devices:

```bash
sudo usbguard generate-policy > ~/usbguard-policy.rules
```

### Step 3: Review the Policy

```bash
cat ~/usbguard-policy.rules
```

### Step 4: Create Restrictive Policy

Edit the default policy:

```bash
sudo nano /etc/usbguard/rules.conf
```

Add this to block all USB storage devices:

```bash
# Allow only HID devices (keyboards, mice)
allow id=*:* serial="*" name="*" hash="*" parent-hash="*" via-port="*" with-connect-type="*" -interface { *:*:* }
allow with-interface equals { 03:01:01 } # Keyboard
allow with-interface equals { 03:01:02 } # Mouse

# Block all mass storage devices
reject with-interface { 08:*:* }  # Mass storage class

# Block all USB devices by default
reject id=*:*
```

### Step 5: Enable and Start USBGuard

```bash
sudo systemctl enable usbguard
sudo systemctl start usbguard
```

### Step 6: Check USBGuard Status

```bash
sudo systemctl status usbguard
```

### Monitor USB Events

```bash
sudo usbguard list-devices
```

---

## Verification & Testing

### Check if USB Storage Module is Loaded

```bash
lsmod | grep -E "usb_storage|uas"
```

**Expected Output:** (empty if blacklisted)

### Check USB Devices

```bash
lsblk
```

USB storage devices should NOT appear in the list.

### Monitor USB Connection Attempts

```bash
sudo dmesg | tail -50
```

Look for messages indicating USB device rejection.

### Check Udev Rules

```bash
sudo udevadm info --attribute-walk /dev/sda
```

### List Connected USB Devices

```bash
lsusb
```

### Check USBGuard Log

```bash
sudo journalctl -u usbguard -n 50
```

---

## Rollback Instructions

### Undo Method 1 (Blacklist Module)

```bash
sudo rm /etc/modprobe.d/blacklist-usb-storage.conf
sudo update-initramfs -u
sudo reboot
```

### Undo Method 2 (Udev Rules)

```bash
sudo rm /etc/udev/rules.d/80-disable-usb-storage.rules
sudo udevadm control --reload-rules
```

### Undo Method 3 (GRUB)

Edit `/etc/default/grub` and remove the USB-related parameters from `GRUB_CMDLINE_LINUX_DEFAULT`, then:

```bash
sudo grub-mkconfig -o /boot/grub/grub.cfg
sudo reboot
```

### Undo Method 4 (USBGuard)

```bash
sudo systemctl stop usbguard
sudo systemctl disable usbguard
sudo apt remove usbguard
```

---

## Comparison of Methods

| Method | Level | Pros | Cons | Reboot Required |
|--------|-------|------|------|-----------------|
| **Blacklist Module** | Kernel | Simple, effective | Affects all USB storage | Yes |
| **Udev Rules** | Device | Flexible, granular | More complex | No |
| **GRUB Parameters** | Firmware | Permanent, secure | Affects all USB | Yes |
| **USBGuard** | Userspace | Fine-grained control | Requires service | No |

---

## Security Considerations

⚠️ **Important:**

1. **Users with Root Access** can bypass these restrictions by reloading modules or editing configs.
2. **BIOS/UEFI Password** should be set to prevent unauthorized changes.
3. **Secure Boot** should be enabled for additional protection.
4. **Regular Audits** should monitor attempts to re-enable USB storage.

### Monitor USB Activity

```bash
sudo auditctl -w /sys/module/usb_storage -p wa -k usb_storage_mod
sudo tail -f /var/log/audit/audit.log | grep usb_storage
```

---

## Common Issues & Troubleshooting

### Issue 1: USB Keyboard/Mouse Stops Working

**Solution:** Don't use `nousb` GRUB parameter. Use Method 1 or 2 instead, which only blocks storage devices.

### Issue 2: System Won't Boot After Changes

**Solution:** Boot into recovery mode and revert the changes:

```bash
sudo rm /etc/modprobe.d/blacklist-usb-storage.conf
sudo update-initramfs -u
```

### Issue 3: USB Device Still Appears

**Solution:** Ensure the configuration file is correctly placed and reboot:

```bash
sudo update-initramfs -u
sudo reboot
```

### Issue 4: GRUB Configuration Not Applied

**Solution:** Verify changes were applied:

```bash
cat /boot/grub/grub.cfg | grep -i usb
```

If not present, run `sudo grub-mkconfig -o /boot/grub/grub.cfg` again.

---

## References

- [Linux kernel documentation - usb_storage](https://www.kernel.org/doc/html/latest/driver-api/usb/index.html)
- [Udev documentation](https://manpages.ubuntu.com/manpages/focal/man7/udev.7.html)
- [USBGuard Project](https://usbguard.github.io/)
- [Ubuntu Security Documentation](https://ubuntu.com/security)

