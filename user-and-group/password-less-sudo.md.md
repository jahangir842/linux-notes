To grant a user password-less `sudo` access on a Linux system, follow these steps:

### Step 1: Open the `sudoers` File
The `sudoers` file controls the sudo permissions for users. To edit it safely, use the `visudo` command:

```bash
sudo visudo
```


OR

```bash
sudo nano /etc/sudoers
```

This opens the `sudoers` file in a safe way that prevents syntax errors, which could otherwise lock you out of your system.

### Step 2: Grant Password-Less Access
Scroll to the bottom of the file (or find the user section) and add the following line to give password-less `sudo` privileges to a specific user:

```bash
username ALL=(ALL) NOPASSWD:ALL
```

- Replace `username` with the actual username of the user you want to grant password-less `sudo` access to.
- `ALL=(ALL)` means the user can run commands as any user or group.
- `NOPASSWD:ALL` means no password will be required for any `sudo` command.

### Example
If your username is `user1`, the line would look like this:

```bash
user1 ALL=(ALL) NOPASSWD:ALL
```

### Step 3: Save and Exit
After making the changes, save the file and exit:

- In `visudo`, press `Ctrl+X` to exit, then `Y` to confirm saving the changes, and press `Enter`.

### Step 4: Verify
To confirm the user has password-less sudo access, run a sudo command:

```bash
sudo ls /root
```

If it works without prompting for a password, the configuration is successful.

---

### Optional: Limit Commands

### 🔐 Granting Passwordless `sudo` Permissions for Specific Commands or Paths

To allow a user to run certain commands as root **without being prompted for a password**, use the `sudoers` configuration safely via:

```bash
sudo visudo
```

This ensures syntax validation before saving.

#### 🔧 Basic Syntax in `/etc/sudoers` or Drop-in Files (`/etc/sudoers.d/`)

```bash
username ALL=(ALL) NOPASSWD: /full/path/to/command
```

> ✅ `NOPASSWD:` disables the password prompt for listed commands.

---

### 🧪 Example 1: Allow `user1` to restart Nginx without a password

```bash
user1 ALL=(ALL) NOPASSWD: /bin/systemctl restart nginx
```

- This lets `user1` run:
  ```bash
  sudo /bin/systemctl restart nginx
  ```
  without entering their password.

---

### 🧪 Example 2: Allow `deploy` to copy files to `/opt/webapp` without password

```bash
deploy ALL=(ALL) NOPASSWD: /usr/bin/rsync, /bin/cp /home/deploy/* /opt/webapp/
```

- You can now allow:
  ```bash
  sudo /bin/cp /home/deploy/index.html /opt/webapp/
  ```
  without password prompts.

---

### 🧪 Example 3: Passwordless permission for entire directory actions

Let’s say you want to let `backupuser` read/write files under `/mnt/backups`:

1. Create a script:
   ```bash
   /usr/local/bin/backup_push.sh
   ```
   with:
   ```bash
   #!/bin/bash
   cp /home/backupuser/data.tar.gz /mnt/backups/
   ```
   2. Then allow passwordless execution:
   ```bash
   backupuser ALL=(ALL) NOPASSWD: /usr/local/bin/backup_push.sh
   ```

---

### ⚠️ Best Practices

- Always use **full path** to the command (use `which` to find it, e.g., `which systemctl`)
- Limit permissions to **specific commands** or **scripts** only.
- Avoid wildcards like `*` unless absolutely necessary.
- Use the `/etc/sudoers.d/username` file for better modularity:
  ```bash
  sudo visudo -f /etc/sudoers.d/deploy
  ```

---

Let me know if you want examples with `ansible.builtin.lineinfile` or `ansible.builtin.copy` to automate this configuration as well.
---

The `sudoers` file is located at:

```
/etc/sudoers
```

However, to safely edit it, always use the `visudo` command:

```bash
sudo visudo
```

This ensures that the file is checked for syntax errors before saving, preventing misconfigurations that could lock you out of your system.

You can also find individual configuration files in the `/etc/sudoers.d/` directory, which is often used to define specific sudo permissions for certain users or groups. You can create files in this directory for individual users without directly modifying the main `/etc/sudoers` file. 

For example, to create a file for a user named `user1`:

```bash
sudo visudo -f /etc/sudoers.d/user1
```

And then add the password-less configuration in that file:

```bash
user1 ALL=(ALL) NOPASSWD:ALL
```

