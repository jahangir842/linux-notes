To configure the IP address and other network settings on Rocky Linux Minimal, you can follow these two methods:

## Configure with DHCP:

To configure your Rocky Linux Minimal system to use DHCP for automatic IP address assignment, follow these steps:

### 1. **Identify Network Interface**
   First, identify the name of your network interface:
   ```bash
   ip addr
   ```
   Look for the interface name, which is usually something like `eth0`, `enp0s3`, or similar.

### 2. **Configure DHCP**
   Edit the network interface configuration file located in `/etc/sysconfig/network-scripts/`.

   Example for `ifcfg-enp0s3`:
   ```bash
   sudo nano /etc/sysconfig/network-scripts/ifcfg-enp0s3
   ```

   Modify or add the following lines to enable DHCP:
   ```bash
   DEVICE=enp0s3
   BOOTPROTO=dhcp
   ONBOOT=yes
   ```

   - `BOOTPROTO=dhcp`: This tells the system to use DHCP for IP assignment.
   - `ONBOOT=yes`: This ensures the network interface is brought up automatically on boot.

### 3. **Restart Network Service**
   After configuring the interface for DHCP, restart the network service to apply the changes:
   ```bash
   sudo systemctl restart NetworkManager
   ```

### 4. **Verify Configuration**
   Check if the IP address has been assigned by DHCP:
   ```bash
   ip addr
   ```

   You should see an IP address assigned to your interface by the DHCP server.

### 5. **Enable Networking on Boot**
   Ensure that networking is enabled to start at boot:
   ```bash
   sudo systemctl enable NetworkManager
   ```

With these steps, your Rocky Linux Minimal system will obtain an IP address automatically via DHCP.

---

## Configure with Static IP:

### 1. **Identify Network Interface**
   First, identify the name of your network interface:
   ```bash
   ip addr
   ```
   Look for the interface name, which is usually something like `eth0`, `enp0s3`, or similar.






### 2. **Configure Static IP**
   If you want to set a static IP address, you can create or edit a configuration file for your network interface in the `/etc/sysconfig/network-scripts/` directory.

   Create or edit a file named `ifcfg-<interface_name>` (replace `<interface_name>` with your actual interface name).

   Example for `ifcfg-enp0s3`:
   ```bash
   sudo nano /etc/sysconfig/network-scripts/ifcfg-enp0s3
   ```

   Add or modify the following lines:
   ```bash
   DEVICE=enp0s3
   BOOTPROTO=none
   ONBOOT=yes
   IPADDR=192.168.1.100
   PREFIX=24
   GATEWAY=192.168.1.1
   DNS1=8.8.8.8
   DNS2=8.8.4.4
   ```

   Replace the `IPADDR`, `GATEWAY`, and `DNS` values with the appropriate values for your network.

### 3. **Restart Network Service**
   After configuring the IP settings, restart the network service to apply the changes:
   ```bash
   sudo systemctl restart NetworkManager
   ```

### 4. **Verify Configuration**
   Check if the IP address has been configured correctly:
   ```bash
   ip addr
   ```

   You can also test connectivity by pinging a known IP or domain:
   ```bash
   ping 8.8.8.8
   ```

### 5. **Configure Hostname (Optional)**
   You might also want to set a hostname:
   ```bash
   sudo hostnamectl set-hostname your-hostname
   ```

### 6. **Enable Networking on Boot**
   Ensure that networking is enabled to start at boot:
   ```bash
   sudo systemctl enable NetworkManager
   ```

These steps should configure the IP and network settings on your Rocky Linux Minimal installation.
