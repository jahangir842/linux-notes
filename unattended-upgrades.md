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

## Example File:

### **1. Allowed Origins**
The section `Unattended-Upgrade::Allowed-Origins` specifies which repositories or origins are allowed to provide updates for unattended upgrades.

#### Current Configuration:
```
// Allowed origins
Unattended-Upgrade::Allowed-Origins {
    "${distro_id}:${distro_codename}";
    "${distro_id}:${distro_codename}-security";
    "${distro_id}ESMApps:${distro_codename}-apps-security";
    "${distro_id}ESM:${distro_codename}-infra-security";
    // "${distro_id}:${distro_codename}-updates";
    // "${distro_id}:${distro_codename}-proposed";
    // "${distro_id}:${distro_codename}-backports";
};
```

- **`${distro_id}:${distro_codename}`**: Includes general updates for the distribution.
- **`${distro_id}:${distro_codename}-security`**: Includes security updates (enabled by default).
- **`ESMApps` and `ESM`**: Extended Security Maintenance (for enterprise use). These entries are placeholders and may not be functional unless you enable ESM.
- **Commented Lines**:
  - `-updates`: General updates that are not necessarily security-related (disabled here).
  - `-proposed`: Pre-release packages (disabled by default to avoid instability).
  - `-backports`: Updates from the backports repository (disabled by default).

---

### **2. Package Blacklist**
The `Unattended-Upgrade::Package-Blacklist` section allows you to **exclude specific packages** from being automatically upgraded.

#### Current Configuration:
```
// Package Blacklist
Unattended-Upgrade::Package-Blacklist {
    // Exclude all packages starting with "linux-"
    // "linux-";

    // Exclude specific versions of libc6
    // "libc6$";
    // "libc6-dev$";
    // "libc6-i686$";
};
```

- Packages matching the patterns listed here will not be automatically updated.
- Examples:
  - `"linux-"`: Prevents kernel updates.
  - `"libc6$"`: Matches exactly `libc6` (useful for avoiding potentially breaking updates).
  - To enable exclusions, uncomment the corresponding lines.

---

### **3. What You Can Do**
#### Enable Additional Updates
To allow more updates (e.g., general updates or backports), uncomment the relevant lines:
```
// "${distro_id}:${distro_codename}-updates";
// "${distro_id}:${distro_codename}-backports";
```
Change to:
``` 
"${distro_id}:${distro_codename}-updates";
"${distro_id}:${distro_codename}-backports";
```

---

#### Exclude Specific Packages
If you want to exclude specific packages from being updated automatically, uncomment or add entries in the `Package-Blacklist` section.

Example:
To prevent kernel updates, uncomment this line:
``` 
"linux-";
```

---

#### Test the Configuration
Run this command to simulate unattended upgrades and confirm the configuration:
```bash
sudo unattended-upgrade --dry-run --debug
```

---

### Summary:
- **Allowed Origins**: Controls which repositories provide updates.
- **Package Blacklist**: Specifies packages to exclude.
- **Uncomment to Enable**: Uncomment lines to include `-updates` or other repositories.
- Use the `unattended-upgrade --dry-run` command to verify your configuration without actually applying updates.

Let me know if you need further assistance!
