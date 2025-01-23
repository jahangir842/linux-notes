### NFS Server Installation

Follow these steps to set up an NFS server:

---

### Step 1: Install the NFS Kernel Server

To begin, install the NFS kernel server on the host machine:

1. Update the package repository index to ensure the latest package versions:
   ```bash
   sudo apt update
   ```
   for Rhel based:
   https://medium.com/@jackkimusa/linux-how-to-setup-nfs-server-on-rhel-8-1c0ba5783caf
   
3. Install the NFS kernel server:
   ```bash
   sudo apt install nfs-kernel-server -y
   ```

   Wait for the installation to complete.

2. Enable the NFS service:
   ```bash
   sudo systemctl enable --now nfs-server
   sudo systemctl start nfs-server
   ```
   
---

### Step 2: Configure the Shared Directory

After installing the NFS server, configure a directory to be shared with client machines:

1. Create the directory to share:
   ```bash
   sudo mkdir -p /mnt/
   ```

2. Change the directory's ownership to `nobody` and `nogroup`, making it accessible for public use:
   ```bash
   sudo chown nobody:nogroup /mnt/nfsdir
   ```

3. Set the directory's permissions to allow read, write, and execute access for everyone:
   ```bash
   sudo chmod 777 /mnt/mlflow
   ```

---

### Step 3: Configure Access in the Exports File

Grant client access to the NFS server by editing the `/etc/exports` file:

1. Open the exports file with a text editor (e.g., nano):
   ```bash
   sudo nano /etc/exports
   ```

2. Add a line for each client machine, specifying the directory and access permissions. For example:
   ```bash
   /mnt/mlflow clientIP(rw,sync,no_subtree_check)
   ```
   Replace `clientIP` with the IP address of the client machine.

3. To grant access to multiple clients in the same subnet (e.g 192.168.1.1-192.168.1.255), use the subnet IP:
   ```bash
   /mnt/mlflow 192.168.1.0/24(rw,sync,no_subtree_check)
   ```

   - **rw**: Allows clients to read and write to the shared directory.
   - **sync**: Ensures data is written to disk before responding to client requests.
   - **no_subtree_check**: Disables subtree checking, which can cause issues when files are renamed.

4. Save and exit the file.

---

### Step 4: Export the Shared Directory

After editing `/etc/exports`, export the shared directory and restart the NFS server:

1. Export all shared directories defined in the exports file:
   ```bash
   sudo exportfs -a
   ```

2. Restart the NFS kernel server to apply changes:
   ```bash
   sudo systemctl restart nfs-kernel-server
   ```

Your NFS server is now configured and ready to share directories with client machines.

---

## Client End Configurations

### Step 1: Install NFS Common

Install the NFS client utilities on each machine that will access the shared directory. Follow these steps:

1. Update the package index to ensure the latest versions are available:
   ```bash
   sudo apt update
   ```

2. Install the NFS common package:
   ```bash
   sudo apt install nfs-common -y
   ```

---

### Step 2: Create a Mount Point

A mount point is required on the client machine to access the shared directory from the server. Create one with the following command:

```bash
sudo mkdir -p /mnt/mlflow
```

---

### Step 3: Mount the Shared Directory

Mount the server's shared directory to the client machine's mount point using this command:

```bash
sudo mount host_IP:/mnt/nfsdir /mnt/nfsdir_client
```
For Example:

```bash
sudo mount 192.168.1.147:/mnt/mlflow /mnt/mlflow
```

Once mounted, the client can access the shared files through `/mnt/mlflow`.
