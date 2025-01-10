The `nproc` command in Linux is used to display the number of processing units (logical CPUs) available to the current process. This includes all the cores and threads available to your system, considering any restrictions like cgroups.

---

### **Syntax**
```bash
nproc [OPTION]...
```

---

### **Key Features**
- **Default Behavior**: When run without options, it prints the total number of available logical CPUs.
- **Considers Limits**: If the system has resource restrictions (e.g., via cgroups), `nproc` will reflect those limits rather than the physical total.

---

### **Options**
1. `--all`: Displays the total number of processing units on the system, ignoring any restrictions.
   ```bash
   nproc --all
   ```

2. `--help`: Displays help information about the command.
   ```bash
   nproc --help
   ```

---

### **Example Usage**
1. **Check Available CPUs**
   ```bash
   nproc
   ```
   Output: `4` (if your system has 4 logical CPUs available).

2. **Check Total CPUs**
   ```bash
   nproc --all
   ```
   Output: `8` (if your system has 8 logical CPUs but only 4 are assigned to your session).

---

### **Use Cases**
- Optimize software builds:
  ```bash
  make -j$(nproc)
  ```
  This runs the `make` command with as many parallel jobs as there are available CPUs.

- Monitoring system configuration or troubleshooting performance.

---

### **Related Commands**
- `lscpu`: Provides detailed information about the CPU architecture.
- `cat /proc/cpuinfo`: Shows information about the CPU(s) in your system.
