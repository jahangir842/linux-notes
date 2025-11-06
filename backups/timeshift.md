# 🧭 **Timeshift Complete Reference Guide (CLI & GUI)**

Timeshift is a powerful Linux backup and restore utility designed to protect your **system files** (not personal data).
It creates snapshots (like Windows restore points) using **RSYNC** or **Btrfs** and lets you roll back your system safely.

> ⚠️ **Important:** Timeshift **snapshots must be stored on a Linux filesystem** (`ext4` or `btrfs`). NTFS, FAT32, or exFAT **cannot** be used as the snapshot destination. You can, however, include files from NTFS drives by mounting them and pointing Timeshift to the Linux partition as the backup location.

---

## 🧩 1. Installation

### On Ubuntu / Debian-based systems:

```bash
sudo apt update
sudo apt install timeshift -y
```

### On Fedora / RHEL:

```bash
sudo dnf install timeshift -y
```

### On Arch / Manjaro:

```bash
sudo pacman -S timeshift
```

---

## ⚙️ 2. Snapshot Types

Timeshift supports **two snapshot modes**:

| Type      | Description                            | Backend                       |
| --------- | -------------------------------------- | ----------------------------- |
| **RSYNC** | Uses rsync to copy files incrementally | Works on any Linux filesystem |
| **BTRFS** | Uses Btrfs subvolumes                  | Requires Btrfs filesystem     |

🧠 *Memorization Trick:*

> “Rsync is Reliable; Btrfs is Built-in.”
> If your root filesystem isn’t Btrfs, choose **RSYNC**.

---

## 🧭 3. Configuration

### Launch GUI:

```bash
sudo timeshift-gtk
```

This opens the Timeshift GUI for quick setup:

1. Choose snapshot type (RSYNC or BTRFS)
2. Select **snapshot device** (must be a Linux filesystem, e.g., ext4 or Btrfs)
3. Set schedule (hourly, daily, weekly, monthly)
4. Choose whether to include home directories

> ⚠️ **Tip:** If you have important files on an NTFS drive, mount it (e.g., `/mnt/sda1`) and include its contents in the snapshot by adding the path to the `include` list in the Timeshift JSON.

---

### Configure via CLI

List connected drives:

```bash
sudo timeshift --list-devices
```

Set default snapshot device:

```bash
sudo timeshift --snapshot-device /dev/sdb2
```

> ⚠️ Ensure `/dev/sdb2` is a Linux partition (`ext4` or `btrfs`). Timeshift cannot store snapshots on NTFS.

Check current configuration:

```bash
sudo timeshift --list
```

---

## 📸 4. Create Snapshots (CLI)

### Syntax:

```bash
sudo timeshift --create --comments "Your comment here" --tags <TAG> --snapshot-device /dev/sdXY
```

### Example:

```bash
sudo timeshift --create --comments "Before Kernel Update" --tags B --snapshot-device /dev/sdb2
```

### Valid `--tags` values:

| Tag | Meaning   | Use Case                                           |
| --- | --------- | -------------------------------------------------- |
| `O` | On-demand | GUI/manual snapshot (not always recognized in CLI) |
| `B` | Boot      | Before reboot                                      |
| `H` | Hourly    | Frequent snapshots                                 |
| `D` | Daily     | Regular backups                                    |
| `W` | Weekly    | Stable systems                                     |
| `M` | Monthly   | Long-term recovery points                          |

🧠 *Mnemonic:*

> “Boot Hourly Daily Weekly Monthly → BHDWM”
> *(Be Happy Doing Weekly Maintenance!)*

---

## 🔍 5. List Snapshots

```bash
sudo timeshift --list
```

Example Output:

```
Device : /dev/sdb2
Num     Name               Tags  Description
------------------------------------------------------------------------------
0    >  2025-11-06_14-57-16  D   Before Installing Nvidia Drivers
```

---

## 🔄 6. Restore a Snapshot

```bash
sudo timeshift --restore
```

Then follow the on-screen steps:

* Choose snapshot
* Confirm target device
* Proceed with restore (system reboots after completion)

---

## 🧹 7. Delete Old Snapshots

List snapshots:

```bash
sudo timeshift --list
```

Delete by name:

```bash
sudo timeshift --delete --snapshot '2025-11-06_14-57-16'
```

Or delete by tag:

```bash
sudo timeshift --delete --tags D
```

---

## ⏰ 8. Scheduling (Automatic Snapshots)

Timeshift integrates with **`cron`**.
You can edit schedules from GUI → “Schedule” tab, or manually via cron.

To edit cron job:

```bash
sudo crontab -e
```

Add something like:

```
0 2 * * * /usr/bin/timeshift --create --comments "Daily Backup" --tags D
```

---

## 💽 9. Changing Backup Device

If you want to use another drive (e.g., `/dev/sdb2`):

1. Mount the new drive (must be Linux):

   ```bash
   sudo mkdir -p /mnt/timeshift_backup
   sudo mount /dev/sdb2 /mnt/timeshift_backup
   ```
2. Update config:

   ```bash
   sudo timeshift --snapshot-device /dev/sdb2
   ```

> ⚠️ NTFS or FAT drives **cannot be used as the snapshot target**. Only Linux partitions (`ext4`/`btrfs`) are supported.

---

## 🧰 10. Config File

Path:

```
/etc/timeshift/timeshift.json
```

Sample excerpt:

```json
{
  "backup_device_uuid": "b2f5...93f",
  "snapshot_type": "RSYNC",
  "include_btrfs_home": false,
  "schedule_monthly": true,
  "schedule_weekly": false,
  "schedule_daily": true,
  "schedule_hourly": false
}
```

> ⚠️ Add any NTFS paths you want to include by **mounting them and adding the path to `"include"`**.

---

## 🚨 11. Excluding Files or Directories

Edit exclusion list:

```
/etc/timeshift/timeshift.json
```

Or GUI → Filters → Exclude paths

Example:

```
"exclude" : [
    "/home/user/**",
    "/root/**"
]
```

---

## 🧾 12. Verify Snapshot Integrity

List snapshots:

```bash
sudo timeshift --list
```

Then verify existence:

```bash
ls /run/timeshift/backup/timeshift/snapshots/
```

> ⚠️ Snapshots must exist on a Linux filesystem; otherwise integrity checks may fail.

---

## 🧭 13. Troubleshooting

| Issue                   | Fix                                                                 |
| ----------------------- | ------------------------------------------------------------------- |
| “Config file not found” | Run `sudo timeshift --setup` or GUI once to generate default config |
| “Not enough space”      | Delete old snapshots with `--delete`                                |
| “Unknown tag O”         | Use `B`, `D`, `W`, or `M` instead                                   |
| “Mount error”           | Ensure the snapshot target is a Linux partition (`ext4`/`btrfs`)    |

---

## 🌐 14. Comparing to Other Systems

| Cloud / OS       | Equivalent Feature                  |
| ---------------- | ----------------------------------- |
| **AWS**          | EBS Snapshots                       |
| **Azure**        | Managed Disk Snapshots              |
| **Huawei Cloud** | EVS Snapshots                       |
| **Open Source**  | `rsnapshot`, `borgbackup`, `restic` |

🧠 *Trick:*

> “Timeshift = Local Snapshot; Cloud Snapshots = Remote Mirror.”

---

## 🧠 Quick Summary

| Command                                             | Purpose                                        |
| --------------------------------------------------- | ---------------------------------------------- |
| `sudo timeshift --create --comments "..." --tags D` | Create snapshot                                |
| `sudo timeshift --list`                             | List snapshots                                 |
| `sudo timeshift --restore`                          | Restore snapshot                               |
| `sudo timeshift --delete --tags D`                  | Delete daily snapshots                         |
| `sudo timeshift --snapshot-device /dev/sdb2`        | Change backup device (must be Linux partition) |

---

This version emphasizes **Linux partition requirement** and guides NTFS users on how to safely include their files without using NTFS as the snapshot device.

---

