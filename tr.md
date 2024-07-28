### tr command in Linux
The `tr` command in Unix/Linux is a useful utility for translating or deleting characters from standard input and writing the result to standard output. It's commonly used in text processing and can handle simple substitutions, deletions, and complements.

### Syntax
```bash
tr [OPTION]... SET1 [SET2]
```

### Options and Usage

1. **Translating Characters**

   The basic use of `tr` involves translating characters in `SET1` to corresponding characters in `SET2`.

   ```bash
   tr 'SET1' 'SET2'
   ```

   Example: Replace lowercase letters with uppercase.

   ```bash
   echo "hello world" | tr 'a-z' 'A-Z'
   ```

   Output:
   ```
   HELLO WORLD
   ```

2. **Deleting Characters**

   The `-d` option deletes characters specified in `SET1`.

   ```bash
   tr -d 'SET1'
   ```

   Example: Delete all vowels from a string.

   ```bash
   echo "hello world" | tr -d 'aeiou'
   ```

   Output:
   ```
   hll wrld
   ```

3. **Squeezing Repeated Characters**

   The `-s` option replaces sequences of repeated characters with a single occurrence.

   ```bash
   tr -s 'SET1'
   ```

   Example: Squeeze repeated spaces into a single space.

   ```bash
   echo "hello    world" | tr -s ' '
   ```

   Output:
   ```
   hello world
   ```

4. **Complementing Sets**

   The `-c` option complements `SET1`, meaning it operates on all characters not in `SET1`.

   ```bash
   tr -c 'SET1' 'SET2'
   ```

   Example: Replace all characters except digits with `#`.

   ```bash
   echo "hello 123" | tr -c '0-9' '#'
   ```

   Output:
   ```
   #####123
   ```

### Character Classes

`tr` supports various predefined character classes. These are specified with `[:class:]`.

- **[:alnum:]**: All alphanumeric characters
- **[:alpha:]**: All alphabetic characters
- **[:digit:]**: All digits
- **[:lower:]**: All lowercase letters
- **[:upper:]**: All uppercase letters
- **[:space:]**: All whitespace characters

Example: Translate lowercase letters to uppercase using character classes.

```bash
echo "hello world" | tr '[:lower:]' '[:upper:]'
```

Output:
```
HELLO WORLD
```

### Examples

1. **Translating Specific Characters**

   ```bash
   echo "hello world" | tr 'lo' '12'
   ```

   Output:
   ```
   he12 w12rd
   ```

2. **Deleting Specific Characters**

   ```bash
   echo "hello world" | tr -d 'aeiou'
   ```

   Output:
   ```
   hll wrld
   ```

3. **Squeezing Multiple Spaces**

   ```bash
   echo "hello    world" | tr -s ' '
   ```

   Output:
   ```
   hello world
   ```

4. **Complement and Translate**

   ```bash
   echo "hello 123" | tr -c '0-9' '#'
   ```

   Output:
   ```
   #####123
   ```

5. **Using Character Classes**

   ```bash
   echo "hello WORLD 123" | tr '[:lower:]' '[:upper:]'
   ```

   Output:
   ```
   HELLO WORLD 123
   ```

### Practical Applications

1. **Remove Newline Characters**

   ```bash
   echo -e "line1\nline2" | tr -d '\n'
   ```

   Output:
   ```
   line1line2
   ```

2. **Replace Tabs with Spaces**

   ```bash
   echo -e "hello\tworld" | tr '\t' ' '
   ```

   Output:
   ```
   hello world
   ```

3. **Encrypt Text (Simple ROT13)**

   ```bash
   echo "hello" | tr 'a-zA-Z' 'n-za-mN-ZA-M'
   ```

   Output:
   ```
   uryyb
   ```

### Conclusion

The `tr` command is a versatile and powerful tool for text processing in Unix/Linux. It can be used to translate, delete, and squeeze characters, making it invaluable for manipulating text streams. Understanding how to leverage its options and character classes can significantly enhance your text processing capabilities in scripts and command-line operations.
