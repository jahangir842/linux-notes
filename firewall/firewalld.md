Here's a rewritten and enhanced version of the content:

---

### **What is `firewalld` and `firewall-cmd`?**
`firewalld` is a dynamic firewall management tool for Linux that offers enhanced flexibility over traditional static tools like `iptables`. It supports network/firewall zones to group interfaces and apply specific rules, making it ideal for managing firewall configurations in a more dynamic and granular manner. The `firewall-cmd` command-line client allows users to interact with `firewalld` for configuring and managing these rules.

---

### **Installing `firewalld` and `firewall-cmd`**

To install `firewalld` on your system, run the following commands:

```bash
sudo dnf update
sudo dnf install firewalld
```

---

### **Enable and Start `firewalld`**

To enable and start the `firewalld` service, use:

```bash
sudo systemctl enable firewalld
sudo systemctl start firewalld
```

---

### **Check the Status of `firewalld`**

To check whether `firewalld` is running:

```bash
sudo systemctl status firewalld
```

---

### **Check Firewall State**

To verify the current state of the firewall:

```bash
sudo firewall-cmd --state
```

---

### **List Active Firewall Rules**

To view all active firewall rules:

```bash
sudo firewall-cmd --list-all
```

---

### **Adding and Removing Rules**

#### **Add a Port to the Firewall**

To allow traffic on a specific port (e.g., 9100 for Prometheus Node Exporter):

```bash
sudo firewall-cmd --permanent --add-port=9100/tcp
sudo firewall-cmd --reload
```

#### **Remove a Port from the Firewall**

To remove a port (e.g., port 9100) from the firewall:

```bash
sudo firewall-cmd --permanent --remove-port=9100/tcp
sudo firewall-cmd --reload
```

#### **Add a Service to the Firewall**

To allow a predefined service (e.g., HTTP or HTTPS):

```bash
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
sudo firewall-cmd --reload
```

#### **Remove a Service from the Firewall**

To remove a service (e.g., HTTP) from the firewall:

```bash
sudo firewall-cmd --permanent --remove-service=http
sudo firewall-cmd --reload
```

---

### **Understanding Zones**

`firewalld` uses zones to define the trust level for different network connections. Each zone can have its own set of rules to control traffic.

#### **Get the Default Zone**

To view the default zone:

```bash
sudo firewall-cmd --get-default-zone
```

#### **List All Zones**

To see all available zones:

```bash
sudo firewall-cmd --get-zones
```

#### **Get Information About a Specific Zone**

To get detailed information about a specific zone (e.g., the `public` zone):

```bash
sudo firewall-cmd --zone=public --list-all
```

#### **Change the Default Zone**

To change the default zone to a different zone (e.g., `home`):

```bash
sudo firewall-cmd --set-default-zone=home
```

---

### **Rich Rules**

Rich rules offer more complex rule definitions, providing advanced control over your firewall configurations.

#### **Add a Rich Rule**

To allow a specific source IP address (e.g., `192.168.1.10`) access to port 22 (SSH):

```bash
sudo firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source address="192.168.1.10" port port=22 protocol=tcp accept'
sudo firewall-cmd --reload
```

#### **Remove a Rich Rule**

To remove the previously added rich rule:

```bash
sudo firewall-cmd --permanent --remove-rich-rule='rule family="ipv4" source address="192.168.1.10" port port=22 protocol=tcp accept'
sudo firewall-cmd --reload
```

---

### **Example Workflow: Configure Firewall for Prometheus Node Exporter**

#### **1. Ensure `firewalld` is Installed and Running**

```bash
sudo dnf install firewalld
sudo systemctl enable firewalld
sudo systemctl start firewalld
```

#### **2. Check the Current Firewall Status**

To verify the firewall's state and active rules:

```bash
sudo firewall-cmd --state
sudo firewall-cmd --list-all
```

#### **3. Allow Port 9100 for Node Exporter**

```bash
sudo firewall-cmd --permanent --add-port=9100/tcp
sudo firewall-cmd --reload
```

#### **4. Verify the Changes**

To ensure the changes were applied successfully:

```bash
sudo firewall-cmd --list-all
```

---

### **Summary**

- **`firewalld`** provides dynamic firewall management using zones and services.
- **`firewall-cmd`** is used to configure and manage these settings from the command line.
- You can add/remove ports, services, or even define advanced **rich rules** to fine-tune your firewall configuration.
- **Zones** define the trust level of network connections, and the **default zone** can be customized.
- Ensure to reload the firewall with `--reload` after making permanent changes.

With these steps, you should now be able to manage your firewall settings effectively on AlmaLinux! 🚀
