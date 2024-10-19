### Detailed Notes on Variable Expansions in Shell Scripting

**Variable expansion** (also known as parameter expansion) is a crucial feature in shell scripting that allows the shell to process and manipulate the values of variables. This process is primarily used to substitute a variable's value into a string or command, with additional capabilities to modify or control how the substitution occurs.

#### Basic Variable Expansion

In its simplest form, variable expansion replaces a variable name with its corresponding value. In shell scripting, a variable is typically referenced by prefixing its name with a dollar sign (`$`).

```bash
NAME="John Doe"
echo "Hello, $NAME"
```

**Output:**
```
Hello, John Doe
```

#### Types of Variable Expansions

1. **Simple Expansion** (`$VAR` or `${VAR}`):
   - This is the most basic form of expansion. It simply replaces the variable with its value.
   - The braces `{}` are optional for simple expansion but are useful to avoid ambiguity in complex expressions.

   ```bash
   VAR="World"
   echo "Hello, ${VAR}!"
   ```

   **Output:**
   ```
   Hello, World!
   ```

2. **Default Value Expansion**:
   - **`${VAR:-default}`**: If `VAR` is unset or null, the expansion uses the `default` value. The original `VAR` remains unchanged.
   
   ```bash
   echo "${USERNAME:-guest}"
   ```

   If `USERNAME` is not set, it will print:
   ```
   guest
   ```

   - **`${VAR:=default}`**: Similar to the above, but it assigns the `default` value to the variable if it was unset or null.

   ```bash
   echo "${USERNAME:=guest}"
   echo "$USERNAME"
   ```

   If `USERNAME` is not set, it will print:
   ```
   guest
   guest
   ```

3. **Null Value Check**:
   - **`${VAR:+alternate}`**: If `VAR` is set (not null), the expansion results in `alternate`. If `VAR` is unset or null, it results in an empty string.

   ```bash
   VAR="data"
   echo "${VAR:+value}"
   ```

   **Output:**
   ```
   value
   ```

   If `VAR` is empty or unset:
   ```bash
   VAR=""
   echo "${VAR:+value}"
   ```

   **Output:**
   ```
   (nothing is printed)
   ```

4. **Error Handling in Expansions**:
   - **`${VAR:?error_message}`**: If `VAR` is unset or null, the shell prints the `error_message` to standard error and terminates the script.

   ```bash
   echo "${CONFIG_PATH:?Configuration path is not set}"
   ```

   If `CONFIG_PATH` is not set, the script will stop with:
   ```
   ./script.sh: CONFIG_PATH: Configuration path is not set
   ```

5. **Substring Expansion**:
   - **`${VAR:offset}`**: Expands to the substring of `VAR`, starting from the specified `offset`.
   
   ```bash
   VAR="Hello World"
   echo "${VAR:6}"
   ```

   **Output:**
   ```
   World
   ```

   - **`${VAR:offset:length}`**: Expands to the substring of `VAR` from `offset` for `length` characters.

   ```bash
   VAR="Hello World"
   echo "${VAR:0:5}"
   ```

   **Output:**
   ```
   Hello
   ```

6. **String Length**:
   - **`${#VAR}`**: Returns the length of the string contained in `VAR`.

   ```bash
   VAR="Bash"
   echo "${#VAR}"
   ```

   **Output:**
   ```
   4
   ```

7. **Removing Prefix/Suffix Patterns**:
   - **Remove Smallest Matching Prefix**: **`${VAR#pattern}`**
     Removes the smallest matching prefix from the variable.

     ```bash
     FILE="data.tar.gz"
     echo "${FILE#*.}"
     ```

     **Output:**
     ```
     tar.gz
     ```

   - **Remove Largest Matching Prefix**: **`${VAR##pattern}`**
     Removes the largest matching prefix.

     ```bash
     FILE="data.tar.gz"
     echo "${FILE##*.}"
     ```

     **Output:**
     ```
     gz
     ```

   - **Remove Smallest Matching Suffix**: **`${VAR%pattern}`**
     Removes the smallest matching suffix from the variable.

     ```bash
     FILE="data.tar.gz"
     echo "${FILE%.gz}"
     ```

     **Output:**
     ```
     data.tar
     ```

   - **Remove Largest Matching Suffix**: **`${VAR%%pattern}`**
     Removes the largest matching suffix.

     ```bash
     FILE="data.tar.gz"
     echo "${FILE%%.tar.gz}"
     ```

     **Output:**
     ```
     data
     ```

8. **Pattern Replacement**:
   - **`${VAR/pattern/replacement}`**: Replaces the first occurrence of `pattern` with `replacement`.

   ```bash
   VAR="Hello World"
   echo "${VAR/World/Everyone}"
   ```

   **Output:**
   ```
   Hello Everyone
   ```

   - **`${VAR//pattern/replacement}`**: Replaces all occurrences of `pattern` with `replacement`.

   ```bash
   VAR="Hello World World"
   echo "${VAR//World/Everyone}"
   ```

   **Output:**
   ```
   Hello Everyone Everyone
   ```

9. **Indirection**:
   - **`${!VAR}`**: Expands to the value of the variable whose name is the value of `VAR`.

   ```bash
   REF="MY_VAR"
   MY_VAR="This is the value of MY_VAR"
   echo "${!REF}"
   ```

   **Output:**
   ```
   This is the value of MY_VAR
   ```

10. **Array Variable Expansions**:
    - Arrays in shell scripting are variables that can store multiple values. Expanding an array retrieves its elements.
    - **`${ARRAY[@]}`**: Expands all the elements of the array.

    ```bash
    ARRAY=(apple orange banana)
    echo "${ARRAY[@]}"
    ```

    **Output:**
    ```
    apple orange banana
    ```

    - **`${#ARRAY[@]}`**: Returns the number of elements in the array.

    ```bash
    echo "${#ARRAY[@]}"
    ```

    **Output:**
    ```
    3
    ```

#### Use Cases for Variable Expansions

- **Default Value Setting**: Use default value expansions to provide fallback values in scripts.
  
  ```bash
  LOG_DIR=${LOG_DIR:-/var/log/app}
  ```

- **Substring Manipulation**: Useful in string manipulation tasks like extracting a file extension.

  ```bash
  FILENAME="report.pdf"
  EXT="${FILENAME##*.}"
  echo "Extension is $EXT"
  ```

- **Pattern Matching and Replacement**: Handle renaming or path manipulation by removing unwanted parts of strings.

  ```bash
  FILE_PATH="/home/user/docs/report.txt"
  BASE_NAME="${FILE_PATH##*/}"
  echo "Base file name is $BASE_NAME"
  ```

### Conclusion

Variable expansions provide powerful tools in shell scripting, enabling manipulation of variables, substitution, and pattern matching. Proper use of expansions ensures more efficient and robust scripts, especially when handling string manipulation, default values, and arrays.
