# **Notes on `sed` Command in Linux**  

`sed` (**Stream Editor**) is a powerful command-line tool used for text manipulation, searching, replacing, and filtering text in Linux. It processes text files **line by line**, making it useful for automation, scripting, and bulk text modifications.

---

## **1. Basic Syntax**  
```bash
sed [OPTIONS] 's/SEARCH_PATTERN/REPLACEMENT/FLAGS' file
```
- `s/SEARCH_PATTERN/REPLACEMENT/` → Substitutes matching text  
- **Flags**:  
  - `g` → Global replacement (replace all occurrences in a line)  
  - `i` → Case-insensitive search  
  - `p` → Print the modified line  
  - `d` → Delete matching lines  
  - `-i` → Modify the file in place  

---

## **2. Basic Text Substitution**  

### **a) Replace the first occurrence of a word**
```bash
echo "Hello World" | sed 's/World/Linux/'
```
**Output:**  
```
Hello Linux
```

### **b) Replace all occurrences (`g` flag)**
```bash
echo "apple banana apple" | sed 's/apple/orange/g'
```
**Output:**  
```
orange banana orange
```

### **c) Case-insensitive replacement (`i` flag)**
```bash
echo "Linux is Powerful" | sed 's/linux/Ubuntu/i'
```
**Output:**  
```
Ubuntu is Powerful
```

---

## **3. Delete Lines Using `sed`**

### **a) Delete a specific line**
```bash
sed '3d' file.txt
```
(Removes **line 3** from `file.txt`)

### **b) Delete lines matching a pattern**
```bash
sed '/error/d' file.txt
```
(Removes all lines containing the word **error**)

### **c) Delete multiple lines (range)**
```bash
sed '5,10d' file.txt
```
(Removes lines **5 to 10**)

---

## **4. Print Specific Lines (`p` flag)**

### **a) Print only lines matching a pattern**
```bash
sed -n '/error/p' file.txt
```
(Only prints lines containing **error**)

### **b) Print a specific range of lines**
```bash
sed -n '5,10p' file.txt
```
(Displays lines **5 to 10**)

---

## **5. Insert or Append Text**
### **a) Insert a line before a match**
```bash
sed '/Linux/i\This is an inserted line' file.txt
```
(Adds **"This is an inserted line"** before every line that contains "Linux")

### **b) Append a line after a match**
```bash
sed '/Linux/a\This is an appended line' file.txt
```
(Adds **"This is an appended line"** after every line that contains "Linux")

---

## **6. Replace Text in a File (`-i` flag)**
Modify a file **in place** without creating a new output file:
```bash
sed -i 's/old_text/new_text/g' file.txt
```
(*Be careful!* This directly modifies `file.txt`.)

---

## **7. Extract Text Using `sed`**
### **a) Extract specific columns (like `cut`)**
```bash
echo "one two three" | sed 's/ .*//'
```
**Output:**  
```
one
```
(Removes everything after the first space)

### **b) Extract numbers from a line**
```bash
echo "ID: 12345" | sed 's/[^0-9]*//g'
```
**Output:**  
```
12345
```
(Removes all non-numeric characters)

---

## **8. Use `sed` with Regular Expressions**
### **a) Replace digits with `X`**
```bash
echo "My number is 12345" | sed 's/[0-9]/X/g'
```
**Output:**  
```
My number is XXXXX
```

### **b) Replace words starting with "A"**
```bash
echo "Apple Banana Avocado" | sed 's/\bA\w*/Fruit/g'
```
**Output:**  
```
Fruit Banana Fruit
```

---

## **9. Change Delimiter (`|` instead of `/`)**
To avoid conflicts with slashes (`/`), use another delimiter like `|`:
```bash
sed 's|/home/user|/mnt/storage|g' file.txt
```

---

## **10. Advanced Use: Multiple Commands**
### **a) Perform multiple replacements**
```bash
sed -e 's/Linux/Ubuntu/g' -e 's/OpenSource/FreeSoftware/g' file.txt
```
(Changes **Linux → Ubuntu** and **OpenSource → FreeSoftware**)

### **b) Read from a file and apply commands**
```bash
sed -f script.sed file.txt
```
(where `script.sed` contains multiple `sed` commands)

---

## **11. Combine `sed` with Other Commands**
### **a) Use `sed` in a pipeline**
```bash
cat file.txt | sed 's/error/ERROR/g' | grep 'ERROR'
```
(Finds lines where **"error"** is replaced with **"ERROR"**)

### **b) Modify text in multiple files**
```bash
sed -i 's/oldtext/newtext/g' *.txt
```
(Replaces **oldtext → newtext** in all `.txt` files)

---

## **12. Useful Real-World Examples**
### **a) Remove HTML Tags**
```bash
echo "<h1>Hello</h1>" | sed 's/<[^>]*>//g'
```
**Output:**  
```
Hello
```

### **b) Replace Spaces with Underscores**
```bash
echo "Linux Stream Editor" | sed 's/ /_/g'
```
**Output:**  
```
Linux_Stream_Editor
```

### **c) Convert Lowercase to Uppercase**
```bash
echo "hello" | sed 's/.*/\U&/'
```
**Output:**  
```
HELLO
```

---

## **13. Differences Between `sed` and `awk`**
| Feature    | `sed` | `awk` |
|------------|------|------|
| **Usage** | Text substitution | Text extraction, formatting |
| **Pattern Matching** | Yes | Yes |
| **File Processing** | Line-by-line | Field-by-field |
| **Mathematical Operations** | No | Yes |
| **Output Formatting** | Basic | Advanced |

---

## **14. Summary**
- `sed` is a **stream editor** for text processing.
- Supports **search and replace**, **deleting**, **extracting**, and **inserting text**.
- Works with **regular expressions**.
- Can be used for **batch processing** of files.

Would you like a practical example for a specific use case? 🚀
