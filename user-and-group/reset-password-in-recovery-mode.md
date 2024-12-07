**How to Reset Your Password Using Recovery Mode in Ubuntu**  

If you've forgotten your password, Ubuntu's recovery mode allows you to reset it. Follow these steps carefully:  

### Step 1: Access the GRUB Menu  
1. Restart your system.  
2. While the system boots, press and hold the **Shift** key (or **Esc** on some systems) to bring up the GRUB menu.  

### Step 2: Edit the Boot Parameters  
1. Use the arrow keys to highlight the Ubuntu entry but **do not press Enter** yet.  
2. Press the **e** key to edit the boot parameters.  

### Step 3: Modify the Boot Command  
1. Find the line that begins with `linux` and ends with `quiet splash`.  
2. Replace `quiet splash` with the following:  
   ```
   init=/bin/bash
   ```  

### Step 4: Boot into a Root Shell  
1. Press **Ctrl + X** or **F10** to boot with the modified parameters.  
2. The system will boot into a root shell without requiring a password.  

### Step 5: Remount the Filesystem with Write Permissions  
Run the following command to remount the root filesystem with write permissions:  
```
mount -o remount,rw /
```  

### Step 6: Reset Your Password  
1. Use the `passwd` command to reset the password for your user account. Replace `username` with your actual username:  
   ```
   passwd username
   ```  
2. Enter the new password when prompted, then press **Enter** to confirm.  

### Step 7: Reboot the System  
After resetting the password, reboot your system by typing:  
```
reboot
```  

### Step 8: Log In  
Once the system restarts, log in with your new password.  

> **Important:** Be cautious when using recovery mode or root access, as improper changes can affect your system's stability.
