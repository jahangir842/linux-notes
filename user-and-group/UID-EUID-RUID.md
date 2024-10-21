### Understanding EUID, RUID, and UID in Linux

In Linux, **UID (User ID)**, **EUID (Effective User ID)**, and **RUID (Real User ID)** are essential concepts for managing user permissions and process ownership. These identifiers play a crucial role in determining what a user or a process can access and execute on the system.

#### 1. **UID (User ID)**
- **UID** is the unique numeric identifier assigned to each user on a Linux system.
- It is used by the operating system to identify users and assign ownership of files, processes, and system resources.
- UIDs are stored in the `/etc/passwd` file, which holds details of all system users.

##### Example:
```bash
cat /etc/passwd | grep username
```
Output:
```
username:x:1001:1001:User Name:/home/username:/bin/bash
```
Here, the `1001` is the UID of the user `username`.

##### Types of UIDs:
- **UID 0**: Represents the **root user** with the highest administrative privileges.
- **UID 1-99**: Reserved for system users and services.
- **UID 1000+**: Regular users created by the system administrator or by the system itself when a new user is added.

#### 2. **RUID (Real User ID)**
- **RUID** represents the **ID of the user** who started or initiated the process.
- It helps track ownership and accountability for the processes run by users.
- The **RUID** of a process does not change, even if the process temporarily acquires higher privileges.

##### Example Usage:
To list processes associated with a specific user’s **RUID**, use:
```bash
ps -u username
```
This command lists processes that were started by the user `username`, whose **RUID** matches their UID.

#### 3. **EUID (Effective User ID)**
- **EUID** controls what privileges the process has access to.
- It can be different from the **RUID** if the program being run has the **setuid** bit enabled, allowing it to be executed with the privileges of the file owner, rather than the user running the program.
- This concept allows for temporary privilege escalation without changing the **RUID**.

##### Example Usage:
To see how **EUID** works, consider the `passwd` command, which allows regular users to change their password but needs root privileges to modify the system files. The `passwd` binary has the **setuid** bit set, so when executed by a regular user, it runs with root's **EUID**.

```bash
ls -l /usr/bin/passwd
```
Output:
```
-rwsr-xr-x 1 root root 54232 Jan  1 12:34 /usr/bin/passwd
```
Here, the **`s`** in `rws` indicates that the **setuid** bit is set, meaning the `passwd` command will run with an **EUID** of root (`UID 0`), even if the user’s **RUID** is that of a regular user.

#### 4. **Checking if a Script is Run by Root (Using EUID)**

You can use **EUID** in scripts to determine if the script is being run with root privileges. This is useful when certain actions in the script require elevated permissions.

##### Example Script: Checking if the Script is Run by Root
```bash
#!/bin/bash

# Check if the effective user ID (EUID) is 0 (root)
if [ "$EUID" -eq 0 ]; then
    echo "You are running this script as root."
else
    echo "You are NOT running this script as root. Please run as root."
    exit 1
fi

# Root-specific actions can go here
echo "Performing root-level tasks..."

# Example of a privileged action
echo "Updating package list..."
apt update  # This will only succeed if the script is run by root
```

#### Explanation of the Script:
- **`$EUID`**: This variable holds the **Effective User ID** of the user running the script. If the **EUID** is `0`, the script is running with root privileges.
- **`exit 1`**: The script will exit if it detects the user is not root, indicating failure with a non-zero exit status.

##### Running the Script:
1. Save the script as `check_root.sh`.
2. Make it executable:
   ```bash
   chmod +x check_root.sh
   ```
3. Run it without root privileges:
   ```bash
   ./check_root.sh
   ```
   Output:
   ```
   You are NOT running this script as root. Please run as root.
   ```

4. Run it with root privileges using `sudo`:
   ```bash
   sudo ./check_root.sh
   ```
   Output:
   ```
   You are running this script as root.
   Performing root-level tasks...
   Updating package list...
   ```

#### 5. **Practical Example with setuid**
A process can have different **RUID** and **EUID** under certain circumstances. Consider the case of a user running a program with **setuid** enabled:

1. A regular user runs a setuid program:
   ```bash
   id
   ```
   Output (before running the program):
   ```
   uid=1001(john) gid=1001(john) groups=1001(john)
   ```

2. After running a setuid program (which changes **EUID** to root):
   ```bash
   ./setuid_program
   ```
   Output:
   ```
   uid=1001(john) euid=0(root) gid=1001(john) groups=1001(john)
   ```
   - Here, **RUID** remains `1001` (the real user `john`), but the **EUID** is now `0`, granting the process root-level permissions.

#### 6. **Switching Between UID and EUID in Programs**
In programming, system calls like `setuid()` and `seteuid()` allow a process to change its **UID** or **EUID**, enabling temporary escalation or de-escalation of privileges.

##### Example Program in C to Change EUID:
```c
#include <unistd.h>
#include <stdio.h>

int main() {
    printf("Before seteuid: EUID = %d\n", geteuid());
    seteuid(0);  // Change EUID to root
    printf("After seteuid: EUID = %d\n", geteuid());
    return 0;
}
```

#### 7. **Summary of Differences**
- **UID**: Identifies the user owning the process.
- **RUID**: The original ID of the user who initiated the process.
- **EUID**: The ID used by the system to determine the privileges for the process.

These concepts allow the system to manage privilege escalation and ensure proper access control in multi-user environments.

#### 8. **Useful Commands**
- **`id`**: Displays the current user’s UID, GID, and other identifiers.
    ```bash
    id
    ```
- **`ps -eo user,euid,ruid,comm`**: Lists running processes with their RUID and EUID.
    ```bash
    ps -eo user,euid,ruid,comm
    ```

---

This guide provides a detailed overview of **UID**, **EUID**, and **RUID** in Linux, explaining their role and practical usage for managing users and processes.
