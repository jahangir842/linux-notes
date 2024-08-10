To set or change the hostname in a Linux system, you can follow these steps. The process might vary slightly depending on the distribution, but these steps should generally apply.

### 1. **View Current Hostname**
   To view the current hostname:
   ```bash
   hostnamectl
   ```

### 2. **Set the Hostname Temporarily**
   To set the hostname temporarily (until the next reboot):
   ```bash
   sudo hostnamectl set-hostname new-hostname
   ```

   Replace `new-hostname` with your desired hostname.

### 3. **Set the Hostname Permanently**

   #### For **Rocky Linux** and **RHEL-based** Systems:
   - Edit the `/etc/hostname` file:
     ```bash
     sudo nano /etc/hostname
     ```
     Replace the current hostname with your new hostname.

   - Edit the `/etc/hosts` file:
     ```bash
     sudo nano /etc/hosts
     ```
     Update the line that associates `127.0.0.1` with your old hostname to use the new hostname. It will look something like:
     ```
     127.0.0.1   localhost new-hostname
     ```

   - Apply the changes:
     ```bash
     sudo hostnamectl set-hostname new-hostname
     ```

   #### For **Debian-based** Systems (like Ubuntu):
   - Edit the `/etc/hostname` file:
     ```bash
     sudo nano /etc/hostname
     ```
     Replace the current hostname with your new hostname.

   - Edit the `/etc/hosts` file:
     ```bash
     sudo nano /etc/hosts
     ```
     Update the line that associates `127.0.0.1` with your old hostname to use the new hostname:
     ```
     127.0.0.1   localhost new-hostname
     ```

   - To apply the changes, you can either reboot the system:
     ```bash
     sudo reboot
     ```

     Or restart the `hostname` service (less common, as it may not be supported in all distributions):
     ```bash
     sudo systemctl restart systemd-hostnamed
     ```

### 4. **Verify the Hostname**
   After setting the hostname, verify it by running:
   ```bash
   hostnamectl
   ```

By following these steps, you can set or change the hostname on your Linux system.
