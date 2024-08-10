To remove VMware Workstation 17.5.2 from your Linux system, follow these steps:

### **Step 1: Locate the Uninstaller**
- VMware provides an uninstaller script that comes with the installation. First, locate this script. It should be in the following directory:
  ```bash
  /usr/bin/vmware-installer
  ```

### **Step 2: Uninstall VMware Workstation**
- To remove VMware Workstation, run the uninstaller with superuser privileges:
  ```bash
  sudo /usr/bin/vmware-installer --uninstall-product vmware-workstation
  ```
  - If you installed other VMware products, you can list them by running:
    ```bash
    sudo /usr/bin/vmware-installer --list-products
    ```
  - To uninstall a specific product, use its ID with the `--uninstall-product` option.

### **Step 3: Remove Configuration Files (Optional)**
- If you want to completely remove VMware Workstation, including configuration files and saved virtual machines, you can delete these directories:
  ```bash
  sudo rm -rf /etc/vmware
  sudo rm -rf ~/.vmware
  sudo rm -rf /var/lib/vmware
  ```

### **Step 4: Remove Kernel Modules (Optional)**
- VMware installs kernel modules that you might want to remove. First, list the modules:
  ```bash
  lsmod | grep vmw
  ```
- To remove them, use:
  ```bash
  sudo rmmod vmmon vmnet
  ```

### **Step 5: Clean Up (Optional)**
- Remove any leftover files or logs:
  ```bash
  sudo rm -rf /usr/lib/vmware
  sudo rm -rf /usr/lib/vmware-installer
  sudo rm -rf /var/log/vmware
  ```

### **Step 6: Verify Removal**
- Ensure that VMware Workstation is no longer installed by trying to run:
  ```bash
  vmware
  ```
  - If VMware is uninstalled correctly, the command should not be found.

By following these steps, VMware Workstation 17.5.2 should be fully removed from your Linux system.
