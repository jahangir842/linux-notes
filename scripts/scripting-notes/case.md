### **Understanding `case` in Linux (Bash Scripting)**

The `case` statement in Linux (specifically in bash scripting) is a control flow statement that allows pattern-based branching. It is similar to a `switch` statement in other programming languages and is used to simplify conditional structures when comparing a variable against multiple values or patterns.

---

### **Basic Syntax**

```bash
case variable in
    pattern1)
        commands
        ;;
    pattern2)
        commands
        ;;
    *)
        commands
        ;;
esac
```

#### Explanation:
1. **`variable`:** The variable or value being tested.
2. **`pattern`:** A value or a wildcard pattern to match against the variable.
3. **`commands`:** The commands to execute if the `variable` matches the pattern.
4. **`;;`:** Marks the end of the commands for a pattern.
5. **`*`:** A wildcard pattern that matches anything (default case).
6. **`esac`:** Ends the `case` statement.

---

### **Example 1: Basic Usage**
```bash
#!/bin/bash

echo "Enter a choice: start, stop, or restart"
read action

case $action in
    start)
        echo "Starting the service..."
        ;;
    stop)
        echo "Stopping the service..."
        ;;
    restart)
        echo "Restarting the service..."
        ;;
    *)
        echo "Invalid choice!"
        ;;
esac
```

#### Output:
- Input `start` → Outputs `Starting the service...`
- Input `invalid` → Outputs `Invalid choice!`

---

### **Pattern Matching**
The `case` statement supports patterns, including wildcards.

#### Example 2: Using Wildcards
```bash
#!/bin/bash

read -p "Enter a file extension (e.g., .sh, .txt, .jpg): " ext

case $ext in
    *.sh)
        echo "This is a shell script file."
        ;;
    *.txt)
        echo "This is a text file."
        ;;
    *.jpg|*.png)
        echo "This is an image file."
        ;;
    *)
        echo "Unknown file type."
        ;;
esac
```

---

### **Multiple Patterns**
You can use the `|` operator to combine multiple patterns.

#### Example 3: Combining Patterns
```bash
#!/bin/bash

read -p "Enter a day of the week: " day

case $day in
    Monday|Tuesday|Wednesday|Thursday|Friday)
        echo "It's a weekday."
        ;;
    Saturday|Sunday)
        echo "It's the weekend!"
        ;;
    *)
        echo "That's not a valid day."
        ;;
esac
```

---

### **Using Case for Numbers**
Case statements can also handle numerical patterns.

#### Example 4: Ranges with Numbers
```bash
#!/bin/bash

read -p "Enter a number (1-10): " num

case $num in
    [1-3])
        echo "You entered a number between 1 and 3."
        ;;
    [4-6])
        echo "You entered a number between 4 and 6."
        ;;
    [7-9]|10)
        echo "You entered a number between 7 and 10."
        ;;
    *)
        echo "Invalid number."
        ;;
esac
```

---

### **Default Case**
The `*` wildcard is used as the default case when none of the specified patterns match.

#### Example 5: Default Case
```bash
#!/bin/bash

read -p "Enter a command (start/stop/restart): " cmd

case $cmd in
    start)
        echo "Service starting..."
        ;;
    stop)
        echo "Service stopping..."
        ;;
    restart)
        echo "Service restarting..."
        ;;
    *)
        echo "Command not recognized."
        ;;
esac
```

---

### **Advantages of `case` Statement**
1. **Readable**: Simplifies complex if-else chains.
2. **Efficient**: Matches patterns directly without multiple condition evaluations.
3. **Flexible**: Allows wildcards, ranges, and multiple patterns.

---

### **Key Notes**
- Patterns must end with a `)` character.
- Each pattern can include multiple matching criteria separated by `|`.
- Always end a `case` block with `;;` for each pattern.
- Use `*` as the default case to handle unexpected input.

By using `case`, you can create cleaner and more maintainable scripts for handling user input or managing different conditions in Linux.
