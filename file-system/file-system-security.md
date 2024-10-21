### Managing File Security from the Command Line: Creating a Collaborative Directory

In this exercise, you will create a collaborative directory for the members of the **ateam** group, ensuring correct file permissions for shared access between users **andy** and **alice**. 

---

### **Outcomes**:
- A directory will be created with permissions that allow all members of the **ateam** group to access it.
- A file owned by **andy** will be created, with permissions that allow **alice** to modify it.

### **Before You Begin**:
Start your EC2 instance and log in as the `ec2-user` using SSH. Ensure that `ec2-user` has `sudo` access.

---

### **Steps**:

1. **Become the root user**:
   ```bash
   [ec2-user@ip-192-0-2-1 ~]$ sudo su -
   [root@ip-192-0-2-1 ~]#
   ```

2. **Create the group `ateam` and users `andy` and `alice`**:
   - Create the group:
     ```bash
     [root@ip-192-0-2-1 ~]# groupadd ateam
     ```
   - Add users `andy` and `alice` to the group:
     ```bash
     [root@ip-192-0-2-1 ~]# useradd -G ateam andy
     [root@ip-192-0-2-1 ~]# useradd -G ateam alice
     ```
   - Verify their group membership:
     ```bash
     [root@ip-192-0-2-1 ~]# id andy; id alice
     ```

3. **Create the directory `ateam-text`** in `/home`:
   ```bash
   [root@ip-192-0-2-1 ~]# mkdir /home/ateam-text
   ```

4. **Change group ownership of the directory** to the `ateam` group:
   ```bash
   [root@ip-192-0-2-1 ~]# chown :ateam /home/ateam-text
   ```

5. **Ensure group members can create and delete files in the directory**:
   ```bash
   [root@ip-192-0-2-1 ~]# chmod g+w /home/ateam-text
   ```

6. **Forbid others from accessing the directory** by setting restrictive permissions:
   ```bash
   [root@ip-192-0-2-1 ~]# chmod 770 /home/ateam-text
   ```
   - Verify the permissions:
     ```bash
     [root@ip-192-0-2-1 ~]$ ls -ld /home/ateam-text
     ```

7. **Switch to the user `andy`**:
   ```bash
   [root@ip-192-0-2-1 ~]# exit
   [ec2-user@ip-192-0-2-1 ~]$ sudo su - andy
   ```

8. **Navigate to the directory `/home/ateam-text`**:
   ```bash
   [andy@ip-192-0-2-1 ~]$ cd /home/ateam-text
   ```

9. **Create an empty file `andyfile3`**:
   ```bash
   [andy@ip-192-0-2-1 ateam-text]$ touch andyfile3
   ```

10. **Record the default user, group ownership, and permissions** of the new file:
    ```bash
    [andy@ip-192-0-2-1 ateam-text]$ ls -l andyfile3
    ```

11. **Change the group ownership of the file** to `ateam`:
    ```bash
    [andy@ip-192-0-2-1 ateam-text]$ chown :ateam andyfile3
    ```

12. **Exit `andy`'s shell and switch to the user `alice`**:
    ```bash
    [andy@ip-192-0-2-1 ateam-text]$ exit
    [ec2-user@ip-192-0-2-1 ~]$ sudo su - alice
    ```

13. **Navigate to the `/home/ateam-text` folder**:
    ```bash
    [alice@ip-192-0-2-1 ~]$ cd /home/ateam-text
    ```

14. **Determine `alice`'s privileges to access and modify `andyfile3`**:
    - Append the text `text` to `andyfile3`:
      ```bash
      [alice@ip-192-0-2-1 ateam-text]$ echo "text" >> andyfile3
      ```
    - Verify the file content:
      ```bash
      [alice@ip-192-0-2-1 ateam-text]$ cat andyfile3
      ```

If the permissions were set correctly, `alice` should be able to append to the file without any errors. Otherwise, you might see:
```bash
-bash: /home/ateam-text/andyfile3: Permission denied
```

---

### **Important Notes**:
- **I/O Redirection**:  
  The `>>` operator appends output to the file. If you accidentally use `>`, the file’s contents will be overwritten.

- **Using `vim` to modify files**:  
  Even if `alice` doesn't have write permission to the file, `vim` may still allow her to modify it because she can delete and recreate the file if she has write permission on the directory.

- **Permission Warning**:  
  If `alice` does not have write access to the file but does have write access to the directory, using `vim` with `:wq!` will change the file’s owner to `alice`.
