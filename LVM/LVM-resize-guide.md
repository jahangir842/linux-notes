Sure, here is a complete guide to resizing an LVM partition to utilize additional space without losing data.

### Step-by-Step Guide to Resizing an LVM Partition

#### Step 1: Verify Current Partition and LVM Setup

1. **Check Current Disk Layout**:
   ```bash
   sudo fdisk -l /dev/sdX
   ```
   Replace `/dev/sdX` with your actual disk device name (e.g., `/dev/sda`).

2. **List Volume Groups**:
   ```bash
   sudo vgdisplay
   ```

3. **List Logical Volumes**:
   ```bash
   sudo lvdisplay
   ```

#### Step 2: Resize the Partition

1. **Backup Data**: Ensure you have a current backup of your data.

2. **Resize the Partition**:
   Use `fdisk` to resize the partition. This example assumes `/dev/sda` and partition `/dev/sda3`.

   ```bash
   sudo fdisk /dev/sda
   ```

   - Print the current partition table: Press `p`.
   - Note the start sector of the partition you want to resize (e.g., `/dev/sda3`).
   - Delete the existing partition: Press `d` and select the partition number (e.g., `3`).
   - Create a new partition: Press `n`.
     - Select `primary`.
     - Use the same partition number (e.g., `3`).
     - Enter the same start sector.
     - Use the default value for the end sector to utilize the full available space.
   - Write the changes: Press `w`.

3. **Rescan the Partition Table (skip it for now)**:    
   ```bash
   sudo partprobe /dev/sda
   ```

#### Step 3: Resize the Physical Volume 

1. **Check Filesystem Integrity (skip it for now)**:
   ```bash
   sudo umount /dev/sda3  # Unmount if mounted
   sudo fsck /dev/sda3
   ```

2. **Resize the Physical Volume**:
   ```bash
   sudo pvresize /dev/sda3
   ```

3. **Verify the Physical Volume Size**:
   ```bash
   sudo pvdisplay
   ```

#### Step 4: Extend the Logical Volume

1. **Extend the Logical Volume**:
   ```bash
   sudo lvextend -l +100%FREE /dev/ubuntu-vg/ubuntu-lv
   ```
   Replace `ubuntu-vg` with your volume group name and `ubuntu-lv` with your logical volume name. 

2. **Verify the Logical Volume Size**:
   ```bash
   sudo lvdisplay
   ```

#### Step 5: Resize the Filesystem

1. **Resize the Filesystem**:

   For ext4:
   ```bash
   sudo resize2fs /dev/ubuntu-vg/ubuntu-lv
   ```

   For XFS:
   ```bash
   sudo xfs_growfs /dev/ubuntu-vg/ubuntu-lv
   ```

#### Step 6: Verify the Resized Filesystem

1. **Verify the Filesystem Size**:
   ```bash
   df -h
   ```

### Example

Assume your disk is `/dev/sda`, partition to resize is `/dev/sda3`, volume group is `ubuntu-vg`, and logical volume is `ubuntu-lv`.

1. **Check Current Disk Layout**:
   ```bash
   sudo fdisk -l /dev/sda
   ```

2. **Resize the Partition**:
   ```bash
   sudo fdisk /dev/sda
   ```
   - Press `p`, note the start sector of `/dev/sda3`.
   - Press `d`, select `3`.
   - Press `n`, select `primary`, select `3`.
   - Enter the same start sector.
   - Use the default value for the end sector.
   - Press `w`.

3. **Rescan the Partition Table**:
   ```bash
   sudo partprobe /dev/sda
   ```

4. **Check Filesystem Integrity**:
   ```bash
   sudo umount /dev/sda3
   sudo fsck /dev/sda3
   ```

5. **Resize the Physical Volume**:
   ```bash
   sudo pvresize /dev/sda3
   ```

6. **Extend the Logical Volume**:
   ```bash
   sudo lvextend -l +100%FREE /dev/ubuntu-vg/ubuntu-lv
   ```

7. **Resize the Filesystem**:

   For ext4:
   ```bash
   sudo resize2fs /dev/ubuntu-vg/ubuntu-lv
   ```

   For XFS:
   ```bash
   sudo xfs_growfs /dev/ubuntu-vg/ubuntu-lv
   ```

8. **Verify the Filesystem Size**:
   ```bash
   df -h
   ```

By following these steps, you should be able to successfully resize your LVM partition and utilize the additional space without losing data.
