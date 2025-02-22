# **`ss` Command in Linux**  

## **Introduction**  
The `ss` (Socket Statistics) command is a powerful tool for displaying detailed information about network sockets. It is a faster alternative to `netstat` and provides more granular information about active connections.  

---

## **Why Use `ss` Instead of `netstat`?**  
- Faster and more efficient (fetches data from kernel space instead of `/proc`).
- Displays more socket details.
- Supports filtering options for better analysis.
- Provides real-time statistics.

---

## **Basic Syntax**
```sh
ss [OPTIONS]
```

---

## **Commonly Used `ss` Options**
| Option | Description |
|---------|------------|
| `-t` | Show only TCP connections. |
| `-u` | Show only UDP connections. |
| `-l` | Show only listening sockets. |
| `-n` | Show numerical addresses (skip DNS resolution). |
| `-p` | Show processes using the sockets. |
| `-r` | Show routing information. |
| `-a` | Show all sockets (both listening and established). |
| `-s` | Display summary statistics. |

---

## **Usage Examples**

### **1️⃣ Show All Connections**
```sh
ss -a
```
- Displays all TCP and UDP connections (both listening and established).

### **2️⃣ Show Only Listening Sockets**
```sh
ss -l
```
- Lists all sockets in the `LISTEN` state.

### **3️⃣ Show Only TCP Connections**
```sh
ss -t
```
- Lists only TCP connections.

### **4️⃣ Show Only UDP Connections**
```sh
ss -u
```
- Lists only UDP connections.

### **5️⃣ Show Listening TCP Ports**
```sh
ss -lt
```
- Shows only TCP listening sockets.

### **6️⃣ Show Processes Using Sockets**
```sh
ss -p
```
- Displays process names and PIDs associated with network sockets.

**Example Output:**
```plaintext
State      Recv-Q Send-Q Local Address:Port  Peer Address:Port   Process
LISTEN     0      128     *:22               *:*                 users:(("sshd",pid=1234,fd=3))
```
- The `sshd` process (PID 1234) is listening on port 22.

### **7️⃣ Show Active Connections (With Peer Details)**
```sh
ss -t -a
```
- Displays both listening and established TCP connections.

**Example Output:**
```plaintext
State     Recv-Q Send-Q  Local Address:Port   Peer Address:Port
ESTAB     0      0       192.168.1.10:22      203.0.113.5:54123
ESTAB     0      0       192.168.1.10:443     198.51.100.20:64932
```
- Shows SSH (port 22) and HTTPS (port 443) connections.

### **8️⃣ Show Numerical Addresses (Skip DNS Lookup)**
```sh
ss -tn
```
- Displays IP addresses instead of resolving domain names.

### **9️⃣ Show Statistics Summary**
```sh
ss -s
```
- Provides a summary of TCP, UDP, and raw sockets.

**Example Output:**
```plaintext
Total: 213 (kernel 312)
TCP:   38 (estab 12, closed 5, orphaned 0, timewait 3, allocated 20)
UDP:   25
```

### **🔟 Show Connections to a Specific Port**
```sh
ss -t -a | grep ":80"
```
- Lists all TCP connections involving port 80 (HTTP).

### **1️⃣1️⃣ Show Sockets with Specific State**
```sh
ss -t state ESTABLISHED
```
- Shows only established TCP connections.

### **1️⃣2️⃣ Show IPv4 or IPv6 Sockets**
- **IPv4 only:**  
  ```sh
  ss -4
  ```
- **IPv6 only:**  
  ```sh
  ss -6
  ```

---

## **Advanced Filtering**

### **Filter by Local Address**
```sh
ss -t dst 192.168.1.10
```
- Shows TCP connections going to `192.168.1.10`.

### **Filter by Port**
```sh
ss -t '( dport = :22 or sport = :22 )'
```
- Shows all connections where source or destination is port 22 (SSH).

### **Filter by Process Name**
```sh
ss -t -p | grep sshd
```
- Lists all connections related to the `sshd` process.

---

## **Comparison: `ss` vs. `netstat`**
| Feature | `ss` | `netstat` |
|---------|------|----------|
| Speed | Faster | Slower |
| Kernel Direct Access | ✅ Yes | ❌ No |
| Process Info (`-p`) | ✅ Yes | ✅ Yes |
| Filtering | ✅ Powerful | ❌ Limited |
| Deprecated? | ❌ No | ✅ Yes (in modern Linux) |

---

## **Conclusion**
- `ss` is a **modern, faster, and more efficient** alternative to `netstat`.
- It provides **detailed statistics, filtering, and real-time monitoring**.
- Ideal for **troubleshooting network connections and performance issues**.
