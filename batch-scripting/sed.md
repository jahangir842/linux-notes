
# **Guide to `sed` in Linux**

`sed` (Stream Editor) is a powerful command-line utility in Linux for manipulating text. It processes input (files or streams) line by line, applying commands to search, replace, delete, insert, or transform text. It’s widely used in scripting, automation, and text processing tasks due to its efficiency and flexibility.

---

## **What is `sed`?**
- **Purpose**: Edit text non-interactively by applying predefined commands.
- **Key Feature**: Processes text as a stream, reading one line at a time, modifying it, and outputting the result.
- **Use Cases**: Bulk text replacements, log filtering, configuration file edits, and more.

---

## **1. Basic Syntax**
The general form of a `sed` command is:
```bash
sed [OPTIONS] 'COMMAND' [INPUT_FILE]
```
- **`OPTIONS`**: Modify `sed`’s behavior (e.g., `-i` for in-place edits).
- **`COMMAND`**: The action to perform (e.g., `s/old/new/` for substitution).
- **`INPUT_FILE`**: The file to process (optional; `sed` can read from a pipe if omitted).

### Common Options:
- `-i`: Edit the file in place (overwrites the original).
- `-n`: Suppress automatic printing of all lines (useful with `p` command).
- `-e`: Specify multiple commands in one run.
- `-f`: Read commands from a script file.

---

## **2. Core Commands**
`sed` uses a simple scripting language. Here are the most common commands:

### **Substitution (`s`)**:
```bash
s/SEARCH_PATTERN/REPLACEMENT/FLAGS
```
- Replaces text matching `SEARCH_PATTERN` with `REPLACEMENT`.
- **Flags**:
  - `g`: Replace all occurrences on a line.
  - `i`: Case-insensitive matching.
  - Number (e.g., `2`): Replace the nth occurrence only.

### **Delete (`d`)**:
```bash
/pattern/d
```
- Deletes lines matching the pattern.

### **Print (`p`)**:
```bash
/pattern/p
```
- Prints lines matching the pattern (combine with `-n` to suppress other output).

### **Insert (`i`)**:
```bash
/pattern/i\TEXT
```
- Inserts `TEXT` before matching lines.

### **Append (`a`)**:
```bash
/pattern/a\TEXT
```
- Appends `TEXT` after matching lines.

---

## **3. Basic Examples**

### **a) Simple Substitution**
```bash
echo "Hello World" | sed 's/World/Linux/'
```
- **Output**: `Hello Linux`
- **Explanation**: Replaces the first "World" with "Linux" on the line.

### **b) Global Substitution**
```bash
echo "cat cat dog" | sed 's/cat/bird/g'
```
- **Output**: `bird bird dog`
- **Explanation**: The `g` flag replaces all "cat" instances.

### **c) In-Place Edit**
```bash
sed -i 's/error/warning/g' log.txt
```
- **Explanation**: Replaces all "error" with "warning" in `log.txt` and saves the changes.

### **d) Delete Matching Lines**
```bash
sed '/error/d' log.txt
```
- **Output**: Prints `log.txt` without lines containing "error."
- **Explanation**: The `d` command removes matched lines.

---

## **4. Addressing Lines**
`sed` can target specific lines or ranges:

### **a) Single Line**
```bash
sed '3s/cat/dog/' file.txt
```
- Replaces "cat" with "dog" only on line 3.

### **b) Range of Lines**
```bash
sed '2,5s/cat/dog/g' file.txt
```
- Replaces all "cat" with "dog" on lines 2 through 5.

### **c) Pattern Range**
```bash
sed '/start/,/end/s/cat/dog/g' file.txt
```
- Replaces "cat" with "dog" between lines matching "start" and "end" (inclusive).

### **d) Last Line**
```bash
sed '$d' file.txt
```
- Deletes the last line (`$` represents the end).

---

## **5. Regular Expressions**
`sed` supports regex for advanced pattern matching:

### **a) Match Digits**
```bash
echo "Order 123 completed" | sed 's/[0-9]\+/ORDER_ID/g'
```
- **Output**: `Order ORDER_ID completed`
- **Explanation**: `[0-9]\+` matches one or more digits.

### **b) Word Boundaries**
```bash
echo "cat caterpillar catnip" | sed 's/\bcat\b/fish/g'
```
- **Output**: `fish caterpillar catnip`
- **Explanation**: `\b` ensures "cat" is a standalone word, not part of "caterpillar."

### **c) Start/End of Line**
```bash
echo "start middle end" | sed 's/^start/begin/'
```
- **Output**: `begin middle end`
- **Explanation**: `^` anchors to the start of the line.

---

## **6. Advanced Substitution**

### **a) Capture Groups**
```bash
echo "John Doe" | sed 's/\(.*\) \(.*\)/\2, \1/'
```
- **Output**: `Doe, John`
- **Explanation**: `\(\.*\)` captures text; `\1` and `\2` reuse the captured groups.

### **b) Conditional Replacement**
```bash
echo "ID: 123" | sed 's/ID: \([0-9]\+\)/UserID: \1/'
```
- **Output**: `UserID: 123`
- **Explanation**: Captures digits after "ID:" and reuses them.

### **c) Case Conversion**
```bash
echo "hello world" | sed 's/\(.*\)/\U\1/'
```
- **Output**: `HELLO WORLD`
- **Explanation**: `\U` converts the captured text to uppercase.

---

## **7. Modifying Files**

### **a) Backup Before Editing**
```bash
sed -i.bak 's/error/warning/g' log.txt
```
- Creates `log.txt.bak` as a backup before modifying `log.txt`.

### **b) Multiple Files**
```bash
sed -i 's/old/new/g' *.txt
```
- Applies the replacement to all `.txt` files in the directory.

---

## **8. Inserting and Appending**

### **a) Insert Before**
```bash
sed '/error/i\WARNING: Problem detected' log.txt
```
- Adds "WARNING: Problem detected" before every line with "error."

### **b) Append After**
```bash
sed '/completed/a\Timestamp: $(date)' status.txt
```
- Adds a timestamp after lines with "completed."

### **c) At File Start/End**
```bash
sed '1i\Header Line' file.txt  # Insert at start
sed '$a\Footer Line' file.txt  # Append at end
```

---

## **9. Custom Delimiters**
If your pattern includes slashes (`/`), use a different delimiter (e.g., `|`):
```bash
sed 's|/var/www|/opt/app|g' config.txt
```
- **Explanation**: Avoids escaping slashes, making the command readable.

---

## **10. Multiple Commands**
Run several operations in one `sed` invocation:

### **a) Using `-e`**
```bash
sed -e 's/cat/dog/g' -e 's/mouse/rat/g' file.txt
```
- Replaces "cat" with "dog" and "mouse" with "rat."

### **b) Using Semicolon**
```bash
sed 's/cat/dog/g;s/mouse/rat/g' file.txt
```
- Same as above, but more concise.

### **c) Script File**
Create `commands.sed`:
```
s/cat/dog/g
s/mouse/rat/g
```
Run:
```bash
sed -f commands.sed file.txt
```

---

## **11. Filtering and Extraction**

### **a) Extract First Column**
```bash
echo "one two three" | sed 's/ .*//'
```
- **Output**: `one`
- **Explanation**: Removes everything after the first space.

### **b) Remove Non-Numeric**
```bash
echo "Price: $99.99" | sed 's/[^0-9.]//g'
```
- **Output**: `99.99`
- **Explanation**: Keeps digits and dots, removes everything else.

---

## **12. Practical Examples**

### **a) Clean HTML**
```bash
echo "<p>Hello <b>World</b></p>" | sed 's/<[^>]*>//g'
```
- **Output**: `Hello World`
- **Explanation**: Strips all HTML tags.

### **b) Normalize Spaces**
```bash
echo "too   many    spaces" | sed 's/ \+/ /g'
```
- **Output**: `too many spaces`
- **Explanation**: Replaces multiple spaces with one.

### **c) Comment Out Lines**
```bash
sed '/debug/s/^/#/' config.txt
```
- Adds `#` to the start of lines with "debug."

---

## **13. Combining with Other Tools**
- **With `grep`**:
```bash
cat log.txt | sed 's/error/ERROR/g' | grep 'ERROR'
```
- Filters lines after transforming "error" to "ERROR."

- **With `find`**:
```bash
find . -name "*.txt" -exec sed -i 's/old/new/g' {} \;
```
- Edits all `.txt` files recursively.

---

## **14. `sed` vs. Alternatives**
| **Tool** | **Strengths**                  | **Weaknesses**              |
|----------|--------------------------------|-----------------------------|
| `sed`    | Substitution, line edits      | No math or field parsing    |
| `awk`    | Field extraction, calculations| Less focus on substitution  |
| `grep`   | Pattern matching              | No editing capability       |

---

## **15. Tips and Best Practices**
- **Test First**: Run without `-i` to preview changes.
- **Escape Special Characters**: Use `\` before `.`, `*`, etc., in patterns.
- **Debugging**: Use `sed -n 'p'` to see what’s being processed.
- **Backup**: Always use `-i.bak` for critical files.

---

## **16. Summary**
- **`sed`** is a lightweight, line-based text processor.
- excels at **search/replace**, **deletions**, **insertions**, and **filtering**.
- Supports **regex** for complex patterns.
- Highly scriptable and integratable with other Linux tools.

---

## **Try It Out**
Create a file `test.txt`:
```
cat dog
bird cat
mouse
```
Run:
```bash
sed -e 's/cat/fish/g' -e '/mouse/d' test.txt
```
- **Output**:
```
fish dog
bird fish
```
