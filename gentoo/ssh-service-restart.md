To restart the SSH service on a Gentoo system, you will typically use the `openrc` init system, which is the default for Gentoo.

### 1. **Restart SSH Service Using `openrc`**

If you are using the default OpenRC system (common in Gentoo), the SSH service is typically managed by the `sshd` service.

Run the following command to restart the SSH service:

```bash
sudo /etc/init.d/sshd restart
```

This will restart the SSH service and apply any changes made to the SSH configuration.

### 2. **Check the Status of the SSH Service**

If you want to check the status of the SSH service, you can use the following command:

```bash
sudo /etc/init.d/sshd status
```

This will show you whether the SSH service is running or not.

### 3. **Start or Stop SSH Service (Optional)**

If you want to manually start or stop the SSH service, use these commands:

- **Start SSH**:
  ```bash
  sudo /etc/init.d/sshd start
  ```

- **Stop SSH**:
  ```bash
  sudo /etc/init.d/sshd stop
  ```

### 4. **Enable SSH Service on Boot (Optional)**

If you want the SSH service to start automatically on boot, you can enable it with the following command:

```bash
sudo rc-update add sshd default
```

### Summary of Commands:
- **Restart SSH service**:  
  ```bash
  sudo /etc/init.d/sshd restart
  ```
- **Check the status of SSH service**:  
  ```bash
  sudo /etc/init.d/sshd status
  ```
- **Start SSH service**:  
  ```bash
  sudo /etc/init.d/sshd start
  ```
- **Stop SSH service**:  
  ```bash
  sudo /etc/init.d/sshd stop
  ```
- **Enable SSH service on boot**:  
  ```bash
  sudo rc-update add sshd default
  ```

Let me know if you encounter any issues!
