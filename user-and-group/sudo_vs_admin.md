### **Difference Between `sudo` and `admin` Groups in Linux**  

#### **1. `sudo` Group**
- **Purpose:** Grants administrative privileges to users, allowing them to execute any command as `root` using `sudo`.  
- **Usage:** A user in the `sudo` group can run commands with elevated privileges by prefixing them with `sudo`, e.g.:  
  ```bash
  sudo apt update
  ```
- **Default in Modern Linux:**  
  - Since **Ubuntu 12.04 (Precise Pangolin)** and later, **Debian-based systems use the `sudo` group instead of `admin`**.  
  - When you create a user during Ubuntu installation, it is added to the `sudo` group automatically.  

#### **2. `admin` Group (Deprecated)**
- **Purpose:** Used in **older versions of Ubuntu (before 12.04)** to grant administrative privileges.  
- **Usage:** Users in the `admin` group could execute root-level commands using `sudo`, similar to the `sudo` group.  
- **Replaced by `sudo`:**  
  - From Ubuntu **12.04 onwards**, the `admin` group was **removed** in favor of the `sudo` group.  
  - The `admin` group no longer provides special privileges unless manually configured.  

---

### **Key Differences**
| Feature       | `sudo` Group | `admin` Group |
|--------------|-------------|--------------|
| **Purpose**  | Provides sudo access to users | Used for admin access before Ubuntu 12.04 |
| **Default in Ubuntu?** | ✅ Yes, since Ubuntu 12.04 | ❌ No, removed after Ubuntu 12.04 |
| **Usage** | Allows running `sudo` commands | Previously allowed sudo access (deprecated) |
| **Current Status** | Used in modern Linux distributions | No longer used by default |

---

### **How to Check If a User is in `sudo` Group**
```bash
groups <username>
```
Example output:
```bash
jahangir sudo docker
```
This means the user **"jahangir"** is part of the `sudo` and `docker` groups.

### **How to Add a User to the `sudo` Group**
```bash
sudo usermod -aG sudo <username>
```

### **How to Remove a User from the `sudo` Group**
```bash
sudo deluser <username> sudo
```

---
