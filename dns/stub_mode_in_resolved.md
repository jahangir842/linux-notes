### **What is Stub Mode in systemd-resolved?**
When `systemd-resolved` runs in **stub mode**, it means that the **DNS resolution is handled locally** by systemd-resolved’s **stub listener**, which listens on `127.0.0.53`. All DNS queries are **intercepted locally** and forwarded to an upstream DNS server.

---

### **How Does Stub Mode Work?**
1. Your `/etc/resolv.conf` file contains:
   ```
   nameserver 127.0.0.53
   ```
   This means all DNS queries from applications go to `127.0.0.53`.

2. **systemd-resolved** receives these queries and checks:
   - If a DNS server is manually configured for a specific interface (e.g., `resolvectl dns enp0s31f6 8.8.8.8`).
   - If there is a DHCP-provided or manually set global DNS server.

3. The query is then **forwarded to an external DNS server** (like `8.8.8.8` or `192.168.1.1` in your case).

4. The external DNS server responds, and systemd-resolved **returns the answer to your applications**.

---

### **How to Check If Stub Mode is Enabled**
Run:
```bash
resolvectl status
```
If you see:
```
resolv.conf mode: stub
nameserver 127.0.0.53
```
then stub mode is active.

---

### **Pros and Cons of Stub Mode**
#### ✅ **Advantages**
- Centralized DNS management via `systemd-resolved`.
- Per-interface DNS settings.
- Caching for faster lookups.

#### ❌ **Disadvantages**
- Some applications might not work well with `127.0.0.53`.
- You don’t have full manual control over `/etc/resolv.conf`.

---

### **How to Disable Stub Mode and Use a Custom DNS**
If you want **direct DNS resolution** without using `127.0.0.53`, follow these steps:

1. **Disable systemd-resolved:**
   ```bash
   sudo systemctl stop systemd-resolved
   sudo systemctl disable systemd-resolved
   ```

2. **Remove the existing resolv.conf:**
   ```bash
   sudo rm -f /etc/resolv.conf
   ```

3. **Create a new `/etc/resolv.conf` with your preferred DNS:**
   ```bash
   echo -e "nameserver 8.8.8.8\nnameserver 1.1.1.1" | sudo tee /etc/resolv.conf
   ```

4. **Lock the file to prevent automatic changes:**
   ```bash
   sudo chattr +i /etc/resolv.conf
   ```

Now, your system will directly use Google (`8.8.8.8`) and Cloudflare (`1.1.1.1`) DNS without systemd-resolved.

---

Let me know if you need more details! 🚀
