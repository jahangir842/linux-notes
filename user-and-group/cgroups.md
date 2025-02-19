# **Control Groups (cgroups) in Linux:**  

## **1. Introduction to cgroups**
Control Groups (cgroups) is a Linux kernel feature that allows system administrators to allocate and limit resources—such as CPU, memory, disk I/O, and network bandwidth—among different processes. It plays a crucial role in containerized environments like **Docker** and **Kubernetes**, ensuring that workloads do not interfere with each other by consuming excessive system resources.

### **Key Features of cgroups:**
- **Resource Allocation** → Restricts and prioritizes resources for processes.
- **Isolation** → Prevents one process from affecting the performance of another.
- **Accounting** → Tracks resource usage per group.
- **Control** → Dynamically adjust limits for running processes.

---

## **2. Versions of cgroups**
There are two major versions of cgroups:
1. **cgroups v1** → Used in older Linux distributions, supports hierarchical resource management but lacks a unified control interface.
2. **cgroups v2** → Introduced in Linux kernel 4.5, offers a single, unified hierarchy with more efficient resource management.

> Modern container platforms, including Kubernetes and Docker, are gradually transitioning to **cgroups v2** for better performance and security.

---

## **3. How cgroups Work**
cgroups organize processes into **hierarchies**, called **control groups**, which are managed via special files in the **cgroup filesystem** (`/sys/fs/cgroup`).  

Each hierarchy contains **subsystems (controllers)** that enforce resource limits.

### **Example of a cgroups hierarchy**
```
/sys/fs/cgroup/
├── cpu
│   ├── groupA
│   ├── groupB
│   └── groupC
├── memory
│   ├── groupA
│   ├── groupB
│   └── groupC
```
- Each **controller (cpu, memory, etc.)** has its own subdirectory.
- **Processes** are assigned to groups (`groupA`, `groupB`, etc.), inheriting resource limits from their parent groups.

---

## **4. cgroups Controllers**
cgroups use **controllers** (also called subsystems) to manage different resources. Below are some key controllers:

### **1. CPU Controller (`cpu`, `cpuacct`)**
- Limits CPU usage for processes.
- Example: Assign **50% CPU time** to a group.

### **2. Memory Controller (`memory`)**
- Restricts the amount of RAM a process can use.
- Example: Limit **512MB of RAM** to a process.

### **3. Block I/O Controller (`blkio`)**
- Controls disk read/write speeds.
- Example: Limit a process to **10MB/s disk I/O**.

### **4. Network Controller (`net_cls`, `net_prio`)**
- Controls network bandwidth for processes.
- Example: Limit a process to **100Mbps** network speed.

### **5. Device Controller (`devices`)**
- Restricts access to specific hardware devices (e.g., block USB access).

### **6. Freezer Controller (`freezer`)**
- Suspends or resumes processes inside a cgroup.

> These controllers provide **fine-grained control** over system resources.

---

## **5. Working with cgroups**
### **Checking if cgroups is enabled**
```bash
ls /sys/fs/cgroup
```
If the output contains multiple directories (`cpu`, `memory`, `blkio`, etc.), cgroups is enabled.

### **Creating a new cgroup manually**
#### **Step 1: Create a cgroup for CPU restriction**
```bash
sudo mkdir /sys/fs/cgroup/cpu/my_cgroup
```
#### **Step 2: Set CPU limit (50% CPU)**
```bash
echo 50000 | sudo tee /sys/fs/cgroup/cpu/my_cgroup/cpu.cfs_quota_us
echo 100000 | sudo tee /sys/fs/cgroup/cpu/my_cgroup/cpu.cfs_period_us
```
#### **Step 3: Assign a process to the cgroup**
```bash
echo 1234 | sudo tee /sys/fs/cgroup/cpu/my_cgroup/cgroup.procs
```
(Replace `1234` with the process ID of a running process)

> This ensures that the process can use **only 50% of the CPU**.

---

## **6. Managing cgroups with systemd**
Modern Linux distributions use `systemd` to manage cgroups. Instead of manually creating directories, you can define cgroups in `systemd` service files.

### **Creating a systemd unit with cgroup limits**
1. Create a systemd service file:
```bash
sudo nano /etc/systemd/system/my_service.service
```
2. Add the following content:
```ini
[Unit]
Description=My Test Service

[Service]
ExecStart=/usr/bin/sleep 600
CPUQuota=50%

[Install]
WantedBy=multi-user.target
```
3. Reload systemd and start the service:
```bash
sudo systemctl daemon-reload
sudo systemctl start my_service
```
4. Verify CPU quota:
```bash
systemctl show my_service | grep CPUQuota
```
> This ensures that the service does **not exceed 50% CPU usage**.

---

## **7. cgroups in Containers (Docker & Kubernetes)**
### **Docker**
Docker automatically creates cgroups for running containers. You can check cgroups usage for a running container:
```bash
docker stats
```
To limit CPU and memory while running a container:
```bash
docker run -it --memory=512m --cpus="1.5" ubuntu
```
This container will have:
- **512MB RAM limit**
- **1.5 CPU cores**

### **Kubernetes**
Kubernetes uses cgroups to enforce resource limits in pods.

Example YAML definition for resource limits:
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: limited-pod
spec:
  containers:
    - name: my-container
      image: nginx
      resources:
        limits:
          memory: "512Mi"
          cpu: "500m"  # 0.5 CPU
        requests:
          memory: "256Mi"
          cpu: "250m"  # 0.25 CPU
```
> This ensures that the **nginx** container:
> - **Can use up to 512MB RAM & 0.5 CPU core**
> - **Requests at least 256MB RAM & 0.25 CPU core**

---

## **8. cgroups v1 vs. cgroups v2**
| Feature            | cgroups v1                         | cgroups v2                           |
|-------------------|--------------------------------|--------------------------------|
| Hierarchy        | Multiple hierarchies          | Single unified hierarchy       |
| Controllers      | Separate for each resource   | Unified controller system      |
| Process Management | Process can belong to multiple cgroups | Process belongs to only one cgroup |
| Flexibility      | More complex, harder to manage | Simpler, more efficient        |

To check which version your system is using:
```bash
cat /sys/fs/cgroup/cgroup.controllers
```
If this file exists, your system is using **cgroups v2**.

---

## **9. Disabling cgroups (If Needed)**
To disable cgroups v2 and switch back to v1:
1. Edit the GRUB configuration:
```bash
sudo nano /etc/default/grub
```
2. Add this parameter to `GRUB_CMDLINE_LINUX`:
```ini
systemd.unified_cgroup_hierarchy=0
```
3. Update GRUB and reboot:
```bash
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
sudo reboot
```

---

## **10. Conclusion**
cgroups is a powerful feature that enables **resource control, isolation, and management** for Linux processes. It is widely used in **Docker, Kubernetes, and systemd** to ensure efficient resource utilization.  
With the introduction of **cgroups v2**, resource management has become more **unified, efficient, and easier to use**.
