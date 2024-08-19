## Install the snapd on Amazon Linux:

Even though the EPEL repository is not available for Amazon Linux 2023, you can still use Fedora repositories as alternatives because AL2023 and Fedora share a close relationship, and EPEL is a part of the Fedora Project.

Create a configuration file for the Fedora 36 repository:

   ```bash
   sudo touch /etc/yum.repos.d/fedora.repo
   sudo nano /etc/yum.repos.d/fedora.repo
   ```
And write the following code in it:

   ```bash
   [fedora]
   name=Fedora 36 - $basearch
   #baseurl=http://download.example/pub/fedora/linux/releases/36/Everything/$basearch/os/
   metalink=https://mirrors.fedoraproject.org/metalink?repo=fedora-36&arch=$basearch
   enabled=1
   metadata_expire=7d
   repo_gpgcheck=0
   type=rpm
   gpgcheck=1
   gpgkey=https://getfedora.org/static/fedora.gpg
          https://src.fedoraproject.org/rpms/fedora-repos/raw/f36/f/RPM-GPG-KEY-fedora-36-primary
   skip_if_unavailable=False
   ```
   Now install snapd with following command:
   
   ```bash
   sudo dnf install snapd
   ```

**Enable and start the `snapd.socket` systemd unit**:
   ```bash
   sudo systemctl enable --now snapd.socket
   ```

**Create a symbolic link for classic snap support**:
   ```bash
   sudo ln -s /var/lib/snapd/snap /snap
   ```

**Update the system paths**: 
   Restart your system to ensure the snap paths are updated correctly.

   ```bash
   sudo reboot
   ```
