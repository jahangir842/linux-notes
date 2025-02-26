It seems like you’re asking about **`systemd-resolved`** in Linux, given the context of your previous question about `/etc/resolv.conf` and DNS. I’ll assume you meant "resolved" as shorthand for `systemd-resolved`, a component of the `systemd` suite that handles DNS resolution. Below are detailed notes explaining what `systemd-resolved` is, its purpose, how it works, and its role in Linux networking.

---

# **Notes on systemd-resolved in Linux**

**`systemd-resolved`** is a system service in Linux, part of the `systemd` ecosystem, that provides DNS name resolution (and related features) to local applications. It acts as a local DNS resolver, caching DNS queries and managing name resolution settings dynamically. It’s designed to replace or complement traditional static `/etc/resolv.conf` configurations in modern Linux distributions.

---

## **1. What is systemd-resolved?**
- **Definition**: A daemon (`systemd-resolved.service`) that handles DNS resolution, LLMNR (Link-Local Multicast Name Resolution), and mDNS (Multicast DNS) for the system.
- **Purpose**: 
  - Resolves domain names to IP addresses (and vice versa).
  - Caches DNS responses to improve performance.
  - Supports advanced features like DNSSEC (DNS Security Extensions) and per-interface DNS settings.
- **Introduced**: Part of `systemd` since version 216 (2014), widely adopted in distros like Ubuntu (16.04+), Fedora, and Debian.

---

## **2. Key Features**
- **DNS Resolver**: Acts as a local DNS stub resolver, forwarding queries to upstream DNS servers.
- **Caching**: Stores DNS responses to reduce lookup times and network load.
- **DNSSEC**: Validates DNS responses for security (if enabled).
- **Multicast DNS (mDNS)**: Resolves local `.local` names (e.g., `printer.local`).
- **Link-Local Multicast Name Resolution (LLMNR)**: Resolves names on local networks without a DNS server.
- **Per-Interface DNS**: Allows different DNS servers for different network interfaces (e.g., Wi-Fi vs. Ethernet).
- **Integration**: Works with `NetworkManager` and other network tools to dynamically update DNS settings.

---

## **3. How It Works**
1. **Stub Resolver**:
   - Listens on `127.0.0.53:53` (a loopback address) as a local DNS server.
   - Applications query this address instead of directly contacting external DNS servers.

2. **Dynamic Configuration**:
   - Receives DNS server info from network services (e.g., DHCP, `NetworkManager`).
   - Updates its internal configuration and exposes it via `/run/systemd/resolve/stub-resolv.conf`.

3. **Query Processing**:
   - Caches responses locally.
   - Forwards unresolved queries to upstream DNS servers (e.g., `8.8.8.8`).
   - Validates DNSSEC if enabled.

4. **Fallback**:
   - Maintains a fallback DNS server list if no network-specific servers are provided.

---

## **4. Configuration Files**
- **Main Config**: `/etc/systemd/resolved.conf`
  - Controls global settings like default DNS servers and DNSSEC.
  - Example:
    ```
    [Resolve]
    DNS=8.8.8.8 8.8.4.4
    Domains=~lab.local
    DNSSEC=allow-downgrade
    Cache=yes
    ```
- **Drop-in Files**: `/etc/systemd/resolved.conf.d/*.conf` for custom overrides.
- **Runtime Config**: `/run/systemd/resolve/resolv.conf` (internal, not for direct editing).
- **Stub File**: `/run/systemd/resolve/stub-resolv.conf` (exposed for applications).

---

## **5. Interaction with /etc/resolv.conf**
- **Default Behavior**: On systems using `systemd-resolved`, `/etc/resolv.conf` is often a symlink to `/run/systemd/resolve/stub-resolv.conf`:
  ```bash
  ls -l /etc/resolv.conf
  # Output: lrwxrwxrwx 1 root root 39 Feb 25 12:34 /etc/resolv.conf -> /run/systemd/resolve/stub-resolv.conf
  ```
- **Content**: Typically points to the stub resolver:
  ```
  nameserver 127.0.0.53
  options edns0 trust-ad
  ```
- **Why**: Applications query `127.0.0.53`, and `systemd-resolved` handles the rest.

---

## **6. Checking Status**
- **Service Status**:
  ```bash
  systemctl status systemd-resolved
  ```
- **Active DNS Servers**:
  ```bash
  resolvectl status
  ```
  - Shows per-interface DNS servers, domains, and protocols (e.g., DNSSEC).

---

## **7. Common Commands**

### **a) Query a Domain**
```bash
resolvectl query google.com
```
- **Output**: IP addresses (e.g., `142.250.190.14`).

### **b) Set DNS Servers**
- Temporarily set DNS for an interface (e.g., `eth0`):
  ```bash
  sudo resolvectl set-dns eth0 8.8.8.8 8.8.4.4
  ```

### **c) Flush Cache**
```bash
sudo resolvectl flush-caches
```

### **d) Enable DNSSEC**
```bash
sudo resolvectl dnssec eth0 allow-downgrade
```

### **e) Reset to Defaults**
```bash
sudo resolvectl reset-server eth0
```

---

## **8. Practical Use Cases**

### **a) Improve DNS Performance**
- Enable caching to reduce lookup times:
  ```bash
  sudo nano /etc/systemd/resolved.conf
  # Add: Cache=yes
  sudo systemctl restart systemd-resolved
  ```

### **b) Custom DNS for Lab**
- Set specific DNS servers:
  ```bash
  sudo resolvectl set-dns eth0 192.168.1.1
  sudo resolvectl set-domain eth0 ~lab.local
  ```

### **c) Debug DNS Issues**
- Check logs:
  ```bash
  journalctl -u systemd-resolved
  ```

---

## **9. Enabling/Disabling systemd-resolved**

### **Enable**
- If disabled or not default:
  ```bash
  sudo systemctl enable --now systemd-resolved
  sudo ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
  ```

### **Disable**
- To use traditional `/etc/resolv.conf`:
  ```bash
  sudo systemctl disable --now systemd-resolved
  sudo rm /etc/resolv.conf  # Remove symlink
  echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf
  ```

---

## **10. Troubleshooting**

### **a) DNS Not Resolving**
- **Check**: Is `systemd-resolved` running?
  ```bash
  systemctl is-active systemd-resolved
  ```
- **Fix**: Start it or verify `/etc/resolv.conf` points to `127.0.0.53`.

### **b) Wrong DNS Servers**
- **Check**: `resolvectl status`.
- **Fix**: Set correct servers with `resolvectl set-dns`.

### **c) Conflicts with Other DNS Tools**
- **Symptom**: BIND or dnsmasq fails on port 53.
- **Fix**: Disable `systemd-resolved` (it binds to `127.0.0.53:53`).

---

## **11. Pros and Cons**

### **Pros**
- Integrated with `systemd`, widely supported.
- Caches DNS for performance.
- Supports DNSSEC, mDNS, and LLMNR.
- Dynamic DNS updates via `NetworkManager`.

### **Cons**
- Adds complexity compared to static `/etc/resolv.conf`.
- May conflict with other DNS servers (e.g., BIND).
- Stub resolver requires apps to support it.

---

## **12. Comparison with Traditional resolv.conf**
| **Aspect**            | **systemd-resolved**          | **/etc/resolv.conf**       |
|-----------------------|-------------------------------|----------------------------|
| **Management**        | Dynamic (NetworkManager)     | Static (manual edits)      |
| **Caching**           | Yes                          | No                         |
| **DNSSEC**            | Yes                          | No (app-dependent)         |
| **Per-Interface DNS** | Yes                          | No (global only)           |
| **Complexity**        | Moderate                     | Low                        |

---

## **13. Summary**
- **`systemd-resolved`** is a modern DNS resolver in `systemd`, handling name resolution, caching, and security features.
- Runs a stub resolver at `127.0.0.53`, integrating with `/etc/resolv.conf`.
- Ideal for dynamic environments, less so if running a full DNS server (e.g., BIND).
- Controlled via `resolvectl` and configured in `/etc/systemd/resolved.conf`.

---

## **Try It Yourself**
1. Check if it’s running:
   ```bash
   systemctl status systemd-resolved
   ```
2. Query a name:
   ```bash
   resolvectl query example.com
   ```
3. Set a custom DNS:
   ```bash
   sudo resolvectl set-dns eth0 1.1.1.1
   resolvectl status
   ```

Let me know if you meant something different by "resolved" or need help with a specific setup! 🚀
