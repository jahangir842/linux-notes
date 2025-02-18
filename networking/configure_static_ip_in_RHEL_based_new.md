### **🔹 Configuring a Static IP in AlmaLinux**  

In modern RHEL-based distributions, **NetworkManager** has deprecated traditional network configuration files stored in:  

```
/etc/sysconfig/network-scripts/
```

Instead, AlmaLinux now uses the **keyfile format**, with configurations located in:  

```
/etc/NetworkManager/system-connections/
```

---

### **🔹 Recommended Method: Using `nmcli`**
Since AlmaLinux relies on **NetworkManager**, it's best to configure the static IP using `nmcli`:

#### **1️⃣ List Available Network Connections**
```sh
nmcli connection show
```
Identify the connection name (e.g., `ens192` or `Wired connection 1`).

#### **2️⃣ Assign a Static IP**
Replace `enp0s3` with your actual network interface name:
```sh
sudo nmcli connection modify enp0s3 ipv4.addresses 192.168.1.100/24
sudo nmcli connection modify enp0s3 ipv4.gateway 192.168.1.1
sudo nmcli connection modify enp0s3 ipv4.dns 8.8.8.8
sudo nmcli connection modify enp0s3 ipv4.method manual
```

#### **3️⃣ Apply Changes**
```sh
sudo nmcli connection up enp0s3
```

---

### **🔹 Alternative Method: Manually Editing Configuration Files**
If you prefer manual configuration:

#### **1️⃣ Navigate to NetworkManager's Configuration Directory**
```sh
cd /etc/NetworkManager/system-connections/
ls -l
```
Locate the file corresponding to your network interface (e.g., `enp0s3.nmconnection`).

#### **2️⃣ Edit the Configuration File**
```sh
sudo nano enp0s3.nmconnection
```

#### **3️⃣ Modify or Add the Following Lines**
```ini
[ipv4]
method=manual
addresses=192.168.1.100/24
gateway=192.168.1.1
dns=8.8.8.8;
```

#### **4️⃣ Restart NetworkManager**
```sh
sudo systemctl restart NetworkManager
```

---

### **🔹 Verify the Static IP Configuration**
Check if the new IP address has been applied:
```sh
ip a
```
or  
```sh
nmcli device show enp0s3
```

These changes will **persist after a reboot**. 🚀 Let me know if you need any assistance!
