### What is a User?

A user account in Linux is a means to define security boundaries between various users and programs. Users are identified by **usernames** and, internally by the system, by **UIDs (User IDs)**. This distinction enables the system to manage permissions, processes, and file ownership securely.

#### Types of Users:
- **Superuser**:
  - Known as `root`, this account has **UID 0** and has complete access to the system, including the ability to manage files, processes, and system settings.
- **System Users**:
  - These accounts are used by background processes (daemons) for security. They do not require superuser privileges and generally don't allow human login.
- **Regular Users**:
  - These are everyday users of the system who have limited access, necessary for their work, without risking system integrity.

#### Key Concepts
- Each **process** (running program) is associated with a specific user, determining the files and directories accessible to that process.
- Every **file** has a particular user as its owner. File ownership defines who can access or modify the file, helping in enforcing access controls.

---

### Working with User Accounts

#### Displaying User Information:
- **Current user details**: The `id` command displays information about the currently logged-in user.
    ```bash
    $ id
    uid=1000(user01) gid=1000(user01) groups=1000(user01)
    ```
- **Details of another user**: Pass a username as an argument to the `id` command.
    ```bash
    $ id user02
    uid=1002(user02) gid=1001(user02) groups=1001(user02)
    ```

#### Viewing File and Directory Owners:
- To check the owner of a **file**:  
    ```bash
    $ ls -l file1
    -rw-rw-r--. 1 user01 user01 0 Feb 5 11:10 file1
    ```
  Here, the **third column** shows the username.
  
- To check the owner of a **directory**:
    ```bash
    $ ls -ld dir1
    drwxrwxr-x. 2 user01 user01 6 Feb 5 11:10 dir1
    ```

#### Viewing Process Information:
To view running processes along with the associated users:
- **Show processes from the current shell**:
    ```bash
    $ ps
    ```
- **Show all processes with a terminal**: 
    ```bash
    $ ps -a
    ```
- **Show user information alongside processes**:
    ```bash
    $ ps -au
    ```
    Example output:
    ```
    USER     PID %CPU %MEM   VSZ  RSS TTY   STAT START TIME COMMAND
    root     777 0.0  0.0 225752 1496 tty1  Ss+  11:03 0:00 /sbin/agetty
    user01   1207 0.0  0.2 234044 5104 pts/0 Ss   11:09 0:00 -bash
    ```

---

### The `/etc/passwd` File

User account information is stored in `/etc/passwd`, which contains several fields separated by colons (`:`). Here is an example line from `/etc/passwd`:
```bash
user01:x:1000:1000:User One:/home/user01:/bin/bash
```

#### Explanation of Fields:
1. **Username**: `user01`
2. **Password Placeholder**: The password used to be stored here but has moved to `/etc/shadow`. Hence, an `x` is present here.
3. **UID**: The unique identifier for this user (`1000`).
4. **GID**: The user's primary group ID (`1000`).
5. **User Info**: A description of the user (often the full name), here as `User One`.
6. **Home Directory**: The user's home directory (`/home/user01`).
7. **Default Shell**: The shell that runs when the user logs in (`/bin/bash`).

For system users that don't allow interactive logins, the shell could be `/sbin/nologin` to block login access.

---
### What is a Group?

In Linux, a **group** is a collection of users designed to manage shared access to files and other system resources. By associating a file or resource with a group, all members of that group can be granted access permissions, streamlining resource sharing between multiple users.

### Key Concepts of Groups

- **Group Names and GIDs**: Groups have names that make them easily identifiable by users and administrators. Internally, the system identifies groups by their **GID (Group ID)**, which is a unique numeric identifier.
- **Group Account Information**: The mapping of group names to GIDs is stored in the `/etc/group` file, which contains group definitions and memberships. Each line represents a group and is divided into four colon-separated fields.

#### Example `/etc/group` Entry:
```bash
group01:x:10000:user01,user02,user03
```
Here’s what each field means:
1. **Group Name**: `group01` is the name of the group.
2. **Password Field**: The `x` is a placeholder, and this field is no longer used (deprecated).
3. **GID**: `10000` is the unique Group ID number.
4. **Members**: `user01`, `user02`, and `user03` are users who are members of the group. These users have **supplementary group membership** in `group01`.

### Primary and Supplementary Groups

#### Primary Group:
- Every user is associated with a **primary group**, which is specified in the `/etc/passwd` file. This group is automatically assigned to any new files created by the user.
- By default, when a new user is created, a **User Private Group (UPG)** is also created with the same name as the username. This group becomes the user's **primary group** and simplifies file permission management.

#### Supplementary Groups:
- A user can also belong to one or more **supplementary groups**, which grant additional access to shared resources.
- These are listed in the `/etc/group` file and allow the user to access files and resources that are accessible to those groups.

For example, if `user01` belongs to the primary group `user01`, and has supplementary groups `wheel` and `webadmin`, they will have access to files readable by any of these groups.

### Viewing Group Information

To view the groups a user belongs to, you can use the `id` command:
```bash
$ id
uid=1003(user03) gid=1003(user03) groups=1003(user03),10(wheel),10000(group01)
```
In this example:
- The primary group of `user03` is `user03` (with GID 1003).
- The supplementary groups are `wheel` (GID 10) and `group01` (GID 10000).

### Managing Group Permissions

Groups allow administrators to easily manage permissions across multiple users. Rather than modifying file access for individual users, permissions can be adjusted for an entire group, ensuring that all members of that group have the same level of access.

### Summary of Group Management:
- **Primary group**: Automatically associated with a user's files.
- **Supplementary groups**: Allow users to gain access to additional files or resources.
- **GIDs and group names**: The system uses GIDs internally, while administrators use group names for easier management.

This concept helps ensure that users have appropriate access to files without requiring administrators to handle permissions on a per-user basis.
