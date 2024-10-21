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

