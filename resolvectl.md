### Detailed Notes on the `resolvectl` Command

The `resolvectl` command is part of the `systemd-resolved` service in systemd-based Linux distributions, such as Ubuntu. It replaces the older `systemd-resolve` command and provides a comprehensive interface for resolving DNS queries, managing the DNS cache, and configuring DNS settings on the system.

#### **1. Overview**
`resolvectl` is used to query and configure DNS settings, view the system's current DNS settings, and flush the DNS cache. It is a versatile tool that integrates tightly with the systemd suite, offering fine-grained control over the DNS resolution process.

#### **2. Basic Usage**
The general syntax of the `resolvectl` command is as follows:

```bash
resolvectl [OPTIONS...] COMMAND [ARGUMENTS...]
```

#### **3. Common Commands and Their Usage**

##### **3.1. Querying DNS Information**
- **Resolve a Domain Name**
  To resolve a domain name and get the associated IP addresses, use:
  
  ```bash
  resolvectl query example.com
  ```

  This command will return all the IP addresses (both IPv4 and IPv6) associated with `example.com`.

- **Reverse DNS Lookup**
  To perform a reverse DNS lookup (resolving an IP address back to a domain name), use:
  
  ```bash
  resolvectl query 192.0.2.1
  ```

- **View DNS Information for a Specific Interface**
  You can query DNS information for a specific network interface:
  
  ```bash
  resolvectl status eth0
  ```

  This command shows detailed information about the DNS configuration of the `eth0` interface.

##### **3.2. Flushing the DNS Cache**
To clear the DNS cache, use the following command:

```bash
sudo resolvectl flush-caches
```

This command forces the system to discard any cached DNS information, ensuring that all subsequent DNS queries fetch fresh data from the DNS servers.

##### **3.3. Configuring DNS Servers**
You can set custom DNS servers for a specific interface:

```bash
sudo resolvectl dns eth0 8.8.8.8 8.8.4.4
```

This command sets Google's public DNS servers (`8.8.8.8` and `8.8.4.4`) for the `eth0` interface.

##### **3.4. Setting the Default DNS Domain**
You can define a default DNS search domain for an interface:

```bash
sudo resolvectl domain eth0 example.com
```

This command sets `example.com` as the default search domain for the `eth0` interface.

##### **3.5. Viewing the Current DNS Configuration**
To view the current DNS configuration for all interfaces, use:

```bash
resolvectl status
```

This command displays detailed DNS settings, including DNS servers, search domains, and more, for all active interfaces.

#### **4. Advanced Options**

##### **4.1. Viewing Link-specific DNS Configuration**
To see DNS configuration specific to a network link, use:

```bash
resolvectl status <interface>
```

Example:

```bash
resolvectl status eth0
```

##### **4.2. Viewing Global DNS Settings**
To view the global DNS settings applied to the system, use:

```bash
resolvectl dns
```

This command shows the DNS servers used for resolving queries that aren't interface-specific.

##### **4.3. Disabling DNS on a Specific Interface**
To disable DNS resolution on a specific interface, use:

```bash
sudo resolvectl dns eth0 ''
```

This command effectively disables DNS resolution via the `eth0` interface.

#### **5. Exit Codes**
`resolvectl` provides various exit codes based on the outcome of the command:
- **0**: Success
- **1**: Failure due to an invalid operation
- **2**: Network error
- **3**: DNS resolution failure

#### **6. Examples**

- **Example 1**: Query the IP addresses for `jahangir.blog`:

  ```bash
  resolvectl query jahangir.blog
  ```

- **Example 2**: Flush the DNS cache to ensure fresh DNS queries:

  ```bash
  sudo resolvectl flush-caches
  ```

- **Example 3**: Set custom DNS servers for the `wlp3s0` interface:

  ```bash
  sudo resolvectl dns wlp3s0 1.1.1.1 1.0.0.1
  ```

- **Example 4**: Display the DNS configuration for the `enp0s3` interface:

  ```bash
  resolvectl status enp0s3
  ```

#### **7. Troubleshooting**
- If `resolvectl` doesn't seem to work, ensure that `systemd-resolved` is running:
  
  ```bash
  sudo systemctl status systemd-resolved
  ```
  
  If it's not running, start it with:
  
  ```bash
  sudo systemctl start systemd-resolved
  ```

#### **8. Conclusion**
`resolvectl` is a powerful tool for managing DNS resolution on systemd-based systems. It offers flexibility in querying and configuring DNS settings, making it a valuable tool for system administrators and advanced users.
