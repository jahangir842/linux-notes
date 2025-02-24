### **Input Redirection Methods in Linux (Including `tee`)**  
Input redirection in Linux allows commands to receive input from sources other than the keyboard (`stdin`). Below are the main methods, including `tee` for capturing output while redirecting.

---

## **1. Standard Input Redirection (`<`)**  
Redirects input from a file instead of the keyboard.

### **Example: Read from a file**
```bash
command < input.txt
```
**Example with `cat`:**
```bash
cat < file.txt
```
This is equivalent to `cat file.txt` and displays the file's contents.

---

## **2. Here Document (`<<`)**  
A **here document** (`<<`) provides multiple lines of input inline.

### **Example: Pass multi-line input to `cat`**
```bash
cat << EOF
Hello
This is a test
EOF
```
This prints:
```
Hello
This is a test
```
`EOF` is a delimiter; you can use any word (e.g., `END`, `DATA`).

---

## **3. Here String (`<<<`)**  
A **here string** (`<<<`) sends a single string as input.

### **Example: Count words in a string**
```bash
wc -w <<< "Hello world"
```
Output:
```
2
```
(`wc -w` counts words, and "Hello world" has 2 words.)

---

## **4. Input Redirection from a Process (`|`, Pipe)**  
A **pipe (`|`)** sends the output of one command as input to another.

### **Example: Count lines in `ls` output**
```bash
ls -l | wc -l
```
- `ls -l` lists files.
- `wc -l` counts lines.

---

## **5. Using `/dev/stdin` or `/proc/self/fd/0`**  
These refer to standard input and can be used as an alternative to `<`.

### **Example: Read input from `/dev/stdin`**
```bash
cat /dev/stdin
```
Type some text, then press `Ctrl+D` to end input.

---

## **6. Using `tee` for Input & Output Redirection**
The **`tee` command** reads input from `stdin`, writes it to a file, and also passes it to the next command.

### **Example: Save and display output simultaneously**
```bash
ls -l | tee output.txt
```
- `tee output.txt` writes the output to `output.txt` and displays it.

### **Example: Append instead of overwriting**
```bash
ls -l | tee -a output.txt
```
(`-a` appends instead of replacing.)

### **Example: Using `tee` in Input Redirection**
You can also use `tee` to store input while passing it:

```bash
cat << EOF | tee input_copy.txt | wc -w
Hello
Linux input redirection
EOF
```
- Saves input to `input_copy.txt`.
- Counts words and prints the result.

---

## **Comparison of Methods**
| Method | Usage | Best for |
|--------|-------|---------|
| `< file` | Redirect file input | Using a file as input |
| `<< EOF` | Here document | Multi-line input |
| `<<< "text"` | Here string | Single-line input |
| `|` | Pipe | Command-to-command input |
| `/dev/stdin` | Read from standard input | Alternative method |
| `tee file` | Save & pass output | Logging while executing |

Would you like more practical examples? 🚀
