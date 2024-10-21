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

---

### Getting an Interactive Root Shell with Sudo:
- **`sudo su -`**: This command allows a non-administrative user with `sudo` permissions to gain an interactive root shell. Here, `sudo` runs `su -` as the root user, and root doesn’t need a password to switch to itself using `su -`. This effectively mimics a fresh root login.
- **`sudo -i`**: This also switches to the root account but runs the root user’s default shell, usually Bash, along with its login scripts. It sets the environment slightly differently from `sudo su -`, especially the `PATH` variable.
- **`sudo -s`**: If you only want to run a shell without switching the environment or executing login scripts, `sudo -s` provides a simpler way to achieve this.

#### Example Usage:
In an AWS EC2 instance:
```bash
[ec2-user@host ~]$ sudo -i
[root@host ~]#
```
This would give you an interactive root shell using `sudo -i`.

### Configuring Sudo:
- The `sudoers` configuration file is located at **`/etc/sudoers`** and should only be edited using the **`visudo`** command to avoid conflicts when multiple users are making changes.
- The following line grants `sudo` access to all members of the `wheel` group:
  ```bash
  %wheel ALL=(ALL) ALL
  ```
  - `%wheel`: Applies the rule to the `wheel` group.
  - `ALL=(ALL) ALL`: Members of `wheel` can run any command as any user.

#### Using the `/etc/sudoers.d` Directory:
This directory allows you to manage `sudo` access in a modular way. Files added here are included in the main `sudoers` file.

- To give user `user01` full `sudo` access, you could create a file `/etc/sudoers.d/user01` with this content:
  ```bash
  user01 ALL=(ALL) ALL
  ```
- Similarly, for the group `group01`, you can create `/etc/sudoers.d/group01` with:
  ```bash
  %group01 ALL=(ALL) ALL
  ```

#### NOPASSWD Option:
You can configure `sudo` to not require a password for specific users or groups:
- Example:
  ```bash
  ansible ALL=(ALL) NOPASSWD:ALL
  ```
  This is commonly used in automation scenarios where services like Ansible or cloud provisioning systems need root access without manual intervention.

### Subtle Differences Between `sudo su -` and `sudo -i`:
- **`sudo su -`** sets up a full root environment like a fresh login. The `su -` part discards the environment set by `sudo` and applies the root environment from scratch.
- **`sudo -i`**, on the other hand, carries over some of the environment from the non-root user (like a slightly different `PATH`). You can modify the `/etc/sudoers` file to make `sudo -i` behave more like `su -` by adjusting the `secure_path` configuration:
  ```bash
  Defaults secure_path = /usr/local/bin:/usr/bin
  Defaults>root secure_path = /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin
  ```

### Example Scenarios in Cloud Environments:
In cloud instances (like AWS EC2), accounts such as `ec2-user` often have `NOPASSWD` access configured, allowing them to run commands as root without entering a password. This is typically set in the `/etc/sudoers` file:
```bash
ec2-user ALL=(ALL) NOPASSWD: ALL
```
This setup is commonly used with SSH key authentication to ensure secure, passwordless root access during system provisioning.

By understanding these commands and configurations, you can effectively manage access control and root permissions on Linux systems, especially in automated and cloud-based environments.
