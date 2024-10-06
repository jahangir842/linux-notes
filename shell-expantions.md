# Shell Expansions in Linux

Shell expansions are a set of features in Unix-like operating systems that allow the shell to process and expand command-line input before executing commands. Understanding these expansions can significantly improve your productivity when working with the shell.

## 1. Pathname Expansion (Globbing)

**Pathname expansion**, often referred to as globbing, is the process by which the shell interprets wildcard characters in filenames and paths. This allows you to specify groups of files or directories using special characters.

### Wildcard Characters:
- **`*`**: Matches zero or more characters.
  - Example: `ls *.txt` lists all files with a `.txt` extension.
  
- **`?`**: Matches exactly one character.
  - Example: `ls file?.txt` matches `file1.txt`, `file2.txt`, etc., but not `file10.txt`.

- **`[...]`**: Matches any single character within the brackets.
  - Example: `ls file[1-3].txt` matches `file1.txt`, `file2.txt`, and `file3.txt`.

### Example:
```bash
# List all text files
ls *.txt

# List files with names like 'file1.txt', 'file2.txt', but not 'file10.txt'
ls file?.txt

# List files named 'file1.txt', 'file2.txt', and 'file3.txt'
ls file[1-3].txt
```

### Important Note:
Pathname expansion is performed before other types of expansion, which means that the shell replaces the wildcard with matching filenames before executing the command.

---

## 2. Brace Expansion

**Brace expansion** is a mechanism that allows you to generate arbitrary strings. It is particularly useful for creating lists of similar items, such as filenames, commands, or arguments.

### Syntax:
```bash
{string1,string2,...}
```

### Examples:
1. **Creating Files**:
   ```bash
   touch file{1..3}.txt
   ```
   This creates three files: `file1.txt`, `file2.txt`, and `file3.txt`.

2. **Multiple Commands**:
   ```bash
   echo {A,B,C}.txt
   ```
   This outputs `A.txt B.txt C.txt`.

3. **Combining Strings**:
   ```bash
   mkdir /tmp/{project1,project2,project3}
   ```
   This creates three directories: `/tmp/project1`, `/tmp/project2`, and `/tmp/project3`.

4. **Specifying Ranges**:
   ```bash
   echo {1..5}
   ```
   This outputs: `1 2 3 4 5`.

### Important Note:
Brace expansion does not involve any pattern matching; the strings inside braces are expanded as they are.

---

## 3. Variable Expansion

**Variable expansion** refers to the substitution of variable names with their values. This is a fundamental concept in shell scripting.

### Syntax:
```bash
$variable_name
```

### Examples:
1. **Basic Variable Expansion**:
   ```bash
   name="Alice"
   echo "Hello, $name!"
   ```
   Output: `Hello, Alice!`

2. **Using Variables in Commands**:
   ```bash
   path="/usr/local/bin"
   ls $path
   ```
   This lists the contents of the `/usr/local/bin` directory.

3. **Environment Variables**:
   Environment variables can be accessed using the same syntax.
   ```bash
   echo "Current user: $USER"
   echo "Home directory: $HOME"
   ```

4. **Default Values**:
   You can set default values for variables if they are not already set using `${variable:-default_value}`.
   ```bash
   echo "Database: ${DB_NAME:-my_database}"
   ```

### Important Note:
Variable expansion occurs after pathname and brace expansions, meaning variables are substituted after the shell has resolved file paths and brace lists.

---

## Summary of Shell Expansions

| Expansion Type      | Description                                                          | Example                                 |
|---------------------|----------------------------------------------------------------------|-----------------------------------------|
| Pathname Expansion   | Matches filenames and paths using wildcard characters                 | `ls *.txt`                              |
| Brace Expansion      | Generates strings based on defined patterns                          | `echo file{1..3}.txt`                  |
| Variable Expansion    | Substitutes variable names with their values                          | `echo "Hello, $name!"`                  |

---

## 4. Command Substitution

**Command substitution** allows the output of a command to be used as an argument in another command. This is useful for capturing the output of a command and using it directly.

### Syntax:
```bash
$(command)
```
or
```bash
`command`
```

### Examples:
1. **Using Command Substitution**:
   ```bash
   current_date=$(date)
   echo "Today's date is: $current_date"
   ```

2. **Using in Commands**:
   ```bash
   files_count=$(ls | wc -l)
   echo "There are $files_count files in the directory."
   ```

### Important Note:
- Command substitution is executed before other types of expansions, except for variable expansion.

---

## 5. Arithmetic Expansion

**Arithmetic expansion** allows you to perform arithmetic operations and use the results within commands. This is done using the `$((...))` syntax.

### Syntax:
```bash
$((expression))
```

### Examples:
1. **Basic Arithmetic**:
   ```bash
   result=$((3 + 5))
   echo "The result is: $result"
   ```

2. **Using Variables**:
   ```bash
   a=10
   b=5
   sum=$((a + b))
   echo "The sum is: $sum"
   ```

### Important Note:
- Arithmetic expansion can handle various operators like `+`, `-`, `*`, `/`, and `%`.

---

## 6. Parameter Expansion

**Parameter expansion** refers to the manipulation of variables, which can include getting the value of a variable, changing case, or modifying the variable's value.

### Syntax:
```bash
${parameter}
```

### Examples:
1. **Basic Parameter Expansion**:
   ```bash
   name="Bob"
   echo "Name is: ${name}"
   ```

2. **Substring Extraction**:
   ```bash
   text="Hello, World!"
   echo "${text:7:5}" # Outputs "World"
   ```

3. **Length of a Variable**:
   ```bash
   name="Alice"
   echo "Length of name: ${#name}" # Outputs 5
   ```

4. **Default Values**:
   You can also use default values with `${parameter:-default_value}`:
   ```bash
   echo "Value: ${my_var:-default}" # Outputs "Value: default" if my_var is unset
   ```

---

## Summary of Additional Shell Expansions

| Expansion Type          | Description                                                     | Example                                      |
|-------------------------|-----------------------------------------------------------------|----------------------------------------------|
| Command Substitution     | Uses the output of a command as an argument in another command | `current_date=$(date)`                      |
| Arithmetic Expansion     | Performs arithmetic calculations                               | `result=$((3 + 5))`                          |
| Parameter Expansion       | Manipulates variables and retrieves their values              | `echo "${name:0:3}"`                        |

---
