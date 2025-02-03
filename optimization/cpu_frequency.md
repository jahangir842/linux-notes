# **CPU Frequency Scaling & Power Management**  

## **1️⃣ What is CPU Frequency Scaling?**  
CPU frequency scaling is a power management technique that adjusts the CPU speed dynamically to balance performance and power consumption. It is controlled by CPU **governors**.

---

## **2️⃣ What is a CPU Governor?**  
A **governor** is a kernel module that determines how CPU frequency is adjusted. Different governors are available:

| **Governor**   | **Description** |
|---------------|----------------|
| `performance` | Runs CPU at **max speed** always. Best for high-performance tasks. |
| `powersave`   | Runs CPU at **minimum speed** to save power. |
| `ondemand`    | Increases speed **when needed**, but lowers it when idle. |
| `conservative` | Like `ondemand`, but increases speed **gradually**. |
| `schedutil`   | Uses **kernel scheduler** to adjust CPU dynamically (modern method). |
| `userspace`   | Allows **manual frequency setting** by users or scripts. |

---

## **3️⃣ Essential Tools for CPU Management**  

### **🔹 `cpupower`**  
A modern tool for managing CPU frequency and power states.  

#### **Installation**  
- **Ubuntu/Debian**  
  ```bash
  sudo apt install linux-tools-common linux-tools-$(uname -r) -y
  ```
- **RHEL/CentOS/Rocky Linux**  
  ```bash
  sudo dnf install kernel-tools -y
  ```

#### **Usage**
- **Check Current CPU Frequency Info**  
  ```bash
  cpupower frequency-info
  ```
- **Set CPU Governor to Performance Mode**  
  ```bash
  sudo cpupower frequency-set -g performance
  ```
- **Set CPU Governor to Power-Saving Mode**  
  ```bash
  sudo cpupower frequency-set -g powersave
  ```
- **Manually Set CPU Frequency**  
  ```bash
  sudo cpupower frequency-set -f 2.5GHz
  ```

---

### **🔹 `cpufreq-set`**  
An older tool from **cpufrequtils** package for CPU frequency control.  

#### **Installation**
- **Ubuntu/Debian**  
  ```bash
  sudo apt install cpufrequtils -y
  ```
- **RHEL/CentOS**  
  ```bash
  sudo yum install cpufrequtils -y
  ```

#### **Usage**
- **Check Available Governors**  
  ```bash
  cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_available_governors
  ```
- **Set Performance Governor**  
  ```bash
  sudo cpufreq-set -g performance
  ```
- **Set Maximum CPU Frequency**  
  ```bash
  sudo cpufreq-set -u 3.0GHz
  ```
- **Set Minimum CPU Frequency**  
  ```bash
  sudo cpufreq-set -d 1.5GHz
  ```

---

## **4️⃣ Other Useful Tools**
### **🛠 `turbostat` (Intel Only)**
- Provides **detailed CPU power consumption and frequency** information.  
- **Install:**  
  ```bash
  sudo apt install linux-tools-$(uname -r)
  ```
- **Run:**  
  ```bash
  sudo turbostat
  ```

### **🛠 `powertop` (Power Consumption Analysis)**
- Helps identify power-hungry processes.  
- **Install:**  
  ```bash
  sudo apt install powertop
  ```
- **Run:**  
  ```bash
  sudo powertop
  ```

### **🛠 `auto-cpufreq` (Automatic CPU Scaling)**
- Dynamically adjusts CPU speed based on load.  
- **Install:**  
  ```bash
  sudo apt install auto-cpufreq
  ```
- **Run:**  
  ```bash
  sudo auto-cpufreq --monitor
  ```

---

## **5️⃣ System Administrator Procedures**  

### **🔹 Check CPU Governors and Current Scaling**
```bash
cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
```
or  
```bash
cpupower frequency-info
```

### **🔹 Set Performance Mode for High-Performance Tasks**
```bash
sudo cpupower frequency-set -g performance
```
Useful for:
✅ **Compiling code** (e.g., building Glibc)  
✅ **Gaming & high-performance applications**  
✅ **Virtual machines requiring stable performance**  

### **🔹 Revert to Power-Saving Mode**
```bash
sudo cpupower frequency-set -g ondemand
```
✅ **Extends battery life on laptops**  
✅ **Reduces CPU heat & fan noise**  

### **🔹 Make CPU Frequency Changes Persistent**  
Add the command to `/etc/rc.local` or create a systemd service.

1️⃣ **Create a script**:  
```bash
sudo nano /etc/init.d/cpufreq_performance
```
Add:
```bash
#!/bin/bash
cpupower frequency-set -g performance
```
Save & exit.

2️⃣ **Make it executable**:  
```bash
sudo chmod +x /etc/init.d/cpufreq_performance
```

3️⃣ **Enable at startup**:  
```bash
sudo update-rc.d cpufreq_performance defaults
```

---

## **6️⃣ Troubleshooting**
### **🔹 `cpupower` or `cpufreq-set` Command Not Found?**
- Install:  
  ```bash
  sudo apt install linux-tools-common cpufrequtils -y
  ```

### **🔹 Changes Reset After Reboot?**
- Add commands to `/etc/rc.local`  
- Use systemd service to apply settings on boot  

### **🔹 Settings Not Applying?**
- Check if another power management tool (like TLP) is overriding settings:
  ```bash
  sudo systemctl status tlp
  ```
  If running, stop and disable it:
  ```bash
  sudo systemctl stop tlp
  sudo systemctl disable tlp
  ```

---

## **7️⃣ Best Practices for System Administrators**
✅ **Use `performance` mode when compiling or running heavy workloads.**  
✅ **Use `ondemand` or `powersave` mode for general use and laptops.**  
✅ **Monitor CPU load and frequency using `htop` or `turbostat`.**  
✅ **Automate CPU settings using systemd or boot scripts.**  
✅ **Regularly check CPU temperature and power consumption to optimize efficiency.**  

---

### **💡 Summary**
- **CPU governors** control frequency scaling.
- Use `cpupower` or `cpufreq-set` to manage CPU frequency.
- System admins should automate settings using scripts/systemd.
- Monitor CPU power and temperature for optimal performance.

🚀 **Let me know if you need further guidance!**
