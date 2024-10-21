### Gaining Superuser Access

#### Objectives:
- Learn to switch to the superuser account to manage a Linux system.
- Grant superuser access to other users via the `sudo` command.

---

### The Superuser
- **Root User**: In Red Hat Enterprise Linux (RHEL), the **root** user is the superuser with all system privileges, including managing system files, directories, and software.
  - Can override normal permissions on the file system.
  - Only the root user can control "fixed" devices like hard drives (except for removable devices like USB drives which are accessible by normal users).

- **Responsibility of the Superuser**: With great power comes great responsibility.
  - **Risk**: Root can remove critical files, delete user accounts, and create security backdoors. Compromising the root account means losing control of the system.
  - Best practice: **Log in as a normal user** and escalate privileges only when needed.

- **Root vs. Windows Administrator**: 
  - In Linux, administrators generally work as an unprivileged user and use tools like `su` or `sudo` for temporary root access.
  - Directly logging in as root is not recommended due to security risks, such as system-wide compromise from potential vulnerabilities.

#### Warning:
- Avoid logging in as root for routine tasks; use methods like `su`, `sudo`, or PolicyKit to **temporarily** gain superuser privileges.
  - Logging in directly as root elevates the entire session's privilege level, potentially exposing the system to more risks.

---

### Switching Users with `su`
- **`su` Command**: Allows switching between user accounts. When switching to a user, you'll be prompted for that user's password (except when root switches users).
  
- **Basic Usage**:
  ```bash
  su - user02  # Switch to user02
  su -         # Switch to root (if username is omitted, defaults to root)
  ```

- **Login Shell vs. Non-Login Shell**:
  - `su` starts a **non-login shell** (retains the current environment).
  - `su -` (with dash `-`) starts a **login shell**, resetting the environment to that of the target user.

- **Example**:
  ```bash
  [user01@host ~]$ su - user02
  Password:
  [user02@host ~]$
  ```

- **Running Programs with `su -c`**: The `-c` option allows running a specific command as another user without starting an interactive shell.
  ```bash
  su -c 'command_to_run'  # Similar to Windows 'runas'
  ```

---

### Running Commands with `sudo`
- **`sudo` Command**: Allows users to run commands as another user (typically root), **without needing the root password**.
  - Users authenticate with **their own password**.
  - Configurable to restrict users to run only specific commands as root or other users.

- **Basic Usage**:
  ```bash
  sudo <command>  # Run command as root
  sudo -u <user> <command>  # Run command as specified user
  ```

- **Logging**:
  - Commands executed with `sudo` are logged by default to `/var/log/secure`, allowing admins to track user activities.
  ```bash
  sudo tail /var/log/secure  # View recent sudo logs
  ```

- **Example**:
  ```bash
  [user01@host ~]$ sudo usermod -L user02
  [sudo] password for user01:
  ```

#### Benefits of `sudo`:
- Commands are logged, providing an audit trail.
- Reduces the risk of exposing the root password.
- Users only need their own password to gain root privileges temporarily.
- If a user attempts a restricted command, it will be blocked and logged.

---

### Sudo and the Wheel Group
- In **RHEL 7 and RHEL 8**, members of the `wheel` group can run commands as root using `sudo`, provided they authenticate with their own password.
  
  - This is a **change from RHEL 6**, where `wheel` group members did not have administrative privileges by default.
  
  - **Warning**: If the wheel group was used for non-administrative purposes in older systems, this change could unintentionally grant unauthorized users administrative access.

#### Example:
```bash
[user02@host ~]$ sudo tail /var/log/secure
[sudo] password for user02:
user02 is not in the sudoers file. This incident will be reported.
```

---

### Summary
- **su**: Switch users or gain root access (if root’s password is known).
- **sudo**: Run commands as root or another user, typically without needing the target user’s password.
  - **Log security**: Sudo usage is logged for auditing purposes.
  - **Wheel group**: Users in the wheel group have sudo access in RHEL 7/8.

