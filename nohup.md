### **`nohup` Command**

**Purpose**: 
- The `nohup` command stands for "no hangup". It is used to run another command or process in a way that it ignores hangup signals, allowing the process to continue running even after the user logs out or the terminal is closed.

**Usage**:
- **Basic Syntax**:
  ```bash
  nohup command [arguments] &
  ```
  - **`command`**: The command you want to run.
  - **`[arguments]`**: Any arguments for the command.
  - **`&`**: Runs the command in the background.

**Common Use Cases**:
- Running long-running processes that you want to continue after logging out of a session.
- Starting background jobs or services on a server that should persist independently of the terminal session.

**Output Handling**:
- By default, `nohup` redirects the standard output (stdout) and standard error (stderr) to a file named `nohup.out` in the current directory if they are not redirected explicitly.
- **Redirecting Output**:
  ```bash
  nohup command > output.log 2>&1 &
  ```
  - **`> output.log`**: Redirects stdout to `output.log`.
  - **`2>&1`**: Redirects stderr to the same location as stdout.

**Examples**:
- **Run a Python script in the background**:
  ```bash
  nohup python3 script.py &
  ```
- **Start a web server in the background**:
  ```bash
  nohup ./start_server.sh > server.log 2>&1 &
  ```

**Notes**:
- The `nohup` command is often used with the `&` symbol to run processes in the background.
- It is useful for long-running tasks on remote servers or systems where you want to ensure that processes continue to run even if the session is terminated.
