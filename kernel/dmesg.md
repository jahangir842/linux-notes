# **🔹 `dmesg` Command in Linux – Detailed Guide**  

The `dmesg` (display message) command in Linux is used to **view system logs** related to **kernel messages**. It is especially useful for debugging hardware issues, checking boot logs, and troubleshooting system errors.

---

## **📌 Syntax of `dmesg`**
```sh
dmesg [options]
```
- **No options** → Displays all kernel messages.
- **Options** → Filters output based on time, log levels, etc.

---

## **🔹 What Does `dmesg` Do?**
- Reads logs from **`/var/log/dmesg`** or the **`/dev/kmsg`** device.
- Shows **hardware initialization messages** during boot.
- Displays logs related to **device drivers, CPU, memory, networking**, etc.
- Helps in **debugging crashes, hardware failures, and driver issues**.

---

## **🔹 Viewing Kernel Logs with `dmesg`**
### **1️⃣ Display All Kernel Messages**
```sh
dmesg
```
📌 *Shows all kernel messages in chronological order.*

---

### **2️⃣ Filter Logs by Time**
#### **Show Logs with Human-Readable Timestamps**
```sh
dmesg -T
```
📌 *Converts timestamps to human-readable format.*

🔹 **Example Output:**
```
[Mon Feb 19 10:15:32 2024] Linux version 5.15.0-72-generic ...
[Mon Feb 19 10:15:33 2024] ACPI: Power Button [PWRF]
```

---

### **3️⃣ Filtering Messages by Severity**
Kernel messages have **log levels** ranging from **emergency (0)** to **debugging (7)**.

| Log Level | Priority | Description |
|-----------|----------|------------------------------|
| 0 | **emerg** | System is unusable |
| 1 | **alert** | Immediate action needed |
| 2 | **crit** | Critical condition |
| 3 | **err** | Error condition |
| 4 | **warn** | Warning condition |
| 5 | **notice** | Normal but significant event |
| 6 | **info** | Informational message |
| 7 | **debug** | Debugging message |

#### **Show Only Errors**
```sh
dmesg --level=err
```
#### **Show Warnings and Errors**
```sh
dmesg --level=warn,err
```

---

### **4️⃣ Searching Specific Keywords**
#### **Find Messages Related to CPU**
```sh
dmesg | grep -i cpu
```
#### **Check Network Driver Logs**
```sh
dmesg | grep -i eth
```

---

### **5️⃣ Monitoring Kernel Logs in Real-Time**
```sh
dmesg -w
```
📌 *Keeps updating the log output as new messages are added.*

---

### **6️⃣ Saving Logs to a File**
```sh
dmesg > dmesg.log
```
📌 *Saves kernel messages to `dmesg.log` for future analysis.*

---

## **🔹 Advanced Usage of `dmesg`**
### **7️⃣ Checking Boot Logs**
```sh
dmesg | less
```
📌 *Use arrow keys to navigate through boot logs.*

---

### **8️⃣ Debugging Hardware Issues**
#### **Check USB Devices**
```sh
dmesg | grep -i usb
```
📌 *Shows logs related to USB devices (plug/unplug events, errors).*

#### **Check Memory Errors**
```sh
dmesg | grep -i memory
```
📌 *Displays memory allocation and failure messages.*

---

### **9️⃣ Clearing Kernel Logs**
```sh
sudo dmesg -C
```
📌 *Clears kernel ring buffer (useful when debugging issues).*

---

## **🔹 Where `dmesg` Stores Logs**
- The **kernel ring buffer** holds temporary logs.
- Persistent logs are stored in:
  - **`/var/log/dmesg`** (on some distros).
  - **`/var/log/kern.log`** (for kernel logs).

---

## **🔹 Summary**
✅ `dmesg` is a powerful tool for **system debugging** and **hardware monitoring**.  
✅ It displays logs related to **boot messages, devices, networking, CPU, memory, and more**.  
✅ Use **filters and options** to view specific logs efficiently.  
✅ Combine with `grep`, `less`, and `tee` for **better analysis and troubleshooting**.  

🚀 *Let me know if you need more details!*
