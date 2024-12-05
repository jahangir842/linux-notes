# **Notes on `top` and `htop` Commands in Linux**

The `top` and `htop` commands are popular utilities for monitoring system performance and managing processes in Linux. Both tools provide real-time insights into system resource usage, but they differ in usability and features.

---

## **`top` Command**
The `top` command is a default process-monitoring utility in Linux that displays resource usage and active processes in real-time.

### **1. Key Features**
- Displays CPU, memory, and process usage.
- Provides an interactive interface for process management.
- Lightweight and available on all Linux distributions.

---

### **2. Syntax**
```bash
top [options]
```

### **3. Sections of the Output**
- **System Summary** (top section): Displays CPU, memory usage, uptime, and load average.
- **Process List** (bottom section): Shows processes sorted by CPU usage by default.

---

### **4. Common Options**
| Option            | Description                                |
|-------------------|--------------------------------------------|
| `-d <seconds>`    | Set delay between updates (default: 3 sec).|
| `-p <pid>`        | Monitor a specific process by PID.         |
| `-u <user>`       | Display processes for a specific user.     |
| `-n <iterations>` | Run for a specific number of updates.      |
| `-b`              | Run in batch mode for logging purposes.    |

---

### **5. Interactive Keybinds**
| Key       | Action                                       |
|-----------|---------------------------------------------|
| `q`       | Quit the `top` interface.                   |
| `h`       | Show help.                                  |
| `k`       | Kill a process by entering its PID.         |
| `r`       | Change the priority (renice) of a process.  |
| `M`       | Sort processes by memory usage.             |
| `P`       | Sort processes by CPU usage.                |
| `T`       | Sort processes by runtime.                  |

---

### **6. Use Cases**
- Monitor high CPU or memory-consuming processes.
- Manage processes by killing or renicing.
- Analyze system load and uptime.

---

## **`htop` Command**
The `htop` command is an interactive and user-friendly alternative to `top`, offering a more visually appealing interface with additional features.

### **1. Key Features**
- Color-coded display for better readability.
- Allows scrolling through the process list and system summary.
- Supports mouse interaction.
- Displays a graphical representation of CPU, memory, and swap usage.

---

### **2. Installation**
`htop` is not always installed by default. Install it using:
```bash
# Ubuntu/Debian
sudo apt install htop

# CentOS/RHEL
sudo yum install htop

# Fedora
sudo dnf install htop
```

---

### **3. Syntax**
```bash
htop [options]
```

---

### **4. Key Advantages Over `top`**
- Easier navigation with arrow keys and mouse support.
- Allows filtering processes.
- Displays full command lines for processes.
- Can sort processes by various metrics dynamically.
- Supports killing multiple processes at once.

---

### **5. Common Options**
| Option            | Description                                |
|-------------------|--------------------------------------------|
| `-d <delay>`      | Set delay between updates.                 |
| `-u <user>`       | Show processes of a specific user.         |
| `-p <pid>`        | Show only processes with specified PIDs.   |
| `-C`              | Disable color in output.                   |

---

### **6. Interactive Keybinds**
| Key       | Action                                       |
|-----------|---------------------------------------------|
| `F1`      | Help menu.                                  |
| `F2`      | Configuration menu (customize display).     |
| `F3`      | Search for processes.                       |
| `F4`      | Filter processes.                           |
| `F5`      | Display process tree.                       |
| `F6`      | Sort processes by a specific metric.        |
| `F9`      | Kill a process.                             |
| `F10`     | Quit `htop`.                                |

---

### **7. Customization**
- Use `F2` to customize columns, colors, and meters.
- Add or remove metrics such as I/O stats, threads, or swap usage.

---

### **8. Use Cases**
- Monitor resource usage in a visually appealing way.
- Manage and filter processes efficiently.
- Customize monitoring to suit specific needs.

---

## **Comparison: `top` vs `htop`**

| Feature                  | `top`                                | `htop`                              |
|--------------------------|---------------------------------------|-------------------------------------|
| **Ease of Use**          | Command-line interaction only.       | Interactive with mouse/keyboard.   |
| **Interface**            | Minimal and plain text.              | Color-coded, user-friendly.        |
| **Customizability**       | Limited.                            | Highly customizable via menus.     |
| **Process Filtering**    | Manual using `grep`.                 | Built-in filtering and searching.  |
| **Sorting**              | Basic (CPU, memory, etc.).           | Advanced sorting with dynamic options. |
| **System Metrics**       | Comprehensive but plain.             | Graphical and detailed.            |
| **Multiple Processes**   | Kill one process at a time.          | Kill multiple processes at once.   |

---

## **When to Use**
- Use `top` when:
  - You need a lightweight and minimal monitoring tool.
  - You are working on a system without `htop` installed.
  
- Use `htop` when:
  - You prefer a visually appealing interface.
  - You need advanced features like filtering, sorting, and customization.

---

## **Examples**
### **Monitor Processes with `top`**
```bash
top -u user1
```
Monitor processes for user `user1`.

### **Monitor with `htop`**
```bash
htop
```
Start `htop` with default settings.

### **Filter Processes in `htop`**
Press `F4`, type a keyword (e.g., `apache`), and view only matching processes.

### **Sort by Memory Usage in `htop`**
Press `F6`, select `MEM%`, and hit Enter to sort by memory.

---

`top` and `htop` are essential tools for Linux administrators and DevOps engineers, offering complementary capabilities for real-time system monitoring and process management.
