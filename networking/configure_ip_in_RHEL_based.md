**NetworkManager**, and the traditional `ifcfg-` configuration files in `/etc/sysconfig/network-scripts/` are **deprecated**. Instead, AlmaLinux now uses **keyfile format** stored in:  

```
/etc/NetworkManager/system-connections/
```

---

### **🔹 How to Set a Static IP Permanently in AlmaLinux (Recommended)**
Since your system uses NetworkManager, use `nmcli`:

#### **1️⃣ List All Network Connections**
```sh
nmcli connection show
```
Find your connection name (e.g., `ens192` or `Wired connection 1`).

#### **2️⃣ Set a Static IP**
Replace `ens192` with your actual network interface:
```sh
sudo nmcli connection modify ens192 ipv4.addresses 192.168.1.100/24
sudo nmcli connection modify ens192 ipv4.gateway 192.168.1.1
sudo nmcli connection modify ens192 ipv4.dns 8.8.8.8
sudo nmcli connection modify ens192 ipv4.method manual
```

#### **3️⃣ Apply Changes**
```sh
sudo nmcli connection up ens192
```

---

### **🔹 Alternative: Edit Configuration Files**
If you prefer to manually edit the configuration file:

#### **1️⃣ Navigate to NetworkManager Config Directory**
```sh
cd /etc/NetworkManager/system-connections/
ls -l
```
You should see a file for your network connection (e.g., `ens192.nmconnection`).

#### **2️⃣ Edit the File**
```sh
sudo nano ens192.nmconnection
```

#### **3️⃣ Modify or Add These Lines**
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

### **🔹 Verify the New IP**
Check if your static IP is applied:
```sh
ip a
```
or
```sh
nmcli device show ens192
```

This will **persist after reboot**. 🚀 Let me know if you need further help!
