# dpkg Commands

The `dpkg` command is a package manager for Debian-based systems, including Ubuntu. It is used to install, remove, and manage Debian packages. Below are some commonly used `dpkg` commands along with explanations and examples.

## Remove Unused Packages

To list all installed packages sorted by size, use the following command:

```sh
dpkg-query -W --showformat='${Installed-Size}\t${Package}\n' | sort -nr | less
```

This command helps identify the largest packages installed on the system, which can be useful for cleaning up unused packages to free up space.

## List Specific Packages

To list specific packages that match a certain pattern, use:

```sh
dpkg -l | grep package_name
```

Replace `package_name` with the name or part of the name of the package you are looking for. This command displays the status and details of packages that match the specified pattern.

## Configuration Files of a Package

To list all files installed by a package, including configuration files, use one of the following commands:

```sh
sudo dpkg --listfiles package-name
```

or

```sh
dpkg-query -L package-name
```

Replace `package-name` with the name of the package. These commands show all the files that were installed by the specified package.

## Export Package List

To generate a list of installed packages on the old PC, use the following command:

```sh
dpkg --get-selections > package_list.txt
```

This command exports the list of installed packages to a file named `package_list.txt`. You can then transfer this file to another system and install the same packages using:

```sh
sudo dpkg --set-selections < package_list.txt
sudo apt-get dselect-upgrade
```

## Other Useful dpkg Commands

### Install a Package

To install a package, use:

```sh
sudo dpkg -i package-file.deb
```

Replace `package-file.deb` with the path to the Debian package file you want to install.

### Remove a Package

To remove a package, use:

```sh
sudo dpkg -r package-name
```

Replace `package-name` with the name of the package you want to remove. This command removes the package but leaves its configuration files.

### Purge a Package

To remove a package along with its configuration files, use:

```sh
sudo dpkg --purge package-name
```

Replace `package-name` with the name of the package you want to purge.

### Repair a Broken Package

To attempt to repair a broken package installation, use:

```sh
sudo dpkg --configure -a
```

This command reconfigures all unpacked but unconfigured packages.

### List All Installed Packages

To list all installed packages, use:

```sh
dpkg -l
```

This command displays a list of all installed packages along with their details.

### Query Package Status

To query the status of a specific package, use:

```sh
dpkg-query -s package-name
```

Replace `package-name` with the name of the package. This command shows the status information of the specified package.

These `dpkg` commands are essential for managing packages on Debian-based systems, providing a robust way to install, query, and maintain software packages.
