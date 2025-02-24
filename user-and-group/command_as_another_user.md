In Linux, you can run a command as another user using the following methods:

### 1. **Using `sudo -u` (Run as a Non-Root User)**
If you have sudo privileges, you can execute a command as another user:
```bash
sudo -u username command
```
Example:
```bash
sudo -u johndoe whoami
```
Output:
```
johndoe
```

### 2. **Using `su -c` (Run a Command as Another User)**
You can use `su` with the `-c` option to execute a command as another user:
```bash
su - username -c "command"
```
Example:
```bash
su - johndoe -c "whoami"
```
This requires the password of `johndoe` unless you are already root.

### 3. **Using `sudo -i -u` (Start an Interactive Shell as Another User)**
To switch to another user interactively:
```bash
sudo -i -u username
```
Example:
```bash
sudo -i -u johndoe
```
This will open a new shell as `johndoe`.

### 4. **Using `runuser` (Alternative to `su`)**
On some systems, `runuser` can be used:
```bash
runuser -l username -c "command"
```
Example:
```bash
runuser -l johndoe -c "whoami"
```
This is mostly used in scripts and does not require a password if executed as root.

### 5. **Using `setpriv` (Modify User Privileges)**
If you have access to `setpriv`, you can run a command as another user:
```bash
setpriv --reuid=username --regid=username --clear-groups command
```
Example:
```bash
setpriv --reuid=johndoe --regid=johndoe --clear-groups whoami
```

---

## comparison:

| Method             | Requires Root Privileges | Requires Password | Runs Command | Runs Interactive Shell | Notes |
|--------------------|------------------------|-------------------|--------------|------------------------|-------|
| `sudo -u username command` | Yes (if not configured otherwise) | No (if configured in sudoers) | ✅ | ❌ | Most commonly used, follows `sudoers` rules. |
| `su - username -c "command"` | Yes | Yes (unless already root) | ✅ | ❌ | Runs command in a new login shell. |
| `sudo -i -u username` | Yes | No (if configured in sudoers) | ✅ | ✅ | Starts an interactive shell for the user. |
| `runuser -l username -c "command"` | Yes (must be root) | No | ✅ | ❌ | Used in scripts, doesn't prompt for a password. |
| `setpriv --reuid=username --regid=username --clear-groups command` | Yes | No | ✅ | ❌ | Less common, modifies process privileges directly. |

### **Key Differences:**
1. **`sudo -u`** is best for running a single command as another user without requiring their password.
2. **`su -c`** is useful but requires the target user's password unless run as root.
3. **`sudo -i -u`** is ideal for switching to an interactive shell of another user.
4. **`runuser`** is preferred in scripts because it doesn’t prompt for a password.
5. **`setpriv`** is a low-level option mostly used for privilege isolation in scripts.

### **Best Use Cases:**
- If you **just need to run a command once** as another user → Use `sudo -u username command`.
- If you **need an interactive shell** as another user → Use `sudo -i -u username`.
- If you **are scripting and need to avoid password prompts** → Use `runuser`.
- If you **want strict privilege control** without a shell → Use `setpriv`.

