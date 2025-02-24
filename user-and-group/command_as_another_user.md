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

Would you like an example for a specific use case?
