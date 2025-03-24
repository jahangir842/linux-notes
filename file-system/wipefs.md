# `wipefs` Command in Linux  

## **Introduction**  
The `wipefs` command is used to erase filesystem signatures and metadata from a block device, such as a hard disk, SSD, USB drive, or SD card. It is useful when you need to completely remove traces of an old filesystem before creating a new one.  

## **Syntax**  
```sh
wipefs [options] <device>
```
Where `<device>` is the block device (e.g., `/dev/sdX`, `/dev/nvme0n1`, `/dev/mmcblk0`).  

---

## **Listing Filesystem Signatures**  
Before wiping, you can check for existing filesystem signatures on a device using:  
```sh
sudo wipefs --list /dev/sdX
```
or  
```sh
sudo wipefs -n /dev/sdX
```
**Example Output:**  
```
offset               type
------------------------------------------------
0x438                ext4   [filesystem]
0x1c2                dos    [partition table]
```
This output shows that an **ext4** filesystem and a **DOS partition table** exist on the device.

---

## **Wiping Filesystem Signatures**  
To remove all filesystem signatures:  
```sh
sudo wipefs --all /dev/sdX
```
or  
```sh
sudo wipefs -a /dev/sdX
```
This removes all filesystem metadata but **does not erase the actual data** on the disk.

---

## **Wiping Specific Signatures**  
If multiple signatures exist, you can remove a specific one using its offset:  
```sh
sudo wipefs --offset 0x438 --backup /dev/sdX
```
This will remove the ext4 signature at offset `0x438` and create a backup.

---

## **Creating a Backup Before Wiping**  
To store metadata in a backup file before wiping:  
```sh
sudo wipefs --backup -a /dev/sdX
```
This will save metadata in `/etc/lvm/backup/`.

---

## **Completely Erasing Data (Overwrite with Zeros)**  
The `wipefs` command only removes metadata, but if you need to securely erase all data, use:  
```sh
sudo dd if=/dev/zero of=/dev/sdX bs=1M status=progress
```
or  
```sh
sudo shred -n 3 -v /dev/sdX
```
These commands overwrite all data, making recovery difficult.

---

## **Use Cases**  
- Removing old filesystem metadata before creating a new partition.  
- Fixing issues where a disk is detected with multiple filesystem signatures.  
- Preparing a disk for encryption (e.g., LUKS).  
- Resetting USB drives, SD cards, or external hard drives before reuse.

---

## **Conclusion**  
The `wipefs` command is a quick and efficient way to clean filesystem signatures without affecting disk partitioning. However, for complete data removal, additional tools like `dd` or `shred` may be necessary.
