# **Udev Rules in Linux**

**udev** (short for "userspace device manager") is a system in Linux that dynamically manages device nodes in the `/dev` directory. It handles the creation, naming, and configuration of devices when they are connected or disconnected. **Udev rules** are customizable configuration files that tell udev how to handle specific devices based on their attributes, allowing you to automate actions like setting permissions, running scripts, or renaming devices.

---

## **1. What is Udev?**
- **Definition**: Udev is a device management daemon that runs in userspace and interacts with the Linux kernel to manage device events.
- **Purpose**: Automatically creates and removes device nodes in `/dev` (e.g., `/dev/sda`, `/dev/ttyUSB0`) when hardware is added or removed.
- **Key Features**:
  - Dynamic device node creation.
  - Custom naming and permissions via rules.
  - Triggering actions (e.g., running scripts) on device events.

---

## **2. What are Udev Rules?**
- **Definition**: Udev rules are instructions written in configuration files that define how udev should handle specific devices based on their properties (e.g., vendor ID, device type).
- **Location**: Stored in `/etc/udev/rules.d/` (custom rules) or `/lib/udev/rules.d/` (system defaults).
- **File Naming**: Rules files end in `.rules` (e.g., `70-usb-drives.rules`). Lower numbers execute first.
- **Syntax**: Key-value pairs with **match** and **action** operators.

---

## **3. Udev Rule Syntax**
A udev rule is a single line composed of **match keys** (conditions) and **action keys** (results), separated by commas:
```
MATCH_KEY=="value", MATCH_KEY=="value", ACTION_KEY="value"
```
- **Match Keys**: Conditions to identify a device (e.g., vendor, subsystem).
- **Action Keys**: What to do when a match is found (e.g., set a name, permissions).
- **Operators**:
  - `==`: Match a value exactly (condition).
  - `=`: Assign a value (action).
  - `+=`: Add to a value (e.g., add a group).

### Example Rule:
```
SUBSYSTEM=="usb", ATTR{idVendor}=="1234", ATTR{idProduct}=="5678", NAME="my_usb_device"
```
- Matches a USB device with vendor ID `1234` and product ID `5678`, naming it `/dev/my_usb_device`.

---

## **4. Key Components of Udev Rules**

### **a) Match Keys**
Identify devices based on their attributes:
- `SUBSYSTEM`: Device type (e.g., `usb`, `block`, `tty`).
- `ATTR{attribute}`: Device attributes from sysfs (e.g., `idVendor`, `serial`).
- `KERNEL`: Kernel device name (e.g., `sda`, `ttyUSB*`).
- `ACTION`: Event type (e.g., `add`, `remove`).
- `DRIVER`: Kernel driver (e.g., `usbhid`).

### **b) Action Keys**
Define what happens when a match occurs:
- `NAME`: Set the device node name (e.g., `/dev/mydevice`).
- `SYMLINK+=`: Create symbolic links (e.g., `/dev/mydisk` → `/dev/sdb`).
- `OWNER`, `GROUP`, `MODE`: Set permissions (e.g., `root`, `users`, `0660`).
- `RUN+=`: Execute a script (e.g., `/usr/local/bin/script.sh`).

---

## **5. How Udev Works**
1. **Device Event**: The kernel sends a "uevent" when a device is added or removed.
2. **Udev Daemon**: `udevd` listens for these events via netlink.
3. **Rule Processing**: Udev reads rules from `/lib/udev/rules.d/` (defaults) and `/etc/udev/rules.d/` (custom), applying them in numerical order.
4. **Action Execution**: Creates device nodes, sets permissions, or runs scripts as specified.

---

## **6. Writing Udev Rules**

### **Step 1: Identify Device Attributes**
Use `udevadm` to inspect a device:
```bash
udevadm info --attribute-walk --path=/sys/class/tty/ttyUSB0
```
- **Output Example** (simplified):
```
ATTRS{idVendor}=="1a86"
ATTRS{idProduct}=="7523"
ATTRS{serial}=="ABC123"
SUBSYSTEM=="tty"
```
- Use these attributes in your rule.

### **Step 2: Create a Rule File**
- Place rules in `/etc/udev/rules.d/` (e.g., `10-mydevice.rules`).
- Example: Rename a specific USB serial device:
```bash
SUBSYSTEM=="tty", ATTRS{idVendor}=="1a86", ATTRS{idProduct}=="7523", NAME="my_serial_port"
```

### **Step 3: Test the Rule**
- Reload rules:
```bash
sudo udevadm control --reload-rules
```
- Trigger rules manually:
```bash
sudo udevadm trigger
```
- Check the result (e.g., `ls /dev/my_serial_port`).

---

## **7. Common Examples**

### **a) Rename a USB Device**
```bash
SUBSYSTEM=="usb", ATTRS{idVendor}=="1234", ATTRS{idProduct}=="5678", NAME="custom_usb"
```
- Creates `/dev/custom_usb` instead of the default name.

### **b) Set Permissions**
```bash
SUBSYSTEM=="block", KERNEL=="sd[a-z]", GROUP="users", MODE="0660"
```
- Gives the `users` group read/write access to all SATA/USB drives.

### **c) Create a Symlink**
```bash
SUBSYSTEM=="block", ATTRS{serial}=="XYZ789", SYMLINK+="mydisk"
```
- Creates `/dev/mydisk` as a symlink to the matched device (e.g., `/dev/sdb`).

### **d) Run a Script**
```bash
ACTION=="add", SUBSYSTEM=="usb", ATTRS{idVendor}=="abcd", RUN+="/usr/bin/notify.sh"
```
- Executes `notify.sh` when the USB device is plugged in.

---

## **8. Debugging Udev Rules**

### **a) Check Device Info**
```bash
udevadm info /dev/sdb
```
- Shows all attributes for debugging.

### **b) Monitor Events**
```bash
udevadm monitor
```
- Displays real-time device events as they occur (plug/unplug devices to test).

### **c) Test a Rule**
```bash
udevadm test $(udevadm info -q path -n /dev/sdb)
```
- Simulates how rules apply to a device.

---

## **9. Practical Use Cases**

### **a) Consistent Device Naming**
- Problem: USB devices get random names (e.g., `/dev/ttyUSB0` vs. `/dev/ttyUSB1`).
- Solution: Use serial numbers or IDs to assign fixed names.
```bash
SUBSYSTEM=="tty", ATTRS{serial}=="ABC123", SYMLINK+="arduino"
```

### **b) Automount USB Drives**
```bash
ACTION=="add", SUBSYSTEM=="block", KERNEL=="sd[a-z][0-9]", RUN+="/bin/mount /mnt/usb"
```

### **c) Restrict Access**
```bash
SUBSYSTEM=="usb", ATTRS{idVendor}=="abcd", MODE="0600", OWNER="admin"
```
- Only `admin` can access the device.

---

## **10. Best Practices**
- **Numbering**: Use low numbers (e.g., `10-`) for custom rules to override defaults (e.g., `70-`).
- **Specificity**: Match multiple attributes (e.g., vendor + product) for precision.
- **Comments**: Add `#` comments in rules files for clarity.
```bash
# Rename my Arduino
SUBSYSTEM=="tty", ATTRS{idVendor}=="2341", NAME="arduino"
```
- **Backup**: Test rules in a temporary file before deploying permanently.

---

## **11. Limitations**
- **Kernel-Driven**: Udev reacts to kernel events; it can’t detect devices the kernel doesn’t see.
- **No Loops/Logic**: Rules are simple key-value pairs, not full scripts.
- **Ordering**: Misordered rules can lead to conflicts (e.g., naming vs. symlinking).

---

## **12. Comparison with Alternatives**
| **Tool**       | **Purpose**               | **Pros**                  | **Cons**               |
|-----------------|---------------------------|---------------------------|------------------------|
| **Udev Rules** | Device management         | Dynamic, precise          | Complex syntax         |
| **mknod**      | Manual node creation      | Simple for static devices | No automation          |
| **systemd**    | Service management        | Broader scope             | Less device-specific   |

---

## **13. Summary**
- **Udev** manages device nodes dynamically in Linux.
- **Udev Rules** customize device behavior (naming, permissions, actions).
- Stored in `/etc/udev/rules.d/` with a `.rules` extension.
- Use `udevadm` for debugging and testing.
- Essential for consistent device handling in scripts and systems.

---

## **Try It Yourself**
1. Plug in a USB device.
2. Run `udevadm info --attribute-walk --name=/dev/<device>` (e.g., `/dev/ttyUSB0`).
3. Write a rule in `/etc/udev/rules.d/99-test.rules`:
```bash
SUBSYSTEM=="tty", ATTRS{idVendor}=="1a86", SYMLINK+="mydevice"
```
4. Reload and trigger:
```bash
sudo udevadm control --reload-rules && sudo udevadm trigger
```
5. Check: `ls -l /dev/mydevice`.

---
