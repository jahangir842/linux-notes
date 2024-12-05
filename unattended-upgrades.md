### Notes on `unattended-upgrades`

The `unattended-upgrades` utility in Ubuntu automates the installation of software updates, focusing on security patches and other critical updates. It ensures systems stay up-to-date without requiring manual intervention.

---

#### **Key Features**
- Automatically installs updates for specified package origins (e.g., security updates).
- Reduces system vulnerability by applying patches promptly.
- Configurable for package whitelists and blacklists.
- Can work with metered connections if explicitly allowed.

---

#### **Installation**
To ensure `unattended-upgrades` is installed:
```bash
sudo apt update
sudo apt install unattended-upgrades
```

---

#### **Configuration**
The main configuration file is located at:
```plaintext
/etc/apt/apt.conf.d/50unattended-upgrades
```

##### Example Settings:
- **Allowed Origins**: Defines which updates to apply.
  ```plaintext
  Unattended-Upgrade::Allowed-Origins {
      "o=Ubuntu,a=stable";
      "o=Ubuntu,a=stable-security";
  };
  ```

- **Package Blacklist**: Prevent specific packages from being updated.
  ```plaintext
  Unattended-Upgrade::Package-Blacklist {
      "example-package";
  };
  ```

- **Automatic Reboot**: Reboot the system automatically if required by an update.
  ```plaintext
  Unattended-Upgrade::Automatic-Reboot "true";
  ```

- **Notifications**: Configure email notifications for update reports.
  ```plaintext
  Unattended-Upgrade::Mail "admin@example.com";
  ```

---

#### **Handling Metered Connections**
By default, `unattended-upgrades` does not run on metered connections (e.g., mobile data) to avoid unexpected data charges. 

##### Log Entry:
```plaintext
WARNING System is on metered connection, stopping
```

##### To Allow Updates on Metered Connections:
1. Edit the configuration file:
   ```bash
   sudo nano /etc/apt/apt.conf.d/20auto-upgrades
   ```
2. Add or modify the following setting:
   ```plaintext
   APT::Periodic::AllowUnauthenticated "1";
   APT::Get::AllowUnauthenticated "1";
   ```

3. Save and exit, then reload the configuration:
   ```bash
   sudo systemctl restart apt-daily.service
   ```

---

#### **Forcing `unattended-upgrades`**
To manually trigger the process:
```bash
sudo unattended-upgrades --verbose
```

---

#### **Log Files**
Logs provide insight into the actions performed by `unattended-upgrades`:
- **Main log**: 
  ```plaintext
  /var/log/unattended-upgrades/unattended-upgrades.log
  ```
  Example entries:
  - Start of script:
    ```plaintext
    INFO Starting unattended upgrades script
    ```
  - Allowed origins:
    ```plaintext
    INFO Allowed origins are: o=Ubuntu,a=noble-security
    ```
  - Issues with a metered connection:
    ```plaintext
    WARNING System is on metered connection, stopping
    ```

- **Detailed upgrade log**:
  ```plaintext
  /var/log/unattended-upgrades/unattended-upgrades-dpkg.log
  ```

---

#### **Disabling `unattended-upgrades`**
If you prefer manual updates:
1. Stop and disable the service:
   ```bash
   sudo systemctl stop unattended-upgrades.service
   sudo systemctl disable unattended-upgrades.service
   ```

2. Disable auto-updates:
   Edit `/etc/apt/apt.conf.d/20auto-upgrades`:
   ```plaintext
   APT::Periodic::Update-Package-Lists "0";
   APT::Periodic::Unattended-Upgrade "0";
   ```

---

#### **Troubleshooting**
- **Outdated Release Information**:
  If logs indicate issues like:
  ```plaintext
  Could not figure out development release: Distribution data outdated
  ```
  Update the `distro-info-data` package:
  ```bash
  sudo apt install distro-info-data
  ```

- **Stuck on a Lock**:
  If the process is stuck due to another package manager:
  ```bash
  sudo rm /var/lib/dpkg/lock-frontend
  ```

---

These settings and actions make `unattended-upgrades` a reliable solution for automated system maintenance. Adjust the configurations to align with your network and system requirements.
