### **What is `ldd` in Linux?**
The `ldd` command in Linux is used to display the **shared library dependencies** of an executable or a shared object (`.so`) file. It helps you determine which `.so` files are required for a program to run.

---

### **Basic Usage**
```bash
ldd /path/to/executable
```
Example:
```bash
ldd /bin/ls
```
Output:
```
linux-vdso.so.1 (0x00007ffe9b5c7000)
libselinux.so.1 => /lib/x86_64-linux-gnu/libselinux.so.1 (0x00007f6c5b000000)
libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f6c5ac00000)
```
This shows:
- The program `/bin/ls` depends on `libselinux.so.1` and `libc.so.6`.
- The path to each shared library.

---

### **Why Use `ldd`?**
✅ **Check missing libraries** → If a required `.so` file is missing, the program won’t run.  
✅ **Find library paths** → Useful when troubleshooting dynamic linking issues.  
✅ **Ensure correct library versions** → Helps avoid conflicts in multi-version environments.  

---

### **How to Check Missing Dependencies**
If a shared library is missing, you’ll see:
```bash
ldd ./my_program
```
Output:
```
libmissing.so.1 => not found
```
To fix this, install the missing library or add its path to `LD_LIBRARY_PATH`:
```bash
export LD_LIBRARY_PATH=/custom/library/path:$LD_LIBRARY_PATH
```

---

### **Check Dependencies of a Shared Library**
You can also use `ldd` on a `.so` file:
```bash
ldd /usr/lib/libc.so.6
```
This helps find other dependencies for shared libraries.

---

### **Security Warning**
🚨 **Do not use `ldd` on untrusted executables** 🚨  
`ldd` can execute code because it loads the binary in a special way. Instead, use:
```bash
objdump -p /path/to/executable | grep NEEDED
```
This lists required libraries **without executing any code**.

---

Would you like a real-world debugging example with `ldd`? 🚀
