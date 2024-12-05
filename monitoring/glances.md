# **Notes on the `glances` Command in Linux**

`glances` is a comprehensive, cross-platform, real-time system monitoring tool. It provides an extensive overview of system resources such as CPU, memory, disk, network, and more, all in a single, customizable interface. It is designed to be lightweight and adaptable for both terminal and web-based monitoring.

---

## **1. Features**
- Real-time system monitoring.
- Displays metrics for CPU, memory, disk I/O, network, sensors, processes, and more.
- Automatically adjusts the display based on terminal size.
- Supports remote monitoring via web or API mode.
- Extensible via plugins and integration with other tools (e.g., Docker, RAID, etc.).

---

## **2. Installation**
### **Ubuntu/Debian**
```bash
sudo apt update
sudo apt install glances
```

### **CentOS/RHEL**
```bash
sudo yum install epel-release
sudo yum install glances
```

### **Fedora**
```bash
sudo dnf install glances
```

### **From Python Package Index (Latest Version)**
Install or upgrade using `pip`:
```bash
pip install glances
```

### **Other Platforms**
Refer to the [official Glances documentation](https://nicolargo.github.io/glances/) for installation on other platforms.

---

## **3. Basic Usage**
Run `glances` to start monitoring in the terminal:
```bash
glances
```

---

## **4. Key Metrics Displayed**
| Metric        | Description                                                      |
|---------------|------------------------------------------------------------------|
| **CPU**       | Usage percentage, temperature, and load average.                |
| **Memory**    | RAM usage, available memory, and swap utilization.               |
| **Disk I/O**  | Read/write speeds, available disk space.                         |
| **Network**   | Upload/download speeds, total data transferred.                  |
| **Processes** | Active processes sorted by resource usage (CPU, memory, etc.).   |
| **Sensors**   | Temperature and fan speed (if supported by the system).          |
| **Docker**    | Docker container stats (if Docker is installed and running).     |

---

## **5. Command-Line Options**
| Option               | Description                                                                 |
|-----------------------|-----------------------------------------------------------------------------|
| `-h, --help`          | Show help message and exit.                                                |
| `-v, --version`       | Show the current version of Glances.                                       |
| `-c, --config`        | Use a specific configuration file.                                         |
| `-d, --disable-plugin`| Disable specific plugins (e.g., `-d network`).                             |
| `-f, --export`        | Export monitoring data to a file, database, or other system.               |
| `-s, --server`        | Start Glances in server mode for remote monitoring.                        |
| `-w, --webserver`     | Start Glances with a web interface (accessible via a browser).             |
| `-t <seconds>`        | Set the refresh time in seconds (default is 1 second).                     |
| `--quiet`             | Run in quiet mode, showing minimal information.                           |

---

## **6. Interactive Keybinds**
While running `glances`, you can interact with it using the following keys:

| Key       | Action                                                |
|-----------|-------------------------------------------------------|
| `1`       | Toggle per-CPU stats.                                 |
| `c`       | Sort processes by CPU usage.                          |
| `m`       | Sort processes by memory usage.                       |
| `n`       | Sort processes by network I/O.                        |
| `d`       | Sort processes by disk I/O.                           |
| `q`       | Quit the application.                                 |
| `l`       | Show log messages.                                    |
| `x`       | Delete warning messages.                              |
| `t`       | View system temperature (if supported).               |
| `u`       | View cumulative network usage stats.                  |

---

## **7. Advanced Usage**
### **Run in Web Mode**
Start a web server for remote monitoring:
```bash
glances -w
```
Access it in your browser at `http://<server-ip>:61208`.

### **Run in Server Mode**
Launch Glances as a server for remote monitoring:
```bash
glances -s
```
Connect remotely with:
```bash
glances -c <server-ip>
```

### **Export Data**
Export Glances data to a file or system:
```bash
glances --export influxdb
```
Supported backends include **CSV, JSON, InfluxDB, Graphite, and OpenTSDB**.

---

## **8. Example Commands**
### **Monitor with Refresh Interval**
Run Glances with a 5-second refresh rate:
```bash
glances -t 5
```

### **Disable a Plugin**
Run without network statistics:
```bash
glances -d network
```

### **Remote Monitoring**
Monitor a remote machine:
1. Start the server on the remote machine:
   ```bash
   glances -s
   ```
2. Connect from the client machine:
   ```bash
   glances -c <remote-ip>
   ```

---

## **9. Use Cases**
- **System Health Monitoring**: Monitor resource usage and identify bottlenecks.
- **Troubleshooting**: Real-time observation of processes and services consuming high resources.
- **Remote Administration**: Monitor servers remotely using web or client mode.
- **Integration**: Export data to databases for long-term analysis.

---

## **10. Advantages**
- Lightweight and efficient.
- Comprehensive overview of all major system metrics.
- Highly customizable with plugins and configuration options.
- Extensible for web-based and remote monitoring.

---

## **11. Additional Resources**
- [Official Documentation](https://nicolargo.github.io/glances/)
- Use `glances -h` to explore all options.

`glances` is a powerful tool that every Linux administrator and DevOps engineer should know. It simplifies monitoring, making it easy to diagnose system performance issues effectively.
