### **What is `sysctl`?**
`sysctl` is a Linux utility that allows you to **view and modify kernel parameters** at runtime. These parameters control various aspects of system behavior, such as memory management, networking, and security.

### **Key Components:**
1. **Configuration Files:**
   - Persistent settings are stored in:
     - `/etc/sysctl.conf` (main file)
     - `/etc/sysctl.d/*.conf` (additional configuration files)

2. **Kernel Parameter Locations:**
   - Parameters are found under `/proc/sys/`
   - Example: `/proc/sys/net/ipv4/ip_forward` controls IP forwarding.

### **Common Commands:**
- **View all current settings:**
  ```sh
  sysctl -a
  ```
- **Check a specific parameter:**
  ```sh
  sysctl net.ipv4.ip_forward
  ```
- **Modify a parameter temporarily:**
  ```sh
  sysctl -w net.ipv4.ip_forward=1
  ```
  *(Changes will be lost after reboot.)*

- **Make a setting persistent:**
  Add to `/etc/sysctl.conf` or a file in `/etc/sysctl.d/`:
  ```sh
  echo "net.ipv4.ip_forward = 1" | sudo tee /etc/sysctl.d/99-custom.conf
  sudo sysctl --system  # Apply changes
  ```

Would you like help tuning any specific kernel parameters?
