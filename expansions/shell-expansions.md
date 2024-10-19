# Linux Shell Expansions

Here are detailed notes on **Matching File Names Using Path Name Expansion** in Linux, covering various expansions like path name expansion, brace expansion, and variable expansion. This summary aims to enhance your understanding and efficiency in using the Bash shell.

---

# Matching File Names Using Path Name Expansion

## Objectives
After completing this section, you should be able to efficiently run commands affecting many files by using the pattern matching features of the Bash shell.

## Command-line Expansions
The Bash shell provides multiple ways to expand a command line, including:

- **Pattern matching** (path name expansion)
- **Home directory expansion**
- **String expansion**
- **Variable substitution**

One of the most powerful features is **path name matching**, historically referred to as **globbing**. The Bash globbing feature (sometimes called “wildcards”) simplifies managing large numbers of files by allowing commands to operate on a focused set of files at once.

## Pattern Matching
Globbing is a shell command-parsing operation that expands a wildcard pattern into a list of matching path names. Metacharacters in the command line are replaced by the match list prior to command execution. Patterns that do not return matches will display the original pattern as literal text.

### Common Metacharacters and Pattern Classes

| Pattern          | Matches                                                 |
|------------------|--------------------------------------------------------|
| `*`              | Any string of zero or more characters                  |
| `?`              | Any single character                                    |
| `[abc...]`       | Any one character in the enclosed class (e.g., `a`, `b`, `c`) |
| `[!abc...]`      | Any one character not in the enclosed class            |
| `[^abc...]`      | Any one character not in the enclosed class            |
| `[[:alpha:]]`    | Any alphabetic character                                |
| `[[:lower:]]`    | Any lowercase character                                 |
| `[[:upper:]]`    | Any uppercase character                                 |
| `[[:alnum:]]`    | Any alphabetic character or digit                       |
| `[[:punct:]]`    | Any printable character not a space or alphanumeric    |
| `[[:digit:]]`    | Any single digit from 0 to 9                           |
| `[[:space:]]`    | Any single white space character (e.g., tabs, spaces)  |

### Examples of Pattern Matches

Assuming the following commands created some sample files:
```bash
[user@host ~]$ mkdir glob; cd glob
[user@host glob]$ touch alfa bravo charlie delta echo able baker cast dog easy
[user@host glob]$ ls
able alfa baker bravo cast charlie delta dog easy echo
```

Here are some examples using simple pattern matches with `*`, `?`, and character classes:
1. **Using the asterisk (`*`)**:
   ```bash
   [user@host glob]$ ls a*
   able alfa
   ```

2. **Using the asterisk in both ends**:
   ```bash
   [user@host glob]$ ls *a*
   able alfa baker bravo cast charlie delta easy
   ```

3. **Using character class**:
   ```bash
   [user@host glob]$ ls [ac]*
   able alfa cast charlie
   ```

4. **Using question marks (`?`)**:
   ```bash
   [user@host glob]$ ls ????
   able alfa cast easy echo
   ```

5. **Using multiple question marks**:
   ```bash
   [user@host glob]$ ls ?????
   baker bravo delta
   ```

## Tilde Expansion
The tilde character (`~`) represents the current user's home directory. If it precedes a string of characters other than a slash (`/`), the shell will interpret the string up to the slash as a username, replacing it with the path to that user's home directory. If no match is found, the literal tilde followed by the characters will be used.

### Examples of Tilde Expansion:
```bash
[user@host glob]$ echo ~root
/root
[user@host glob]$ echo ~user
/home/user
[user@host glob]$ echo ~/glob
/home/user/glob
```

## Brace Expansion
**Brace expansion** is used to generate discretionary strings of characters. Braces contain a comma-separated list of strings or a sequence expression. The result includes the text preceding or following the brace definition. Brace expansions may be nested.

### Examples of Brace Expansion:
1. **Simple comma-separated list**:
   ```bash
   [user@host glob]$ echo {Sunday,Monday,Tuesday,Wednesday}.log
   Sunday.log Monday.log Tuesday.log Wednesday.log
   ```

2. **Using numeric sequences**:
   ```bash
   [user@host glob]$ echo file{1..3}.txt
   file1.txt file2.txt file3.txt
   ```

3. **Using alphabetical sequences**:
   ```bash
   [user@host glob]$ echo file{a..c}.txt
   filea.txt fileb.txt filec.txt
   ```

4. **Combining expansions**:
   ```bash
   [user@host glob]$ echo file{a,b}{1,2}.txt
   filea1.txt filea2.txt fileb1.txt fileb2.txt
   ```

5. **Nested brace expansion**:
   ```bash
   [user@host glob]$ echo file{a{1,2},b,c}.txt
   filea1.txt filea2.txt fileb.txt filec.txt
   ```

6. **Creating directories**:
   ```bash
   [user@host glob]$ mkdir ../RHEL{6,7,8}
   ```

## Variable Expansion
A **variable** acts like a named container that can store a value in memory. Variables make it easy to access and modify stored data from the command line or within a shell script.

### Syntax for Assigning Variables:
```bash
[user@host ~]$ VARIABLENAME=value
```

### Examples of Variable Expansion:
1. **Basic Variable Expansion**:
   ```bash
   [user@host ~]$ USERNAME=operator
   [user@host ~]$ echo $USERNAME
   operator
   ```

2. **Using Curly Braces**:
   ```bash
   [user@host ~]$ echo ${USERNAME}
   operator
   ```

## Command Substitution
**Command substitution** allows the output of a command to replace the command itself on the command line. This is done by enclosing the command in parentheses preceded by a dollar sign (`$`).

### Examples of Command Substitution:
1. **Simple Command Substitution**:
   ```bash
   [user@host glob]$ echo Today is $(date +%A).
   Today is Wednesday.
   ```

2. **Complex Command Substitution**:
   ```bash
   [user@host glob]$ echo The time is $(date +%M) minutes past $(date +%l%p).
   The time is 26 minutes past 11AM.
   ```

---

## Conclusion
Understanding these expansions in the Bash shell allows for more efficient command execution and file management. By mastering path name expansion, brace expansion, variable expansion, and command substitution, you can enhance your proficiency in Linux command-line operations. If you have any questions or need further clarification, feel free to ask!
