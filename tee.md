# **🔹 tee Command in Linux**  

The `tee` command in Linux is used to **read input from standard input (`stdin`)** and **write it to one or more files**, while also displaying the output on the terminal (`stdout`). It is commonly used in scripting, logging, and piping command outputs.

---

## **📌 Syntax of tee Command**
```sh
command | tee [options] <file1> [file2] ...
```
- `command` → Any command whose output needs to be saved and displayed.
- `|` (Pipe) → Sends the output of the command to `tee`.
- `tee` → Reads the input and writes it to files while also sending it to standard output.
- `<file1> [file2] ...` → The file(s) where the output will be written.

---

## **🔹 Basic Usage of tee Command**

### **1️⃣ Writing Output to a File**
The following command writes the output of `ls` to `output.txt` while also displaying it:
```sh
ls | tee output.txt
```
📌 *The content of `output.txt` will be the same as what is displayed on the screen.*

🔹 **Example Output**:
```
file1.txt  file2.txt  script.sh
```

---

### **2️⃣ Appending Output to a File**
To **append** output instead of overwriting the file, use the `-a` (append) option:
```sh
ls | tee -a output.txt
```
📌 *This will add the new output to `output.txt` without deleting the previous content.*

---

### **3️⃣ Writing Output to Multiple Files**
You can save the output to **multiple files** at the same time:
```sh
ls | tee file1.txt file2.txt
```
📌 *Both `file1.txt` and `file2.txt` will store the same output.*

---

## **🔹 Advanced Usage of tee Command**

### **4️⃣ Using tee in a Pipeline**
The `tee` command is useful in pipelines (`|`) when you want to process the output multiple times.

#### **Example: Saving and Sorting Output**
```sh
ls | tee output.txt | sort
```
📌 *This first saves the output of `ls` to `output.txt`, then sorts it before displaying.*

---

### **5️⃣ Suppressing Standard Output**
If you want to write output to a file but **do not display it on the terminal**, redirect stdout to `/dev/null`:
```sh
ls | tee output.txt > /dev/null
```
📌 *This writes the output to `output.txt` without showing anything on the screen.*

---

### **6️⃣ Using sudo with tee**
When writing to a system file that requires root privileges, `tee` helps avoid permission errors.

#### **Example: Appending to /etc/hosts**
```sh
echo "127.0.0.1 example.com" | sudo tee -a /etc/hosts
```
📌 *Without `tee`, using `>` redirection directly would fail due to insufficient permissions.*

---

### **7️⃣ Measuring Command Execution Time**
You can save execution time statistics using `tee`:
```sh
(time ls) 2>&1 | tee time.log
```
📌 *This saves the execution time of `ls` to `time.log`.*

---

## **🔹 Common Options for tee Command**
| Option  | Description |
|---------|------------|
| `-a` | Appends to the file instead of overwriting. |
| `-i` | Ignores **interrupt signals** (e.g., `Ctrl+C`). |
| `-p` | Writes to files only when input is available (useful for pipes). |
| `--help` | Displays help information. |
| `--version` | Shows the version of `tee`. |

---

## **🔹 Practical Examples**
### **🔸 Save `dmesg` logs for debugging**
```sh
dmesg | tee system.log
```
📌 *Saves kernel messages to `system.log` while displaying them.*

### **🔸 Monitor Log Files in Real Time**
```sh
tail -f /var/log/syslog | tee -a mylog.txt
```
📌 *Continuously writes new log entries to `mylog.txt` while showing them live.*

---

## **🔹 Summary**
- `tee` reads from **stdin**, writes to **stdout**, and **saves output to one or more files**.
- Useful in **pipelines**, **logging**, and **privileged file modifications**.
- Supports **appending (-a)** and works well with **sudo**.
