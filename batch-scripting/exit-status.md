Here's a detailed note about **exit status** in Linux, including how it works, how to use it, common exit codes, and best practices.  

---

# **Exit Status in Linux**  

## **1. What is Exit Status?**  
In Linux and Unix-based systems, every command executed in the shell returns an **exit status** (also called an **exit code** or **return code**). This status indicates whether the command ran successfully or encountered an error.  

## **2. Checking Exit Status**  
You can check the exit status of the last executed command using:  

```bash
echo $?
```
- `$?` is a special variable that stores the exit status of the last command.  
- `echo $?` prints the value of this variable.  

## **3. Meaning of Exit Codes**  

| Exit Code | Meaning |
|-----------|---------|
| **0** | Success: The command executed without errors. |
| **1** | General error: The command failed but doesn’t fit into other categories. |
| **2** | Misuse of shell built-ins (syntax errors, invalid options). |
| **126** | Command invoked but cannot execute (e.g., permission denied). |
| **127** | Command not found (e.g., typo in the command name). |
| **128** | Invalid exit argument (exit code > 255). |
| **130** | Command terminated by **Ctrl+C** (SIGINT signal). |
| **137** | Process killed (e.g., `kill -9`). |
| **255** | Exit status out of range. |

## **4. Examples**  

### **a) Successful Execution (`0`)**  
```bash
ls
echo $?  # Output: 0 (Success)
```

### **b) Command Failure (`1`)**  
```bash
ls /nonexistent-directory
echo $?  # Output: 2 (No such file or directory)
```

### **c) Command Not Found (`127`)**  
```bash
nonexistentcommand
echo $?  # Output: 127 (Command not found)
```

### **d) Permission Denied (`126`)**  
```bash
touch script.sh
chmod -r script.sh   # Remove execute permission
./script.sh
echo $?  # Output: 126 (Permission denied)
```

### **e) Terminated with SIGINT (`130`)**  
```bash
ping google.com   # Press Ctrl+C to stop
echo $?  # Output: 130 (Terminated by SIGINT)
```

## **5. Using Exit Status in Scripts**  
Exit status is useful in scripting to check for errors and make decisions.

### **a) Using `if` to Check Exit Status**  
```bash
#!/bin/bash
mkdir /testdir

if [ $? -eq 0 ]; then
    echo "Directory created successfully."
else
    echo "Failed to create directory."
fi
```

### **b) Using `&&` and `||` Operators**
- `&&` (AND) → Run the next command **only if** the first command succeeds.
- `||` (OR) → Run the next command **only if** the first command fails.

```bash
mkdir /testdir && echo "Success" || echo "Failure"
```
- If `mkdir /testdir` **succeeds**, "Success" is printed.
- If `mkdir /testdir` **fails**, "Failure" is printed.

## **6. Custom Exit Codes in Scripts**  
You can set a custom exit code in shell scripts using the `exit` command.

### **Example: Using `exit` in a Script**
```bash
#!/bin/bash

file="/etc/passwd"

if [ -f "$file" ]; then
    echo "File exists."
    exit 0  # Successful execution
else
    echo "File does not exist."
    exit 1  # Custom failure exit code
fi
```

### **Running the Script**
```bash
./check_file.sh
echo $?  # Will show 0 if successful, 1 if file is missing
```

## **7. Best Practices**
- Always check exit codes in automation scripts (e.g., Ansible, CI/CD pipelines).
- Use `set -e` at the beginning of a script to **exit immediately** on any command failure.
- Use meaningful custom exit codes in scripts for debugging.
- Log errors when a command fails for easier troubleshooting.

---

This provides a comprehensive guide to **exit status** in Linux. Let me know if you need more details! 🚀
