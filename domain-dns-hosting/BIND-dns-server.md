## BIND DNS Server Setup Guide

### **Introduction to BIND**

BIND (Berkeley Internet Name Domain) is a widely used and highly reliable DNS software.

### **Verifying BIND Installation**

1. **Check if BIND (named) is installed:**

   ```bash
   dpkg -l | grep bind9
   ```

2. **Check if the BIND9 service is running:**

   ```bash
   sudo systemctl status bind9
   # or
   sudo systemctl status named
   ```

3. **Check if DNS port (53) is listening:**

   ```bash
   sudo ss -tuln | grep :53
   # or
   sudo nmap -sT -O localhost
   # or
   sudo lsof -i -P -n | grep LISTEN
   ```

---

## **Setting Hostname**

1. **Set a Fully Qualified Domain Name (FQDN):**

   An FQDN includes the hostname, domain name, and top-level domain (TLD), providing a complete path to a specific resource on the internet.

   ```bash
   sudo hostnamectl set-hostname ns1.jagz.ai
   ```

2. **Verify the hostname:**

   ```bash
   hostname
   ```

3. **Edit the `/etc/hosts` file:**

   Use a text editor like Nano or Vim to add your FQDN after `localhost`:

   ```plaintext
   127.0.0.1 localhost ns1.jagz.ai ns1
   ```

   Here, `ns1.jagz.ai` is the FQDN and `ns1` is the hostname.

4. **Restart the systemd-resolved service:**

   ```bash
   sudo systemctl restart systemd-resolved.service
   ```

---

## **BIND9 Installation**

1. **Update the system:**

   ```bash
   sudo apt update
   ```

2. **Install the BIND DNS server package:**

   ```bash
   sudo apt install bind9
   ```

3. **Verify the installation:**

   ```bash
   nslookup ns1
   ```

   Expected output:

   ```plaintext
   Server: 127.0.0.53
   Address: 127.0.0.53#53

   Name: ns1
   Address: 192.168.43.194
   Name: ns1
   Address: fe80::ed6f:4219:175:6bdd
   ```

   *Note: The server address (127.0.0.53) will be updated in later configurations.*

---

## **BIND9 Configuration**

### **Configuration Files**

BIND’s configuration files are located in the `/etc/bind/` directory. The main configuration file is `named.conf`.

1. **Edit the main configuration file:**

   ```bash
   sudo nano /etc/bind/named.conf
   ```

   Example content:

   ```plaintext
   // Primary configuration file for the BIND DNS server named.
   // Structure of BIND configuration files in Debian. Customize with caution.
   include "/etc/bind/named.conf.options"; // Global Options
   include "/etc/bind/named.conf.local"; // Zones Information
   include "/etc/bind/named.conf.default-zones"; // Default Zones
   ```

### **Global Options (named.conf.options)**

1. **Open the global options file:**

   ```bash
   sudo nano /etc/bind/named.conf.options
   ```

2. **Example configuration:**

   ```plaintext
   options {
       directory "/var/cache/bind";
       recursion yes;
       allow-query { any; }; // Restrict to subnet if needed
       listen-on port 53 {127.0.0.1; 192.168.43.194;}; // DNS IP addresses
       forwarders {
           8.8.8.8;    // Google's DNS server
           8.8.4.4;
       };
   };
   ```

3. **Check syntax:**

   ```bash
   sudo named-checkconf
   ```

   *This command checks for syntax errors in the BIND configuration files.*

### **Zones Information (named.conf.local)**

1. **Edit the local zones file:**

   ```bash
   sudo nano /etc/bind/named.conf.local
   ```

2. **Example zone configuration:**

   ```plaintext
   zone "jagz.ai" {
       type master;
       file "/etc/bind/zones/jagz.ai.zone";
   };

   zone "192.168.1.in-addr.arpa" {
       type master;
       file "/etc/bind/zones/1.168.192.in-addr.arpa.zone";
   };
   ```

   *In this example, `jagz.ai` and `192.168.1.in-addr.arpa` zones are defined with BIND as the master server.*

### **Default Zones (named.conf.default-zones)**

1. **Edit the default zones file:**

   ```bash
   sudo nano /etc/bind/named.conf.default-zones
   ```

2. **Example default zone configuration:**

   ```plaintext
   zone "." {
       type hint;
       file "/etc/bind/db.root";
   };

   zone "localhost" {
       type master;
       file "/etc/bind/db.local";
   };

   zone "127.in-addr.arpa" {
       type master;
       file "/etc/bind/db.127";
   };

   zone "0.in-addr.arpa" {
       type master;
       file "/etc/bind/db.0";
   };

   zone "255.in-addr.arpa" {
       type master;
       file "/etc/bind/db.255";
   };
   ```

   *These zones handle essential DNS functions, such as resolving root DNS servers and handling localhost queries.*

---

## **Creating Database (DB) Files**

1. **Create the zones directory:**

   ```bash
   sudo mkdir /etc/bind/zones
   ```

2. **Copy a template DB file:**

   ```bash
   sudo cp /etc/bind/db.local /etc/bind/zones/jagz.ai.zone
   ```

3. **Edit the new zone file:**

   ```bash
   sudo nano /etc/bind/zones/jagz.ai.zone
   ```

4. **Example configuration:**

   ```plaintext
   $TTL    604800
   @       IN      SOA     ns1.jagz.ai. admin.jagz.ai. (
                     3     ; Serial
                604800     ; Refresh
                 86400     ; Retry
               2419200     ; Expire
                604800 )   ; Negative Cache TTL
   ;
   ; Name servers - NS records
        IN      NS      ns1.jagz.ai.
        IN      NS      ns2.jagz.ai.

   ; Name servers - A records
   ns1.jagz.ai.          IN      A       192.168.43.194
   ns2.jagz.ai.          IN      A       192.168.43.195

   ; Host records - A records
   host1.nyc3.example.com.        IN      A      192.168.43.194
   host2.nyc3.example.com.        IN      A      192.168.43.195
   ```

---

## **Client Configuration**

### **For Linux Clients:**

1. **Configure `systemd-resolved`:**

   ```bash
   sudo nano /etc/systemd/resolved.conf
   ```

2. **In the `[Resolve]` section, add the DNS server:**

   ```plaintext
   DNS=192.168.43.194
   ```

3. **Restart `systemd-resolved`:**

   ```bash
   sudo systemctl restart systemd-resolved
   ```

4. **Verify DNS configuration:**

   ```bash
   resolvectl status
   ```

5. **Test DNS resolution:**

   ```bash
   nslookup www.google.com
   ```

   *Ensure that the DNS server used for resolution is `192.168.43.194`.*

### **Resolving Issues with 127.0.0.53**

1. **If the system is still resolving via `127.0.0.53`, manually update the DNS configuration:**

2. **Remove the existing symlink:**

   ```bash
   sudo rm /etc/resolv.conf
   ```

3. **Create a new `/etc/resolv.conf` file:**

   ```bash
   sudo nano /etc/resolv.conf
   ```

4. **Add the DNS server:**

   ```plaintext
   nameserver 192.168.43.194
   ```

5. **Make the file immutable to prevent overwriting:**

   ```bash
   sudo chattr +i /etc/resolv.conf
   ```

6. **Test DNS resolution:**

   ```bash
   nslookup www.google.com
   ```

   *Ensure that the DNS server used for resolution is `192.168.43.194`.*

---

This document provides a step-by-step guide for setting up a DNS server using BIND, from installation to configuration, ensuring a robust DNS environment.
