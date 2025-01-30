### **What is `pkill`?**  
`pkill` (Process Kill) is a command in Linux used to **terminate processes** based on their **name** or other attributes. It is similar to `kill`, but instead of using **process IDs (PIDs)**, it allows you to **kill processes by name**.

---

### **Basic Usage of `pkill`**
#### **1. Kill a Process by Name**
```bash
pkill brave
```
- This will **terminate all processes** with the name **`brave`**.
- If multiple instances of **Brave** are running, all will be closed.

#### **2. Kill a Process with Confirmation (`-i`)**
```bash
pkill -i firefox
```
- The `-i` flag makes the process **case insensitive**, so it will match both `Firefox` and `firefox`.

#### **3. Kill a Process Owned by a Specific User**
```bash
pkill -u jahangir brave
```
- Kills **Brave** processes started by user `jahangir`.

#### **4. Kill a Process with a Warning (`-signal`)**
```bash
pkill -15 firefox
```
- **`-15` (SIGTERM)** is the default signal, which **gracefully** stops the process.
- You can also use:
  - `pkill -9 firefox` (**SIGKILL** - forcefully kills).
  - `pkill -1 firefox` (**SIGHUP** - tells process to restart).

---

### **Difference Between `pkill` and `kill`**
| Command | Works With | Example |
|---------|------------|---------|
| `pkill` | Process name | `pkill firefox` |
| `kill`  | Process ID (PID) | `kill 1234` |

If you don’t know the **PID**, use `pkill`. If you want to **target a specific instance**, use `kill` with the PID.

---

### **Check if a Process is Running Before Killing**
Before using `pkill`, check if the process is running:
```bash
pgrep brave
```
If it returns a PID, the process is active.
