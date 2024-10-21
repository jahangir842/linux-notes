### **Linux File System Permissions**

#### **Objectives**
- List file-system permissions on files and directories.
- Interpret the effect of permissions on access for users and groups.

---

### **Linux File System Permissions Overview**
- **Purpose**: File permissions control access to files in Linux.
- **Key features**: 
  - Simple and flexible.
  - Effective for most permission scenarios.
  
#### **User Categories for Permissions**
1. **User**: The individual who owns the file (typically, the creator).
2. **Group**: A single group that owns the file (usually the primary group of the file's owner).
3. **Others**: All other users who are not the file's owner or in the owning group.

#### **Precedence of Permissions**
- The most specific permissions override others:
  - **User** > **Group** > **Others**.

#### **Permissions Collaboration Example (Fig 6.1)**
- If users (e.g., `joshua` and `allison`) need to collaborate on files, the files should be associated with a shared group (`web`) to manage access through group permissions.

---

### **Permission Categories**
There are **three basic permissions** in Linux:
1. **Read (r)**:
   - Files: Allows viewing the file's contents.
   - Directories: Allows listing of file names within the directory.
   
2. **Write (w)**:
   - Files: Allows modifying or editing the file.
   - Directories: Allows creating or deleting files within the directory.
   
3. **Execute (x)**:
   - Files: Allows running the file as a program/command.
   - Directories: Allows setting the directory as the current working directory (with `cd`).

#### **Permission Effects Summary**

| **Permission** | **Effect on Files**                      | **Effect on Directories**                          |
|----------------|------------------------------------------|----------------------------------------------------|
| **Read (r)**   | File contents can be read.                | Directory contents (file names) can be listed.      |
| **Write (w)**  | File contents can be modified.            | Files within the directory can be created or deleted.|
| **Execute (x)**| File can be executed as a program/command.| Directory can become the current working directory. |

#### **Example Permission Behaviors on Directories**
- **Read + Execute**: Common for read-only directories (enables listing and accessing contents).
- **Only Read**: User can see file names but cannot access other file details (permissions, timestamps).
- **Only Execute**: User can access files if they know the exact name but cannot list the directory's contents.

#### **File Deletion Rules**
- Files can be deleted by users who:
  - Own the directory containing the file, or
  - Have write permissions on the directory, regardless of the file’s permissions.
- The **Sticky Bit** can modify this behavior, preventing file deletion by non-owners (explained later).

#### **Linux vs Windows File Permissions**
- **Permissions Inheritance**: 
  - Linux: Permissions on directories do **not** inherit automatically to subdirectories/files.
  - Windows (NTFS): Directory permissions may inherit to subdirectories/files.
- **Permission Equivalents**:
  - **Read on directory** (Linux) ≈ "List folder contents" (Windows).
  - **Write on directory** (Linux) ≈ "Modify" (Windows).
  - **Write + Sticky Bit on directory** (Linux) ≈ Prevents non-owners from deleting files, similar to Windows' **Write** permission.

---

### **Viewing File and Directory Permissions**
To view detailed permissions and ownership:
- **`ls -l`**: Lists detailed information about files and directories.
    - Example:
      ```bash
      [user@host~]$ ls -l test
      -rw-rw-r--. 1 student student 0 Feb 8 17:36 test
      ```
  - **File type**: The first character represents the file type:
    - `-` = regular file, `d` = directory, `l` = soft link, `b` and `c` = device files, `p` and `s` = special files.
  - **Permissions**: The next nine characters represent the permissions in sets of three:
    - **User (owner)**, **Group**, **Others** (e.g., `rw-` = read and write).
  - **Ownership**: After the link count, the first name shows the file owner, and the second shows the owning group.
  
- **Example Breakdown**:
  ```bash
  -rw-rw-r--. 1 student student 0 Feb 8 17:36 test
  ```
  - **Permissions**: User and group (`student`) have read and write (`rw-`), others have read (`r--`).
  - **User Permissions**: If the owner has different permissions than the group, the user permissions will apply.

---

### **Permission Examples**
Consider users with these group memberships:

| **User**      | **Group Memberships**                   |
|---------------|------------------------------------------|
| operator1     | operator1, consultant1                   |
| database1     | database1, consultant1                   |
| database2     | database2, operator2                     |
| contractor1   | contractor1, operator2                   |

Directory listing for `dir`:
```bash
[database1@host dir]$ ls -la
total 24
drwxrwxr-x. 2 database1 consultant1 4096 Apr 4 10:23 .
drwxr-xr-x. 10 root root 4096 Apr 1 17:34 ..
-rw-rw-r--. 1 operator1 operator1 1024 Apr 4 11:02 lfile1
-rw-r--rw-. 1 operator1 consultant1 3144 Apr 4 11:02 lfile2
-rw-rw-r--. 1 database1 consultant1 10234 Apr 4 10:14 rfile1
-rw-r-----. 1 database1 consultant1 2048 Apr 4 10:18 rfile2
```

#### **Example Effects**

| **Action**                            | **Explanation**                                                                 |
|---------------------------------------|---------------------------------------------------------------------------------|
| operator1 can modify `rfile1`         | Member of group `consultant1`, which has write access to `rfile1`.              |
| database1 can modify `rfile2`         | Owns `rfile2`, having both read and write permissions.                          |
| operator1 can read but not modify `rfile2` | Only has read permissions from `consultant1` group.                             |
| database2 and contractor1 have no access to `rfile2` | They fall under "others" permissions, which exclude read/write access.           |
| operator1 can modify `lfile1`         | Owns the file, having both read and write access.                               |
| database2 can modify `lfile2`         | "Others" permissions give write access, as database2 is not in the owning group. |
| database1 can delete `lfile1` and `lfile2` | Has write permission on the directory, which allows deleting files.             |


---

### Managing File System Permissions from the Command Line

#### Objectives:
After completing this section, you will be able to change permissions and ownership of files using command-line tools.

---

### Changing File and Directory Permissions

The command to modify file and directory permissions from the command line is `chmod`, short for **"change mode"**. Permissions (also known as mode) can be adjusted using two methods: the symbolic method and the numeric method.

#### **1. Changing Permissions with the Symbolic Method**
**Command Structure:**
```bash
chmod WhoWhatWhich file|directory
```
- **Who**:  
  - `u`: User (owner)  
  - `g`: Group  
  - `o`: Other (everyone else)  
  - `a`: All (user, group, and others)
- **What**:  
  - `+`: Add permission  
  - `-`: Remove permission  
  - `=`: Set exact permissions
- **Which**:  
  - `r`: Read  
  - `w`: Write  
  - `x`: Execute

**Examples:**
- To remove read and write permissions for the group and others on `file1`:
  ```bash
  chmod go-rw file1
  ```
- To add execute permission for all users on `file2`:
  ```bash
  chmod a+x file2
  ```

The `chmod` command also supports the `-R` option, which recursively applies permissions to all files and directories within a specified directory. Using a capital `X` allows execute permission to be applied only to directories and files that already have execute permissions set.

**Example:**
To recursively set read and write permissions for the group on `demodir`, and apply execute permissions only where execute is already set:
```bash
chmod -R g+rwX demodir
```

---

#### **2. Changing Permissions with the Numeric Method**

**Command Structure:**
```bash
chmod ### file|directory
```
Each digit represents permissions for user, group, and others. The digit is calculated by adding:
- `4` for read (`r`)
- `2` for write (`w`)
- `1` for execute (`x`)

**Example Calculations:**
- Permissions `-rwxr-x---`:
  - User (`rwx`): `4 + 2 + 1 = 7`
  - Group (`r-x`): `4 + 0 + 1 = 5`
  - Others (`---`): `0`
  - Numeric value: `750`
  
- Permissions `640`:
  - User (`rw-`): `4 + 2 = 6`
  - Group (`r--`): `4`
  - Others (`---`): `0`
  - Symbolic: `-rw-r-----`

**Examples:**
- To set read and write permissions for the user, and read permissions for the group and others on `samplefile`:
  ```bash
  chmod 644 samplefile
  ```
- To set read, write, and execute permissions for the user, read and execute permissions for the group, and no permissions for others on `sampledir`:
  ```bash
  chmod 750 sampledir
  ```

---

### Changing File and Directory User or Group Ownership

When a file is created, it is automatically owned by the user and the user’s primary group. However, ownership can be changed using the `chown` command.

#### **1. Changing Ownership with `chown`**
- **Change User Ownership:**
  ```bash
  chown user file
  ```
  Example:  
  ```bash
  chown student test_file
  ```

- **Change Group Ownership:**
  ```bash
  chown :group file
  ```
  Example:  
  ```bash
  chown :admins test_dir
  ```

- **Change Both User and Group Ownership:**
  ```bash
  chown user:group file
  ```
  Example:  
  ```bash
  chown visitor:guests test_dir
  ```

- **Recursively Change Ownership in a Directory:**
  Use the `-R` option to apply changes to all files and directories within a specified directory.
  ```bash
  chown -R user:group directory
  ```

#### **2. Changing Group Ownership with `chgrp`**
Alternatively, the `chgrp` command can be used to change only the group ownership of a file or directory:
```bash
chgrp group file
```

---

#### **Important Notes on `chown` Syntax:**
- **Use colon (`:`) syntax**: Always separate the user and group with a colon (`:`), not a period (`.`), as a period can be a valid character in a username, which might cause confusion.  
  For example, use:
  ```bash
  chown user:group file
  ```
  instead of:
  ```bash
  chown user.group file
  ```

---

This section covers managing default file permissions, using special permissions, and controlling access through the `umask` command and special permission settings like `setuid`, `setgid`, and the sticky bit.

### Key Concepts:

#### 1. **Default Permissions and `umask`:**
   - **Default Permissions**:
     - Directories start with permissions `0777` (`drwxrwxrwx`).
     - Regular files start with permissions `0666` (`-rw-rw-rw-`).
     - **Execute permission** on files must be added explicitly.
   - **umask**: A bitmask that removes certain permissions when a file or directory is created.
     - Example: `umask 002` removes the write permission for others (`rw-rw-r--` for files).
     - Use `umask` to view the current mask or to set a new one. The system’s default `umask` is typically `002` or `022`.

#### 2. **Special Permissions (`setuid`, `setgid`, sticky bit):**
   - **`setuid` (u+s)**: When set on executable files, the command runs with the file owner’s privileges.
   - **`setgid` (g+s)**: When set on a directory, newly created files inherit the directory's group owner.
   - **Sticky bit (o+t)**: When set on a directory, only the file owner (or root) can delete files, even if others have write permissions.

#### 3. **Example of Setting Special Permissions**:
   - Use the **symbolic** or **numeric** mode to set permissions:
     - Symbolic: `chmod g+s directory/`
     - Numeric: `chmod 2770 directory/` (where `2` is the `setgid` bit).

#### 4. **Setting and Adjusting Permissions**:
   - **Checking current `umask`**:
     ```bash
     umask
     ```
   - **Setting a new `umask`**:
     ```bash
     umask 027
     ```
     This example ensures files have `rw-r-----` permissions and directories have `rwxr-x---`.

#### 5. **Verifying and Modifying Permissions**:
   - After creating files or directories, use `ls -l` to verify the actual permissions.
   - Modify file permissions or group ownership as needed:
     ```bash
     chown :groupname file_or_directory
     chmod u+s, g+s, o+t file_or_directory
     ```

This section helps you securely manage default file permissions and control file access through special permission settings, enhancing collaborative work environments.
