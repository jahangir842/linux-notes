# **Systemd Udev vs Traditional Udev: A Detailed Overview**  

## **1. Introduction to Udev**
Udev (userspace device manager) is responsible for managing device nodes dynamically in Linux systems. It replaces the traditional **static device nodes** in `/dev` with **dynamically managed device nodes**, allowing hotplugging and persistent device naming.

Originally, udev was a standalone service, but modern Linux distributions using **systemd** have integrated it into **systemd-udevd**.

---

## **2. What is Systemd-Udev?**
With the introduction of systemd, udev was merged into it as **systemd-udevd**. This means that modern Linux distributions manage devices using **systemd’s built-in udev system**, rather than a separate udev service.

- Systemd-udevd is responsible for **device discovery, event handling, and dynamic device node creation**.
- It still relies on **udev rules** to manage device permissions, names, and attributes.

---

## **3. How Udev Works**
### **Traditional Udev Workflow**
1. When a device is plugged in or removed, the **kernel sends an event (uevent)**.
2. The udev daemon (`udevd`) **processes the event** and applies the relevant udev rules.
3. It then **creates or modifies device nodes** in `/dev/`.
4. Udev may also **trigger additional scripts** based on predefined rules.

### **Systemd Udev Workflow**
1. The **systemd kernel** detects the device and generates a uevent.
2. The event is processed by **systemd-udevd**, which loads the relevant udev rules.
3. Systemd then:
   - Creates device nodes in `/dev/`.
   - Applies rules (like setting permissions and symlinks).
   - Adds devices to **cgroups** if required.
   - Generates persistent names for **network interfaces**.
4. Systemd services may be triggered based on the detected device.

---

## **4. Key Features of Systemd Udev**
- **Integrated with systemd**: No separate udev service is needed.
- **Faster boot times**: Parallel execution of device initialization.
- **Better handling of network interfaces**: Uses **Predictable Network Interface Names** (e.g., `enp0s3` instead of `eth0`).
- **Dynamic device management**: Automatically assigns correct permissions and configurations to new devices.
- **Works with systemd services**: Devices can trigger systemd unit files.

---

## **5. Differences Between Traditional Udev and Systemd-Udev**
| Feature                | Traditional Udev            | Systemd-Udev (Modern)   |
|------------------------|---------------------------|-------------------------|
| **Management**         | Managed by `udevd` daemon | Managed by `systemd-udevd` |
| **Service Control**    | `service udev start/stop` | `systemctl start systemd-udevd` |
| **Configuration Files** | `/etc/udev/rules.d/`      | `/etc/udev/rules.d/`, `/lib/udev/rules.d/` |
| **Network Naming**     | `eth0`, `wlan0`           | `enpXsY`, `wlpXsY` (Predictable Names) |
| **Performance**       | Sequential execution       | Parallel execution |
| **Device Permissions** | Managed by `udev` rules   | Managed by `systemd-udevd` with cgroups support |
| **Triggering Services** | Possible with custom scripts | Directly integrates with systemd unit files |
| **Static Device Handling** | Manual rules for persistent names | Uses `.link` files for network devices |

---

## **6. Checking Systemd-Udev Status**
Since systemd manages udev, you can check its status using:
```bash
systemctl status systemd-udevd
```
To reload udev rules:
```bash
udevadm control --reload
```
To trigger udev events manually:
```bash
udevadm trigger
```

---

## **7. Understanding Udev Rules in Systemd**
Udev rules are still used to control device behavior, but they work within **systemd's framework**.

### **Common Udev Rule Structure**
Udev rules are stored in:
- `/etc/udev/rules.d/` (User-defined rules)
- `/lib/udev/rules.d/` (System-wide rules)

Example rule to assign a static name to a USB device:
```bash
SUBSYSTEM=="usb", ATTR{idVendor}=="046d", ATTR{idProduct}=="c52b", SYMLINK+="my_mouse"
```
This creates a symlink `/dev/my_mouse` for a Logitech USB device.

### **Persistent Network Naming in Systemd**
Systemd enforces **Predictable Network Interface Names**, such as:
- `enp0s3` (Ethernet)
- `wlp2s0` (WiFi)

To disable predictable network names and revert to `eth0`, use:
```bash
sudo grubby --update-kernel=ALL --args="net.ifnames=0 biosdevname=0"
```
Then reboot.

---

## **8. Customizing Systemd-Udev**
### **Creating Custom Udev Rules**
To create a custom rule, add a new file in `/etc/udev/rules.d/`:
```bash
nano /etc/udev/rules.d/99-usb.rules
```
Example rule to change device permissions:
```bash
SUBSYSTEM=="usb", ATTR{idVendor}=="046d", ATTR{idProduct}=="c52b", MODE="0666"
```
Reload udev:
```bash
udevadm control --reload-rules && udevadm trigger
```

### **Disabling Udev Persistent Naming**
If you prefer old-style interface names (`eth0`, `wlan0`), disable it via kernel parameters:
```bash
GRUB_CMDLINE_LINUX_DEFAULT="net.ifnames=0 biosdevname=0"
```
Then update GRUB:
```bash
update-grub
```
And reboot.

---

## **9. Conclusion**
Systemd-udevd provides **better device management** than traditional udev by integrating tightly with **systemd services**, offering **faster boot times, parallel device initialization, and predictable network names**. However, it still supports traditional **udev rules** for full customization.
