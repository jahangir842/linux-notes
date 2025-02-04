### **Group ID 5 (`tty`) in Linux**  

- **GID 5** is assigned to the `tty` (teletype) group in most Linux distributions.  
- It manages **terminal devices** (`/dev/tty*` and `/dev/pts/*`), which are used for user sessions.  
- When mounting `devpts`, we specify `gid=5` to ensure **pseudo-terminals (PTYs)** belong to the `tty` group.  
- This allows proper access control:
  - **Owner**: Full read/write access.
  - **tty group (GID 5)**: Write-only access.
  - **Others**: No access (for security).  
- It is essential for **SSH, tmux, screen, and terminal emulators** to function properly.  
- You can check GID 5 with:  
  ```sh
  getent group tty
  ```  
- If `gid=5` is missing, terminal sessions may not work correctly.
