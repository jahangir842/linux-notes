# **Install PIP Packages Offline**

## Summary

- **Offline Installation:** Download packages on an internet-connected machine and transfer them to the target machine.
- **Local PyPI Server:** Set up a private PyPI server for package management within a local network.
- **Shared Network Directory:** Share downloaded packages over a network directory accessible to other machines.
- **Environment Repository:** Create and deploy a pre-configured environment with all necessary packages.

Choose the appropriate method based on your network configuration and administrative preferences.

---

## Step 1: Download the Packages

On a machine with internet access, download the required packages and their dependencies using:

```bash
pip download <package_name>
```

This command will download the specified package along with all its dependencies as `.whl` files or source archives.

---

## Step 2: Using a Shared Network Directory

Share the directory containing the downloaded packages over your network, making it accessible to the target machines.

---

## Step 3: Install Packages on the Client Machine

On the target machine, install the packages from the shared directory or the transferred files. You can create a `requirements.txt` file listing all the required packages.

Example command:

```bash
pip install --no-index --find-links=/mnt/repo/ -r requirements.txt
```

Alternatively, if you're accessing a shared directory over the network:

```bash
pip install --no-index --find-links=user@192.168.1.70:/home/user/packages -r requirements.txt
```

### Mounting the Shared Directory

You can mount the shared directory to make it easier to access:

```bash
sudo mkdir -p /mnt/abc
sudo mount -t cifs //192.168.1.70/Repo /mnt/abc/ -o username=user
```

You will be prompted to enter the password for the shared directory.

---

## Step 4: Installing Specific Packages

If you want to install a specific package, such as `pandas`, from the shared directory:

```bash
pip install --no-index --find-links=root@192.168.1.79:/new/ pandas==2.2.1
```

Or using a `requirements.txt` file:

```bash
pip install --no-index --find-links=root@192.168.1.79:/new/ -r requirements.txt
```

--- 

This approach allows you to efficiently manage and install Python packages across multiple machines without direct internet access.
