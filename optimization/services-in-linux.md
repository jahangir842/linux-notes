### **Notes on Managing and Monitoring Services in Ubuntu**

When a system becomes slow, it’s often due to unnecessary services consuming resources. Monitoring and managing services can help optimize performance.

---

#### **1. Listing Services**

- **Check Active Services**  
  Lists only services currently running:  
  ```bash
  systemctl list-units --type=service --state=running
  ```

- **Check All Services (Active and Inactive)**  
  Shows the status of all services:  
  ```bash
  systemctl list-units --type=service
  ```

- **View Failed Services**  
  Displays services that failed to start or crashed:  
  ```bash
  systemctl --failed
  ```

---

#### **2. Analyzing Resource Usage**

- **Using `top`**  
  Real-time view of running processes sorted by resource usage:  
  ```bash
  top
  ```

- **Using `htop`**  
  An interactive and user-friendly version of `top`:  
  ```bash
  htop
  ```

- **Using `ps` for Specific Services**  
  Check memory-heavy processes:  
  ```bash
  ps aux --sort=-%mem | head -10
  ```

- **Using `systemd-cgtop`**  
  Monitors resource usage by system services:  
  ```bash
  systemd-cgtop
  ```

---

#### **3. Stopping and Disabling Services**

- **Stop a Service Temporarily**  
  Stops the service until the next reboot:  
  ```bash
  sudo systemctl stop <service-name>
  ```

- **Disable a Service from Starting at Boot**  
  Prevents the service from starting automatically:  
  ```bash
  sudo systemctl disable <service-name>
  ```

- **Mask a Service**  
  Prevents the service from being started manually or automatically:  
  ```bash
  sudo systemctl mask <service-name>
  ```

---

#### **4. Managing Installed Software**

- **List Installed Packages**  
  Shows all installed software:  
  ```bash
  dpkg --get-selections
  ```

- **Search for a Specific Package**  
  ```bash
  dpkg -l | grep <package-name>
  ```

- **Remove Unnecessary Software**  
  Uninstalls software and cleans up unused dependencies:  
  ```bash
  sudo apt remove <package-name>
  sudo apt autoremove
  ```

---

#### **5. Boot Services**

- **List Services Enabled at Boot**  
  Displays services configured to start automatically:  
  ```bash
  systemctl list-unit-files --type=service | grep enabled
  ```

- **Disable Unnecessary Boot Services**  
  Prevents specific services from starting at boot:  
  ```bash
  sudo systemctl disable <service-name>
  ```

---

#### **6. Monitor Resource Usage**

- **Glances**  
  A comprehensive monitoring tool:  
  ```bash
  glances
  ```

- **nmon**  
  A detailed performance monitoring tool:  
  ```bash
  sudo apt install nmon
  nmon
  ```

---

#### **7. Scheduled Tasks**

- **Check User-Specific Cron Jobs**  
  ```bash
  crontab -l
  ```

- **Check System-Wide Cron Jobs**  
  ```bash
  sudo cat /etc/crontab
  sudo ls /etc/cron.d/
  ```

---

#### **8. Reclaim Space and Clean Up**

- **Remove Old Kernels**  
  Deletes unused kernels:  
  ```bash
  sudo apt autoremove --purge
  ```

- **Clean Package Cache**  
  Frees up space by removing cached packages:  
  ```bash
  sudo apt clean
  sudo apt autoclean
  ```

- **Analyze Disk Usage**  
  Identifies large files or directories:  
  ```bash
  sudo du -sh /var/*
  ```

---

#### **Best Practices**
1. Regularly review and stop unnecessary services.
2. Monitor system resource usage periodically.
3. Keep services running only if required.
4. Use lightweight alternatives for resource-heavy software.

By managing running services and monitoring their resource usage, you can significantly improve your Ubuntu system's performance.
