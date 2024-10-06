# Nano Editor

## Introduction to Nano
**Nano** is a simple, user-friendly text editor for Unix-like systems. It is especially useful for users who prefer a straightforward interface for editing files from the command line.

### Opening a File
To open a file in Nano, use the following command:
```bash
nano filename.txt
```
If the file does not exist, Nano will create it.

## Basic Navigation
- **Arrow Keys**: Move the cursor up, down, left, and right.
- **`Ctrl + A`**: Move the cursor to the beginning of the line.
- **`Ctrl + E`**: Move the cursor to the end of the line.
- **`Ctrl + Y`**: Scroll up one page.
- **`Ctrl + V`**: Scroll down one page.

## Basic Editing
- **Typing**: Start typing to insert text at the cursor position.
- **Deleting**:
  - **`Backspace`**: Delete the character before the cursor.
  - **`Ctrl + D`**: Delete the character at the cursor.
- **Undo**:
  - **`Alt + U`**: Undo the last action.
  - **`Alt + E`**: Redo the last undone action.

## Copying and Pasting
1. **Select Text**:
   - **`Alt + A`**: Start selecting text (set mark).
   - Use arrow keys to highlight the desired text.
   
2. **Copy**:
   - **`Alt + Shift + 6`**: Copy the selected text to the cut buffer.
   
3. **Paste**:
   - Move the cursor to the desired location.
   - **`Ctrl + U`**: Paste the copied text at the cursor position.

## Cutting and Deleting
- **Cutting Text**:
  - **`Ctrl + K`**: Cut the entire line where the cursor is located.
- **Deleting Text**:
  - **`Ctrl + K`** (after selection): Cut the selected text.

## Searching and Replacing
- **Search**:
  - **`Ctrl + W`**: Search for a specific string. Type the search term and press **`Enter`**.
- **Replace**:
  - **`Ctrl + \`**: Search and replace. Enter the search term, press **`Enter`**, enter the replacement text, and press **`Enter`**.

## Saving and Exiting
- **Save Changes**:
  - **`Ctrl + O`**: Write out (save) the file. Press **`Enter`** to confirm.
- **Exit**:
  - **`Ctrl + X`**: Exit Nano. If there are unsaved changes, Nano will prompt you to save.

## Other Useful Shortcuts
- **Show Help**:
  - **`Ctrl + G`**: Display the help documentation.
- **Cutting and Pasting**:
  - **`Ctrl + K`**: Cut the current line or selected text.
  - **`Ctrl + U`**: Paste the text at the cursor position.
  
## Additional Tips
- **Undo and Redo**:
  - **`Alt + U`**: Undo the last action.
  - **`Alt + E`**: Redo the last undone action.
  
- **Selecting All Text**: 
  - To select all text in the file, press **`Alt + A`**, then move to the end of the file using the arrow keys.

- **Line Numbers**: 
  - To enable line numbers, use **`Ctrl + C`** to show the cursor position (which includes line number).

### Troubleshooting
If you encounter issues such as "cutbuffer is empty," make sure to:
- Properly select text before copying.
- Use the correct shortcut (like **`Alt + Shift + 6`** if **`Alt + 6`** doesn’t work).
  
## Summary of Key Commands

| Command              | Action                                    |
|---------------------|-------------------------------------------|
| `Ctrl + X`          | Exit Nano                                 |
| `Ctrl + O`          | Save changes                              |
| `Ctrl + W`          | Search for text                           |
| `Ctrl + \`          | Search and Replace for text               |
| `Ctrl + K`          | Cut current line or selected text         |
| `Ctrl + U`          | Paste text                                |
| `Alt + A`           | Start selecting text                      |
| `Alt + Shift + 6`   | Copy selected text to the buffer          |
| `Ctrl + Y`          | Scroll up one page                        |
| `Ctrl + V`          | Scroll down one page                      |
| `Alt + U`           | Undo last action                          |
| `Alt + E`           | Redo last undone action                   |
|---------------------|-------------------------------------------|
