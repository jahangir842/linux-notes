# pfSense Firewall

## **Introduction**

**pfSense** is an open-source firewall and router software distribution based on FreeBSD. It provides a robust, flexible, and scalable solution for network security and management. pfSense can be used for various purposes, including network firewalling, VPN services, load balancing, and more.

## **Key Features**

1. **Firewall and NAT**: Advanced filtering capabilities and network address translation (NAT) to control network traffic.
2. **VPN**: Supports various VPN technologies, including IPsec, OpenVPN, and L2TP.
3. **Routing**: Static and dynamic routing protocols like OSPF, BGP, and RIP.
4. **Traffic Shaping**: Bandwidth management and quality of service (QoS).
5. **Intrusion Detection and Prevention**: Integration with Snort or Suricata for network threat detection.
6. **High Availability**: Supports failover and redundancy with CARP (Common Address Redundancy Protocol).
7. **Monitoring and Reporting**: Comprehensive monitoring tools and reporting options.
8. **User Authentication**: Integration with LDAP, RADIUS, and other authentication services.

## **Installation**

### **Requirements**

- **Hardware**: A compatible PC or virtual machine with at least 1 GB RAM, 4 GB disk space, and two network interfaces.
- **Media**: A bootable USB stick or CD/DVD with the pfSense image.

### **Steps to Install pfSense**

1. **Download pfSense**: Go to the [pfSense website](https://www.pfsense.org/download/) and download the appropriate image for your hardware (e.g., USB memstick installer for USB installation).

2. **Create Bootable Media**:
   - For USB: Use tools like Rufus (Windows) or `dd` command (Linux/macOS) to create a bootable USB drive.
   - For CD/DVD: Burn the ISO image to a CD/DVD.

3. **Boot from Media**: Insert the bootable media into your system and boot from it.

4. **Install pfSense**:
   - Select the option to install pfSense from the boot menu.
   - Follow the on-screen prompts to choose the installation disk and configure partitions.
   - After installation, remove the bootable media and reboot the system.

5. **Initial Configuration**:
   - On the first boot, you’ll be guided through the setup process using a console interface.
   - Assign interfaces (WAN, LAN) and configure basic network settings.

## **Basic Configuration**

### **Accessing the Web Interface**

1. **Connect to the LAN Interface**: Ensure your computer is connected to the LAN interface of pfSense.
2. **Open a Web Browser**: Navigate to `http://192.168.1.1` (default IP address).
3. **Login**: Use the default username (`admin`) and password (`pfsense`).

### **Initial Setup Wizard**

1. **General Setup**:
   - Configure the hostname, domain, and primary DNS server.
2. **Interfaces**:
   - Set up WAN and LAN interfaces with appropriate IP settings.
3. **Set Admin Password**:
   - Change the default password to secure the web interface.

### **Firewall Rules**

1. **Navigate to Firewall Rules**: Go to `Firewall` > `Rules`.
2. **Add Rules**:
   - Define rules to allow or block traffic based on source, destination, and protocol.
   - Example: To allow HTTP traffic from LAN to WAN, create a rule allowing traffic on port 80.

## **Advanced Configuration**

### **VPN Setup**

- **OpenVPN**:
  - Go to `VPN` > `OpenVPN` to set up an OpenVPN server or client.
  - Configure server settings, client export options, and firewall rules for VPN traffic.

- **IPsec**:
  - Navigate to `VPN` > `IPsec` to configure IPsec tunnels.
  - Set up Phase 1 and Phase 2 settings for site-to-site or remote access VPNs.

### **Traffic Shaping**

1. **Navigate to Traffic Shaper**: Go to `Firewall` > `Traffic Shaper`.
2. **Setup**:
   - Use the wizard to define traffic shaping rules based on bandwidth, priority, and queueing.

### **High Availability**

- **CARP (Common Address Redundancy Protocol)**:
  - Go to `Firewall` > `Virtual IPs` to configure CARP virtual IPs.
  - Set up multiple pfSense instances to provide failover and load balancing.

### **Monitoring and Logging**

1. **System Logs**:
   - Access logs at `Status` > `System Logs` to view firewall, system, and VPN logs.
2. **Monitoring Tools**:
   - Use tools like `Status` > `Dashboard` to monitor system performance and network traffic.

## **Security Best Practices**

1. **Update Regularly**: Keep pfSense updated with the latest security patches.
2. **Change Default Credentials**: Always change default passwords and use strong credentials.
3. **Backup Configuration**: Regularly backup pfSense configurations to restore settings in case of failure.
4. **Implement Access Controls**: Restrict web interface access to trusted IP addresses.
5. **Configure Intrusion Detection**: Use Snort or Suricata for additional network security.

## **Troubleshooting**

- **Connectivity Issues**:
  - Check interface settings and cable connections.
  - Use tools like `ping` and `traceroute` from the Diagnostics menu.

- **Firewall Rules**:
  - Verify rule order and ensure rules are not unintentionally blocking traffic.

- **Logs**:
  - Review system and firewall logs for error messages or unusual activity.

## **Conclusion**

pfSense is a versatile and powerful firewall and router solution suitable for a wide range of network environments. By following these notes, you can effectively install, configure, and manage pfSense to meet your network security and management needs.

For more detailed information, refer to the [pfSense Documentation](https://docs.netgate.com/pfsense/en/latest/) and the pfSense community forums for support and troubleshooting.

--- 

Feel free to modify or expand on these notes based on your specific use case or additional details you may need.
