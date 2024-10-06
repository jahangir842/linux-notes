### Editing Text Files from the Shell Prompt with Vim

### Why Learn Vim?

- **Text-Based Configurations:** In Linux, configurations and settings are often stored in text-based files (INI, XML, YAML, etc.), making it essential to know how to edit them.
- **Universality:** `Vim` is nearly always installed on Linux servers, making it a reliable editor.
- **POSIX Compliance:** `vi` is part of the POSIX standard, and `vim` is an enhanced version of it.
- **Cross-Platform:** `Vim` is not only found on Linux but also pre-installed on systems like macOS.

---

### Starting Vim

- **Minimal Vim Installation:** Run `vi filename` to open a file when only the minimal version is installed.
- **Enhanced Vim Installation:** Run `vim filename` for more features and access to `vimtutor` and help files.
  
    Example to install Vim Enhanced:
    ```bash
    sudo yum -y install vim-enhanced
    ```

---

### Modes in Vim

Vim operates in multiple modes, each serving a different purpose:

1. **Command Mode (Default Mode):**
   - Used for navigation and text manipulation.
   - You can switch to other modes using keystrokes.

2. **Insert Mode (Text Editing):**
   - Enter this mode using the `i` key.
   - Exit by pressing `Esc`.
   
3. **Visual Mode (Text Selection):**
   - `v` for character selection.
   - `Shift+v` for line selection.
   - `Ctrl+v` for block selection.
   - Press the same key again to exit visual mode.
   
4. **Extended Command Mode (Writing and Quitting):**
   - Use `:` to enter extended command mode.
   - Examples:
     - `:w` - Write/save the file.
     - `:q` - Quit Vim.
     - `:wq` - Save and quit.
     - `:q!` - Quit without saving.

---

### Basic Vim Commands

- **Insert Mode:** `i`
- **Undo:** `u`
- **Delete Character:** `x`
- **Save File:** `:w`
- **Quit:** `:q`
- **Save and Quit:** `:wq`
- **Quit without Saving:** `:q!`

---

### Copying and Pasting (Yank and Put)

- **Yank:** Copy text using the `y` command.
- **Put:** Paste the yanked text using the `p` command.
- **Visual Mode:** Highlight the text using `v` (for characters), `Shift+v` (for lines), or `Ctrl+v` (for blocks), then use `y` to yank and `p` to put the text.

---

### Practical Exercise: Using `vimtutor`

You can practice Vim basics by using `vimtutor`, which is a built-in tutorial for learning Vim.
1. **Install vim-enhanced:**
   ```bash
   sudo yum -y install vim-enhanced
   ```
2. **Start vimtutor:**
   ```bash
   vimtutor
   ```
3. **Complete the lessons in vimtutor** to learn essential Vim commands such as moving between modes, saving, quitting, and deleting text.

---

### Visual Mode in Vim

- **Character Mode:** Press `v` to enter.
- **Line Mode:** Press `Shift+v` to highlight entire lines.
- **Block Mode:** Press `Ctrl+v` to select rectangular blocks.

---

### Advanced Vim Features

- **Vim-Enhanced:** Provides additional features like split-screen editing, color formatting, and syntax highlighting.
- **Aliases:** Regular users may have an alias set for `vi` to invoke `vim` automatically. However, root users do not get this alias.

---

### Tips for Beginners

- Always remember which mode you're in. If unsure, press `Esc` a few times to ensure you're in **command mode**.
- The minimum commands for editing are `i`, `Esc`, `:w`, and `:q!`.
- Practice frequently using `vimtutor` to become comfortable with the various modes and commands.

---

**Outcome:**  
By completing the `vimtutor`, you will gain basic competency in using the `vim` text editor and be equipped with knowledge of essential keystrokes for editing files from the shell prompt.
