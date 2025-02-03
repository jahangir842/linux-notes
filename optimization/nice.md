### **`nice` Command in Linux**

The `nice` command in Linux is used to launch a process with a specified **priority**, affecting its CPU time allocation. It allows system administrators and users to adjust the priority level of processes to manage system resources efficiently. The priority of a process in Linux is managed by its **nice value**.

---

### **Syntax:**
```bash
nice [OPTION] [COMMAND [ARGUMENTS...]]
```

### **Key Options and Usage:**

- **`-n, --adjustment`**: This option allows you to specify the nice value. It’s followed by an integer that adjusts the priority.
  - **Range**: The nice value can range from **-20** (highest priority) to **19** (lowest priority).
  - Default nice value is `0`.

- **`COMMAND`**: This is the command that you want to run with a modified priority.

- **`ARGUMENTS`**: These are optional arguments that can be passed to the command being run.

### **Nice Value (Priority) Explained:**

- **Nice Value**: The nice value determines how much CPU time a process gets in relation to other processes. The higher the nice value, the **lower** the priority. The lower the nice value (including negative values), the **higher** the priority.
  - **Default value**: The default nice value for a process is `0`.
  - **Negative values** (e.g., `-10`): The process gets **higher priority** over other processes, meaning it will be scheduled more frequently and use more CPU time.
  - **Positive values** (e.g., `10`): The process gets **lower priority** and is less likely to consume CPU time compared to other processes.

### **Examples:**

1. **Running a Command with Default Priority:**
   ```bash
   nice make
   ```
   This runs the `make` command with the default nice value of `0`.

2. **Running a Command with Lower Priority:**
   ```bash
   nice -n 10 make
   ```
   This runs the `make` command with a nice value of `10`, which means it will have a lower priority, allowing other processes to get more CPU time.

3. **Running a Command with Higher Priority (Requires sudo):**
   ```bash
   sudo nice -n -10 make
   ```
   This runs the `make` command with a nice value of `-10`, giving it higher priority over other processes (requires root privileges to assign negative nice values).

### **How it Affects CPU Scheduling:**

- **Positive nice values**:
  - Processes with higher nice values (e.g., `10`, `19`) will be scheduled **less frequently** and will **use fewer resources**. They are ideal for background tasks that should not interrupt more critical processes.
  
- **Negative nice values**:
  - Processes with negative nice values (e.g., `-10`, `-20`) will be scheduled **more frequently**, giving them more access to the CPU. They are typically used for performance-sensitive tasks that need to finish quickly.
  
### **Viewing Process Priority:**
To view the priority (nice value) of a running process, you can use the following commands:
- **`ps` Command:**
  ```bash
  ps -eo pid,ni,comm
  ```
  This will display the PID, nice value (ni), and command name (comm) of all running processes.
  
- **`top` Command**:
  - Open `top`, then press `f` to toggle the fields and select **Nice** to display the nice value for processes.

### **Important Notes:**

- **Root Privileges**: To set a negative nice value (higher priority), you need **root privileges** because it can impact system performance by monopolizing CPU resources.
  
- **Process Priority and `renice`**: The `renice` command allows you to change the nice value of an already running process. It can be useful if you want to adjust the priority of a process after it has started.

### **Related Commands:**

- **`renice`**: This command is used to change the nice value of a running process. It's similar to `nice` but applies to already running processes.
  
  Example of using `renice`:
  ```bash
  sudo renice -n 5 -p 1234
  ```
  This changes the priority of process ID `1234` to a nice value of `5`.

### **Use Cases for the `nice` Command:**

- **Background Jobs**: When running background processes, use `nice` to ensure they don't consume excessive CPU resources.
  
- **Long-Running Processes**: If you're running a task that doesn't require high priority, like downloading files or running scripts, you can set a positive nice value to avoid interrupting critical tasks.

- **Performance Testing**: During benchmarking or performance testing, you might want to reduce the priority of non-essential processes to see the maximum CPU performance available for the tests.

### **Conclusion:**

The `nice` command is a powerful tool for controlling process priority in Linux. By adjusting the nice value, system administrators and users can manage CPU resources more efficiently, ensuring that high-priority tasks get more CPU time and low-priority tasks don't interfere with critical processes.

Let me know if you need any more details or examples!
