To enable a service in `firewalld`, you can use the `firewall-cmd` command. Here’s how to do it:

### 1. **Check Firewalld Status**
   First, make sure that `firewalld` is running:
   ```bash
   sudo systemctl status firewalld
   ```

   If it’s not running, start it:
   ```bash
   sudo systemctl start firewalld
   ```

   Enable it to start on boot:
   ```bash
   sudo systemctl enable firewalld
   ```

### 2. **List Available Services**
   To see which services are available and can be enabled, you can list them:
   ```bash
   sudo firewall-cmd --list-services
   ```

   This command will show you a list of services currently allowed in the default zone.

### 3. **Enable a Service**
   To enable a specific service (e.g., `http` for HTTP traffic), use the following command:
   ```bash
   sudo firewall-cmd --zone=public --add-service=http --permanent
   ```

   - `--zone=public`: Specifies the zone where the service should be added. You can replace `public` with your zone if it’s different.
   - `--add-service=http`: Adds the `http` service to the allowed list.
   - `--permanent`: Makes the change persistent across reboots.

   **Note**: If you don’t use the `--permanent` flag, the change will only be applied until the next reload or restart of `firewalld`.

### 4. **Reload Firewalld**
   To apply the changes made with the `--permanent` flag, you need to reload `firewalld`:
   ```bash
   sudo firewall-cmd --reload
   ```

### 5. **Verify the Service is Enabled**
   Check that the service is now allowed:
   ```bash
   sudo firewall-cmd --list-all
   ```

   This will display all the services, ports, and rules currently configured for the default zone.

By following these steps, you can enable and manage services through `firewalld` on your Rocky Linux system.
