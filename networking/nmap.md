# **📌 Nmap (Network Mapper) Cheat Sheet with Explanations**  

**Nmap (Network Mapper)** is an **open-source network scanning tool** used for **network discovery, security auditing, and vulnerability assessments**. It can detect **live hosts, open ports, running services, OS details, and even vulnerabilities** using its **scripting engine**.

---

## **🔹 Basic Scanning**  

### **1️⃣ Scan a Single IP or Hostname**  
**Purpose:** Checks if the target is online and identifies basic information.  
```sh
nmap 192.168.1.1
nmap example.com
```
📌 *Scans a single IP (`192.168.1.1`) or domain (`example.com`) to check for live status and accessible ports.*  

### **2️⃣ Scan a Range of IP Addresses**  
**Purpose:** Finds active devices within a specific IP range.  
```sh
nmap 192.168.1.1-254
```
📌 *Scans all devices in the range `192.168.1.1` to `192.168.1.254` to identify active hosts.*  

### **3️⃣ Scan an Entire Subnet**  
**Purpose:** Discovers all active hosts in a subnet.  
```sh
nmap 192.168.1.0/24
```
📌 *Scans all `256` IP addresses in the `192.168.1.0/24` subnet.*  

---

## **🔹 Port Scanning**  

### **4️⃣ Scan the Most Common 1000 Ports**  
**Purpose:** Identifies frequently used open ports.  
```sh
nmap -p- 192.168.1.1
```
📌 *Scans all `65535` ports on `192.168.1.1`, instead of just the default 1000 ports.*  

### **5️⃣ Scan Specific Ports**  
**Purpose:** Checks whether specific ports are open.  
```sh
nmap -p 22,80,443 192.168.1.1
```
📌 *Scans ports `22 (SSH)`, `80 (HTTP)`, and `443 (HTTPS)` on `192.168.1.1`.*  

### **6️⃣ Scan a Range of Ports**  
**Purpose:** Looks for open ports within a specified range.  
```sh
nmap -p 1-65535 192.168.1.1
```
📌 *Scans all `65535` ports to find open services on the target machine.*  

---

## **🔹 Service and Version Detection**  

### **7️⃣ Detect Running Services and Versions**  
**Purpose:** Identifies software running on open ports.  
```sh
nmap -sV 192.168.1.1
```
📌 *Detects service versions (`Apache`, `SSH`, `MySQL`, etc.) running on open ports.*  

### **8️⃣ Perform an Aggressive Scan**  
**Purpose:** Collects **detailed information** (OS, services, scripts, traceroute).  
```sh
nmap -A 192.168.1.1
```
📌 *Performs service detection (`-sV`), OS detection (`-O`), script scanning, and traceroute in one command.*  

### **9️⃣ Detect Operating System**  
**Purpose:** Identifies the **OS** running on the target.  
```sh
nmap -O 192.168.1.1
```
📌 *Uses TCP/IP fingerprinting to determine the operating system (`Linux`, `Windows`, `MacOS`).*  

---

## **🔹 Scan Types**  

### **🔟 TCP Connect Scan (Default)**  
**Purpose:** Establishes a full **TCP connection** to detect open ports.  
```sh
nmap -sT 192.168.1.1
```
📌 *More **reliable** but **easily detectable** by firewalls and IDS.*  

### **1️⃣1️⃣ SYN Scan (Stealth Scan, Requires Root Privileges)**  
**Purpose:** Performs a **stealthy scan** without completing a full connection.  
```sh
sudo nmap -sS 192.168.1.1
```
📌 *Sends a `SYN` request but doesn’t complete the connection (`half-open scan`), making it less detectable.*  

### **1️⃣2️⃣ UDP Scan**  
**Purpose:** Checks for open **UDP** ports (DNS, SNMP, etc.).  
```sh
sudo nmap -sU 192.168.1.1
```
📌 *Scans services running over **UDP**, such as **DNS (53), SNMP (161), and DHCP (67/68)**.*  

---

## **🔹 Saving Scan Results**  

### **1️⃣3️⃣ Save Results in Multiple Formats**  
**Purpose:** Stores results in normal, XML, and grepable formats.  
```sh
nmap -oN output.txt -oX output.xml -oG output.gnmap 192.168.1.1
```
📌 *Useful for later analysis or automation in security tools.*  

### **1️⃣4️⃣ Save Results in Normal Format Only**  
**Purpose:** Saves output in a simple text file.  
```sh
nmap -oN output.txt 192.168.1.1
```
📌 *Stores scan output in a human-readable format (`output.txt`).*  

---

## **🔹 Nmap Scripting Engine (NSE) Commands**  

### **1️⃣5️⃣ Run a Specific Script**  
**Purpose:** Uses **Nmap Scripting Engine (NSE)** to detect vulnerabilities or extract details.  
```sh
nmap --script=http-enum 192.168.1.1
```
📌 *Runs `http-enum` script to identify web server directories and files.*  

### **1️⃣6️⃣ Run All Safe Scripts**  
**Purpose:** Executes **non-intrusive scripts** for information gathering.  
```sh
nmap --script=safe 192.168.1.1
```
📌 *Runs all scripts labeled as `safe`, avoiding **aggressive** or **malicious** actions.*  

---

## **🔹 Advanced Scanning Examples**  

### **1️⃣7️⃣ Scan for Open Ports and Running Services on a Single IP**  
```sh
nmap -sV 192.168.1.1
```
📌 *Identifies open ports and the services running on them.*  

### **1️⃣8️⃣ Perform a Stealth Scan (SYN Scan) on a Subnet and Save Results**  
```sh
sudo nmap -sS 192.168.1.0/24 -oN subnet_scan.txt
```
📌 *Scans all `256` IPs in `192.168.1.0/24` subnet and saves results to `subnet_scan.txt`.*  

### **1️⃣9️⃣ Detect OS and Version Information for a Specific IP**  
```sh
nmap -A 192.168.1.1
```
📌 *Provides OS, version, and additional details for **in-depth** host analysis.*  

---

# **💡 Conclusion**  
✅ **Nmap** is an essential tool for **network scanning, security auditing, and penetration testing**.  
✅ It provides **detailed information** about **hosts, open ports, services, operating systems, and vulnerabilities**.  
✅ The **NSE (Nmap Scripting Engine)** adds **powerful automation** for security assessments.  

🚀 *Mastering these Nmap commands will help in **network security assessments, penetration testing, and troubleshooting**!*  

---
