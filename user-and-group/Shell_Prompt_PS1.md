### Shell Prompt (PS1) Notes

The **shell prompt** (`PS1`) in Unix-like systems defines how the command prompt looks in the terminal. It is a special environment variable that can be customized to display various information, such as the current user, host, working directory, time, etc.

The default prompt usually looks like this:
```
user@hostname:~$
```
This is the default prompt format in many Linux distributions, but it can be modified to display various useful information depending on the user’s needs.

### Components of PS1

The `PS1` variable is highly customizable and allows you to insert special **escape sequences** to display dynamic information. Here are some common components and their meanings:

#### Commonly Used Escape Sequences in PS1

1. **`\u`**: Current **username**.  
   Example: `user` if logged in as the user `user`.
   
2. **`\h`**: Hostname up to the first period (`.`).  
   Example: `myhost` if the hostname is `myhost.local`.

3. **`\H`**: Full **hostname**.  
   Example: `myhost.local` if the full hostname is `myhost.local`.

4. **`\w`**: **Current working directory**, with `~` representing the home directory.  
   Example: `/home/user` or `~/Documents`.

5. **`\W`**: Base name of the **current working directory** (only the last directory).  
   Example: `Documents` if you’re in `/home/user/Documents`.

6. **`\d`**: Current date in **"Weekday Month Date"** format.  
   Example: `Mon Feb 4`.

7. **`\t`**: **Current time** in 24-hour format (HH:MM:SS).  
   Example: `14:32:10`.

8. **`\A`**: **Current time** in 24-hour format (HH:MM).  
   Example: `14:32`.

9. **`\T`**: Current time in 12-hour format (HH:MM:SS).  
   Example: `2:32:10 PM`.

10. **`\@`**: Time in **12-hour format with AM/PM**.  
    Example: `2:32:10 PM`.

11. **`\#`**: The **command number** in the current session.  
    Example: `1` if it’s the first command you’ve executed.

12. **`\$`**: Displays `$` for a normal user and `#` for the **root** user.  
    This is used to distinguish between normal user prompts (`$`) and root user prompts (`#`).

13. **`\\`**: A literal backslash (`\`).  
    Useful when you want to display a backslash.

14. **`\$`**: Displays `#` if the user is root and `$` for non-root users.

15. **`\[` and `\]`**: Used to wrap non-printing characters.  
    For example, when setting colors, use these to ensure that the length of the prompt is calculated correctly by the shell.

### Customizing the Prompt

You can set the `PS1` variable in your shell’s configuration file (e.g., `~/.bashrc` for **Bash**) to customize the prompt.

#### Example 1: Basic Prompt Customization
```bash
PS1='\u@\h:\w\$ '
```
This prompt will show:
```
user@myhost:/home/user$
```

#### Example 2: Customizing with Color

You can also use color codes to make your prompt more visually distinct.

- **`\[\e[COLORm\]`**: This is the escape sequence for colors, where `COLOR` is the color code. Example: `\[\e[32m\]` for green text.
- **`\[\e[0m\]`**: Resets color back to default.

Example:
```bash
PS1='\[\e[32m\]\u\[\e[0m\]@\h:\[\e[34m\]\w\[\e[0m\]\$ '
```
This will show the username in green, the hostname in the default color, and the working directory in blue.

#### Example 3: Adding Git Branch to Prompt

You can even display the current **Git branch** if you're in a Git repository. For that, you can use a special function like this:

```bash
PS1='[\u@\h \W $(git branch 2>/dev/null | grep '\''\*'\'' | sed '\''s/\* //'\'' )]\$ '
```
This will show the current branch name in the prompt:
```
user@myhost ~/project (master)$
```

#### Example 4: Displaying Time in the Prompt
You can also include the current time in your prompt. Here’s an example of displaying the time along with the user, host, and directory:

```bash
PS1='[\t] \u@\h \w\$ '
```
This will display the current time:
```
[14:32:10] user@myhost ~/project$
```

### Modifying PS1 in Bash

To make your changes permanent, you can add your `PS1` modifications to the shell configuration file (`~/.bashrc` for Bash):

1. Open the file in a text editor:
   ```bash
   nano ~/.bashrc
   ```

2. Add your custom `PS1` line at the end of the file.

3. Apply the changes by running:
   ```bash
   source ~/.bashrc
   ```

### Conclusion

The `PS1` variable allows users to deeply customize their command prompt by incorporating dynamic elements such as the username, hostname, current directory, time, and even Git branch. It is a powerful way to personalize the command-line interface and improve the user experience.

### Tips:
- Use `\[` and `\]` when inserting colors to ensure that the shell counts the prompt correctly.
- You can also add other dynamic elements, such as system status, custom scripts, and more, to the prompt.
