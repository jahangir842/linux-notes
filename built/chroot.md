Changing the root directory using `chroot` in Linux involves setting up an isolated environment where a process (and its children) operates with a new root directory, restricting its filesystem access to that subtree. This is commonly used for system recovery, testing, or running software in a sandboxed environment. Below are detailed notes on how to change the root using `chroot`, including prerequisites, steps, and practical examples.

---

# **Notes on Changing Root (chroot) in Linux**

The `chroot` command (short for "change root") modifies the apparent root directory (`/`) for a process, confining it to a specific directory tree. This creates a lightweight isolation mechanism without the overhead of full virtualization.

---

## **1. What is `chroot`?**
- **Definition**: A system call and command that changes the root directory of a process to a specified path, restricting its filesystem access.
- **Purpose**:
  - Test software in isolated environments.
  - Perform system repairs (e.g., fix a broken bootloader).
  - Run legacy or incompatible applications.
- **Key Concept**: The process sees the new directory as `/`, but the real filesystem remains unchanged outside the chroot.

---

## **2. Prerequisites**
To successfully `chroot`, you need:
1. **Root Privileges**: `chroot` requires superuser access (`sudo` or root).
2. **Target Directory**: A directory with a minimal filesystem structure (e.g., `/bin`, `/lib`, `/etc`).
3. **Essential Binaries**: Commands like `bash`, `ls`, or tools you plan to run inside the chroot.
4. **Libraries**: Shared libraries required by the binaries (find them with `ldd`).
5. **Mounted Filesystems**: Access to `/dev`, `/proc`, `/sys`, and `/tmp` (optional, depending on use case).

---

## **3. Basic Syntax**
```bash
chroot [NEW_ROOT] [COMMAND]
```
- **`NEW_ROOT`**: The directory to set as the new root.
- **`COMMAND`**: Optional command to run inside the chroot (defaults to `/bin/sh` if omitted).

---

## **4. Steps to Change Root with `chroot`**

### **Step 1: Prepare the Target Directory**
- Ensure the target directory has the necessary files. For a basic chroot:
  - Copy a shell: `cp /bin/bash /path/to/newroot/bin/`.
  - Copy libraries: Use `ldd /bin/bash` to list dependencies, then copy them (e.g., `cp /lib64/ld-linux-x86-64.so.2 /path/to/newroot/lib64/`).
- Example:
  ```bash
  mkdir -p /mnt/chroot/{bin,lib,lib64}
  cp /bin/bash /mnt/chroot/bin/
  ldd /bin/bash | grep -o '/lib.*\s' | xargs -I {} cp {} /mnt/chroot/lib64/
  ```

### **Step 2: Mount Required Filesystems**
- For a functional chroot, mount virtual filesystems:
  ```bash
  sudo mount --bind /dev /mnt/chroot/dev
  sudo mount --bind /proc /mnt/chroot/proc
  sudo mount --bind /sys /mnt/chroot/sys
  sudo mount --bind /tmp /mnt/chroot/tmp
  ```
- **Why**: These provide device nodes (`/dev`), process info (`/proc`), system info (`/sys`), and temporary storage (`/tmp`).

### **Step 3: Enter the Chroot**
- Run `chroot` to switch the root:
  ```bash
  sudo chroot /mnt/chroot
  ```
- **Result**: You’re now in a shell where `/mnt/chroot` is `/`.

### **Step 4: Run a Command (Optional)**
- Specify a command directly:
  ```bash
  sudo chroot /mnt/chroot /bin/bash
  ```

### **Step 5: Exit the Chroot**
- Type `exit` or press `Ctrl+D` to return to the original environment.

### **Step 6: Clean Up**
- Unmount filesystems:
  ```bash
  sudo umount /mnt/chroot/{dev,proc,sys,tmp}
  ```

---

## **5. Practical Examples**

### **a) Basic Chroot Setup**
- Create a minimal chroot environment:
  ```bash
  mkdir -p /chroot-test/{bin,lib64}
  cp /bin/bash /chroot-test/bin/
  ldd /bin/bash | grep -o '/lib.*\s' | xargs -I {} cp {} /chroot-test/lib64/
  sudo chroot /chroot-test
  ```
- Inside, run `ls` (fails because it’s not copied) or `bash` commands.

### **b) System Rescue (Fix a Broken System)**
- Boot from a live USB, mount the root filesystem, and chroot:
  ```bash
  sudo mount /dev/sda1 /mnt  # Mount root partition
  sudo mount --bind /dev /mnt/dev
  sudo mount --bind /proc /mnt/proc
  sudo mount --bind /sys /mnt/sys
  sudo chroot /mnt
  ```
- Inside, fix issues (e.g., `grub-install`, `passwd`).

### **c) Test a Different Distro’s Environment**
- Extract a distro tarball (e.g., Ubuntu base) to `/mnt/ubuntu`:
  ```bash
  sudo tar -xvf ubuntu-base.tar.gz -C /mnt/ubuntu
  sudo mount --bind /dev /mnt/ubuntu/dev
  sudo mount --bind /proc /mnt/ubuntu/proc
  sudo mount --bind /sys /mnt/ubuntu/sys
  sudo chroot /mnt/ubuntu
  ```
- Run commands as if you’re in Ubuntu.

---

## **6. Advanced Usage**

### **a) Copy Resolver Configuration**
- For network commands (e.g., `apt`, `ping`):
  ```bash
  sudo cp /etc/resolv.conf /mnt/chroot/etc/
  ```

### **b) Bind Mount Additional Directories**
- For access to more tools:
  ```bash
  sudo mount --bind /usr /mnt/chroot/usr
  ```

### **c) Chroot with a Script**
- Automate setup:
  ```bash
  #!/bin/bash
  CHROOT_DIR="/mnt/chroot"
  mkdir -p "$CHROOT_DIR"/{bin,lib64,dev,proc,sys}
  cp /bin/bash "$CHROOT_DIR/bin/"
  ldd /bin/bash | grep -o '/lib.*\s' | xargs -I {} cp {} "$CHROOT_DIR/lib64/"
  mount --bind /dev "$CHROOT_DIR/dev"
  mount --bind /proc "$CHROOT_DIR/proc"
  mount --bind /sys "$CHROOT_DIR/sys"
  chroot "$CHROOT_DIR"
  ```

---

## **7. Troubleshooting**

### **a) "command not found"**
- **Cause**: Missing binary or libraries.
- **Fix**: Copy the command (e.g., `cp /bin/ls /mnt/chroot/bin/`) and its libraries (use `ldd`).

### **b) "chroot: failed to run command"**
- **Cause**: No shell or invalid path.
- **Fix**: Ensure `/bin/bash` (or another shell) exists in the chroot.

### **c) Permission Denied**
- **Cause**: Insufficient privileges.
- **Fix**: Use `sudo` or run as root.

---

## **8. Best Practices**
- **Minimal Setup**: Only copy what’s needed to keep the chroot lightweight.
- **Unmount Cleanup**: Always unmount virtual filesystems to avoid system issues.
- **Test First**: Use a non-critical directory to practice.
- **Documentation**: Note mounted paths for easy reversal.

---

## **9. Limitations**
- **Not Full Isolation**: Shares the kernel and network stack with the host (unlike containers).
- **Manual Setup**: Requires copying binaries and libraries.
- **Root Requirement**: Can’t be run by unprivileged users without additional tools (e.g., `schroot`).

---

## **10. Comparison with Alternatives**
| **Tool**    | **Pros**                  | **Cons**                  |
|-------------|---------------------------|---------------------------|
| **chroot**  | Lightweight, built-in     | Manual setup, no isolation|
| **Docker**  | Full isolation, easy      | Heavier, complex          |
| **schroot** | User-friendly chroot      | Extra installation        |

---

## **11. Summary**
- **`chroot`** changes the root directory for a process, isolating its filesystem view.
- Requires a prepared directory with binaries, libraries, and mounted filesystems.
- Useful for recovery, testing, or sandboxing.
- Simple but powerful when combined with proper setup.

---

## **Try It Yourself**
1. Create a chroot:
   ```bash
   mkdir -p /tmp/myroot/{bin,lib64}
   cp /bin/bash /tmp/myroot/bin/
   ldd /bin/bash | grep -o '/lib.*\s' | xargs -I {} cp {} /tmp/myroot/lib64/
   sudo chroot /tmp/myroot
   ```
2. Inside, run `whoami` (works) or `ls` (fails unless copied).
3. Exit with `Ctrl+D`.

Let me know if you need help with a specific chroot scenario! 🚀
