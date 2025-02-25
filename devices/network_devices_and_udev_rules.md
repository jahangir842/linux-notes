Here are your detailed notes on **Network Devices and Udev Rules**:  

---

# **Network Devices and Udev Rules in Linux**  

## **1. Overview of Network Device Naming**  
By default, **Udev** names network devices based on:  
- **Firmware/BIOS data**  
- **Physical characteristics** (bus, slot, or MAC address)  

### **Purpose of Persistent Naming**  
- Ensures consistent device naming, unaffected by the order of detection.  
- Prevents renumbering issues after reboots.  
- Older versions of Linux assigned names like `eth0` and `eth1`, which could change after rebooting.  
- The modern naming convention uses names like **`enp5s0`** (Ethernet) or **`wlp3s0`** (Wireless).  

---

## **2. Disabling Persistent Naming (Reverting to eth0, eth1, etc.)**  
If you prefer the **traditional network interface naming**, you can disable persistent naming by adding the following kernel parameter:  

```bash
net.ifnames=0
```
### **Steps to Apply This Setting:**  
1. Edit the **GRUB configuration file**:  
   ```bash
   sudo nano /etc/default/grub
   ```
2. Find the line starting with `GRUB_CMDLINE_LINUX`, and append `net.ifnames=0`:
   ```bash
   GRUB_CMDLINE_LINUX="net.ifnames=0"
   ```
3. Update GRUB and reboot:  
   ```bash
   sudo update-grub
   sudo reboot
   ```

This method is useful for systems with a single **Ethernet** and **Wi-Fi** adapter (`eth0` and `wlan0`).

---

## **3. Creating Custom Udev Rules for Network Devices**  
Instead of using the default naming convention, you can define **custom names** for network interfaces using **Udev rules**.  

### **3.1 Generating Initial Udev Rules**  
Run the following command to create initial Udev rules:  

```bash
bash /usr/lib/udev/init-net-rules.sh
```

### **3.2 Inspecting Udev Rules**  
Check which names are assigned to network devices:  

```bash
cat /etc/udev/rules.d/70-persistent-net.rules
```

**Note:**  
- This file contains rules mapping **MAC addresses** to network interface names.  
- In some cases (e.g., manually assigned MAC addresses, virtual machines), this file may not be generated.

---

## **4. Understanding Udev Rule Syntax**  
Each Udev rule consists of **keywords**, separated by commas.  

| **Keyword**           | **Description** |
|-----------------------|----------------|
| `SUBSYSTEM=="net"`   | Ensures the rule applies only to **network interfaces**. |
| `ACTION=="add"`      | Applies the rule only when a **new device** is added. |
| `DRIVERS=="?*"`      | Prevents conflicts with VLANs or **bridge sub-interfaces**. |
| `ATTR{address}`      | Matches the **MAC address** of the NIC. |
| `ATTR{type}=="1"`    | Ensures only the **primary interface** is matched. |
| `NAME="custom_name"` | Assigns a **custom network interface name**. |

### **Example Udev Rule**
If you want to name a network interface **myeth0** based on its **MAC address** (`00:1a:2b:3c:4d:5e`), add this rule:  

```bash
SUBSYSTEM=="net", ACTION=="add", ATTR{address}=="00:1a:2b:3c:4d:5e", NAME="myeth0"
```

Save this in the Udev rules file:  

```bash
/etc/udev/rules.d/70-persistent-net.rules
```

Then reload Udev rules:  
```bash
sudo udevadm control --reload-rules && sudo udevadm trigger
```

---

## **5. Resolving Name Conflicts**  
If Udev assigns **alternative names** based on physical characteristics, a rule might fail due to a naming conflict.  

To **override alternative names**, create this file:  
```bash
/etc/udev/network/99-default.link
```

Run the following command to apply an empty **alternative name policy**:  

```bash
sed -e '/^AlternativeNamesPolicy/s/=.*$/=/' \
/usr/lib/udev/network/99-default.link \
> /etc/udev/network/99-default.link
```

---

## **6. Summary**  
- **Network device names** are assigned based on BIOS/physical attributes for consistency.  
- **To revert to `eth0`/`wlan0`**, add `net.ifnames=0` in GRUB.  
- **Custom names** can be set using **Udev rules**.  
- **Check assigned names** using `/etc/udev/rules.d/70-persistent-net.rules`.  
- **Resolve conflicts** by overriding alternative name policies.  

---

These notes provide a **detailed but structured** reference for handling network device names with **Udev**. 🚀
