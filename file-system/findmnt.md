### **`findmnt` Command in Linux**  

The `findmnt` command is used to display information about mounted file systems in a structured and readable format. It is part of the `util-linux` package and provides a powerful way to inspect and analyze mounted filesystems.

---

## **Basic Usage**

1. **Show all mounted filesystems**  
   ```
   findmnt
   ```
   This displays a tree view of all mounted file systems.

2. **Show a specific mount point**  
   ```
   findmnt /home
   ```
   Displays details about the `/home` mount point.

3. **Find a filesystem by device**  
   ```
   findmnt /dev/sda1
   ```
   Shows where `/dev/sda1` is mounted.

---

## **Common Options**

| Option               | Description |
|----------------------|-------------|
| `-t <type>`         | Show only specific filesystem types (e.g., `ext4`, `xfs`). Example: `findmnt -t ext4` |
| `-n`                | Suppress the header, useful for scripting. |
| `-o <fields>`       | Customize output fields (e.g., `findmnt -o TARGET,FSTYPE,SIZE`). |
| `-S <source>`       | Find a mount by source (e.g., `findmnt -S /dev/sda1`). |
| `-T <target>`       | Find a mount by target (mount point). |
| `-l`                | Show output in list format instead of tree format. |
| `-D`                | Show only dummy (virtual) filesystems like `tmpfs`. |
| `-r`                | Display only real mount points (exclude pseudo, duplicate, or network filesystems). |
| `-M <mountpoint>`   | Find the filesystem for a specific mount point. |

---

## **Examples**

1. **List all filesystems in a simple list format**  
   ```
   findmnt -l
   ```
   
2. **Display only `ext4` and `xfs` filesystems**  
   ```
   findmnt -t ext4,xfs
   ```

3. **Find where a specific device is mounted**  
   ```
   findmnt -S /dev/nvme0n1p1
   ```

4. **Display details of a mount point in JSON format**  
   ```
   findmnt -J /mnt
   ```

5. **Check the mount point of the root filesystem (`/`)**  
   ```
   findmnt /
   ```

---

## **Useful for System Administrators**
- **Checking mount points and file systems**  
- **Verifying removable drives (`/dev/sdX` or `/dev/nvmeX`)**  
- **Scripting and automation in Linux system administration**  
- **Debugging mount-related issues**  

Would you like specific details on a particular use case? 🚀
