## Upgrade Ubuntu 18.04 (Bionic) to 22.04 (Jammy Jellyfish)

---

### Official Guide:

https://documentation.ubuntu.com/server/how-to/software/upgrade-your-release/

---

### Detailed Procedure:

Upgrading your Ubuntu system from 18.04 LTS (Bionic Beaver) to 22.04 LTS (Jammy Jellyfish) is essential for security, new features, and performance improvements. The process ensures you’re using a supported version with access to updates and bug fixes. Below are the detailed steps, along with explanations about the tools involved (like `do-release-upgrade` and `dist-upgrade`) and the role of **PPAs** in the process.

---

### **1. Steps to Upgrade Ubuntu from 18.04 to 22.04**

#### **Prerequisites:**
- **Backup your data**: Always back up your important files before starting a major upgrade.
- **Stable internet connection**: Ensure you have a reliable network as the upgrade process involves downloading packages.
- **Sufficient disk space**: Make sure you have enough disk space for the new system and downloaded packages.

#### **Step-by-Step Upgrade Process:**

##### **1. Update All Installed Packages on Ubuntu 18.04**
Before upgrading the system, make sure all current packages are up-to-date.

Run the following commands to update and upgrade your packages:
```bash
sudo apt update
sudo apt upgrade
sudo apt full-upgrade
sudo apt dist-upgrade
```
- `apt update`: Updates the package lists.
- `apt upgrade`: Installs any available package updates.
- `apt dist-upgrade`: Handles package dependencies and ensures a more comprehensive upgrade, managing the removal of obsolete packages.

##### **2. Remove Unnecessary Packages**
Before upgrading, it's a good idea to clean up unnecessary packages and dependencies.
```bash
sudo apt autoremove
sudo apt clean
```

##### **3. Disable or Remove PPAs (Optional)**
Personal Package Archives (**PPAs**) may not be compatible with a new release, so it’s recommended to either remove or disable them before upgrading. This helps avoid conflicts and errors.

To list all enabled PPAs:
```bash
ls /etc/apt/sources.list.d/
```

To remove a PPA:
```bash
sudo add-apt-repository --remove ppa:example/ppa
```

To disable a PPA temporarily:
```bash
sudo nano /etc/apt/sources.list.d/<filename>.list
```
Comment out the PPA by adding a `#` in front of the line.

##### **4. Install the `update-manager-core` Package**
Ensure that the package responsible for system upgrades is installed:
```bash
sudo apt install update-manager-core
```

##### **5. Start the Upgrade to Ubuntu 22.04**
Run the following command to begin the upgrade process:
```bash
sudo do-release-upgrade
```
- Follow the prompts during the upgrade process, which will include confirmation of changes and handling package conflicts.

##### **6. Reboot the System**
Once the upgrade completes, reboot the system:
```bash
sudo reboot
```

##### **7. Post-Upgrade Checks**
After rebooting:
- Verify the new version:
```bash
lsb_release -a
```
You should see output indicating Ubuntu 22.04.
- Re-enable any previously disabled PPAs and reinstall software as necessary.
  
---

### **2. Difference Between `do-release-upgrade` and `dist-upgrade`**

Both `do-release-upgrade` and `dist-upgrade` are related to upgrading the system, but they serve different purposes.

#### **`do-release-upgrade`**:
- **Purpose**: Specifically used to upgrade the system to a new release (e.g., from Ubuntu 18.04 to 22.04).
- **How It Works**: It handles version upgrades by fetching new release files, updating the system repositories, and upgrading all installed packages to their versions in the new release.
- **Use Case**: Ideal for upgrading from one **Ubuntu release to another**, like from 18.04 to 22.04.
  
**Example:**
```bash
sudo do-release-upgrade
```

- **Handles release-specific tasks** like managing repository sources, PPAs, and third-party software.
  
#### **`dist-upgrade`**:
- **Purpose**: Used to perform a more comprehensive upgrade of all installed packages, but **does not** change the release version of Ubuntu.
- **How It Works**: In addition to upgrading packages like `apt upgrade`, it can install and remove packages to handle dependencies. It’s generally more aggressive in handling complex dependency issues.
- **Use Case**: Useful for **upgrading packages within the same release**, but not for upgrading to a new version of Ubuntu.

**Example:**
```bash
sudo apt dist-upgrade
```

- **Difference**: `dist-upgrade` upgrades packages within the same release, while `do-release-upgrade` upgrades to a new release version.

---

### **3. What Are PPAs (Personal Package Archives)?**

#### **Introduction to PPAs**:
PPAs (**Personal Package Archives**) are repositories hosted on **Launchpad** that allow developers to package software not included in the official Ubuntu repositories, or offer updated versions of existing software.

#### **How PPAs Work**:
When you add a PPA, the system fetches software from this third-party source. The PPA is added to your system’s list of software sources (located in `/etc/apt/sources.list.d/`), allowing `apt` to download and install the packages.

#### **Adding a PPA**:
You can add a PPA using the `add-apt-repository` command:
```bash
sudo add-apt-repository ppa:user/repository
sudo apt update
```

#### **Role of PPAs in System Upgrades**:
When upgrading your system, PPAs can cause compatibility issues, as packages from the PPA may not be available or compatible with the new version of Ubuntu. It is advised to disable or remove PPAs before upgrading.

- **Why Disable PPAs During Upgrades**:
   - **Compatibility Issues**: PPA packages may not yet support the new version of Ubuntu.
   - **Conflict Resolution**: Old PPAs might conflict with newer packages during the upgrade process.
  
#### **Example**:
To remove a PPA:
```bash
sudo add-apt-repository --remove ppa:user/repository
```

To re-enable a PPA after an upgrade, you can uncomment the repository lines or add them back.

#### **Why You Don’t Provide a URL for PPAs**:
When adding a PPA, you don’t need to specify a full web URL because the system automatically handles the resolution of the PPA name to the full URL. For example, `ppa:git-core/ppa` is translated into the actual repository URL `http://ppa.launchpad.net/git-core/ppa/ubuntu`.

---

### **4. Key Considerations During an Upgrade**

#### **Backup Important Data**:
Upgrades can sometimes cause unexpected problems, so ensure that your data is backed up before you begin.

#### **Check Third-Party Software and PPAs**:
PPAs and third-party software may not have updates available for the new release. It’s important to check their compatibility or temporarily disable them.

#### **Monitor for Errors or Conflicts**:
During the upgrade, you may be asked to confirm replacing configuration files or handling dependency conflicts. Pay close attention to these prompts to avoid issues.

---

### **5. Troubleshooting During an Upgrade**

- **Interrupted Upgrade**: If the upgrade is interrupted, you can attempt to resume the process by running:
```bash
sudo dpkg --configure -a
sudo apt --fix-broken install
```

- **Package Conflicts**: During the upgrade, you may encounter packages that conflict with others. You can often resolve these by manually removing problematic packages:
```bash
sudo apt remove <package-name>
```

- **PPA Errors**: If you forget to disable a PPA and run into issues, you can remove the PPA manually:
```bash
sudo rm /etc/apt/sources.list.d/<ppa-name>.list
sudo apt update
```

---

### **Conclusion**
Upgrading Ubuntu from 18.04 to 22.04 is an important step to keep your system secure and up to date. The process involves using the `do-release-upgrade` command, while `dist-upgrade` is used to manage more complex package upgrades within the same release. PPAs can enhance your software options, but they need to be managed carefully during the upgrade process to avoid compatibility issues. Always backup your system before starting a major upgrade.
