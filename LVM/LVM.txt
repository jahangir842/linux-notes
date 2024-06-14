To increase the size of an LVM logical volume on Ubuntu, you will need to extend both the physical volume and the logical volume, and then resize the filesystem. Here's a step-by-step guide on how to do this:

### Prerequisites
- Ensure you have root or sudo access.
- Ensure you have unallocated space available on the physical volume (`/dev/sda1` in this case).

### Steps to Increase LVM Size

1. **Check Available Space**:
    First, check the available space on your physical volume:

    ```sh
    sudo pvdisplay
    ```

    This will show the physical volumes and the free space available.

2. **Extend the Physical Volume**:
    If `/dev/sda1` has additional unallocated space, extend the physical volume:

    ```sh
    sudo pvresize /dev/sda1
    ```

    This command adjusts the size of the physical volume to use the additional space available on `/dev/sda1`.

3. **Check Logical Volumes**:
    List all the logical volumes to identify the one you want to extend:

    ```sh
    sudo lvdisplay
    ```

    Note the logical volume path (e.g., `/dev/ubuntu-vg/root`).

4. **Extend the Logical Volume**:
    Extend the logical volume by the desired amount. For example, to add 9GB to the logical volume:

    ```sh
    sudo lvextend -L +9G /dev/ubuntu-vg/root
    ```

    Replace `/dev/ubuntu-vg/root` with your logical volume path if different.

5. **Resize the Filesystem**:
    Finally, resize the filesystem to use the new space. For ext4 filesystems, you can use:

    ```sh
    sudo resize2fs /dev/ubuntu-vg/root
    ```

    For XFS filesystems, use:

    ```sh
    sudo xfs_growfs /dev/ubuntu-vg/root
    ```

### Detailed Example

1. **Check Available Space**:
    ```sh
    sudo pvdisplay
    ```

    Output example:
    ```
    --- Physical volume ---
    PV Name               /dev/sda1
    VG Name               ubuntu-vg
    PV Size               <19.00 GiB / not usable <2.00 MiB
    Allocatable           yes
    PE Size               4.00 MiB
    Total PE              4863
    Free PE               2303
    Allocated PE          2560
    ```

2. **Extend the Physical Volume**:
    ```sh
    sudo pvresize /dev/sda1
    ```

3. **Check Logical Volumes**:
    ```sh
    sudo lvdisplay
    ```

    Output example:
    ```
    --- Logical volume ---
    LV Path                /dev/ubuntu-vg/root
    LV Name                root
    VG Name                ubuntu-vg
    LV Size                10.00 GiB
    ```

4. **Extend the Logical Volume**:
    ```sh
    sudo lvextend -L +9G /dev/ubuntu-vg/root
    ```

    Output:
    ```
    Size of logical volume ubuntu-vg/root changed from 10.00 GiB (2560 extents) to 19.00 GiB (4863 extents).
    Logical volume ubuntu-vg/root successfully resized.
    ```

5. **Resize the Filesystem**:
    ```sh
    sudo resize2fs /dev/ubuntu-vg/root
    ```

    Output:
    ```
    resize2fs 1.45.5 (07-Jan-2020)
    Filesystem at /dev/ubuntu-vg/root is mounted on /; on-line resizing required
    old_desc_blocks = 2, new_desc_blocks = 3
    The filesystem on /dev/ubuntu-vg/root is now 4980736 (4k) blocks long.
    ```

### Verification
After completing these steps, verify the new size:

```sh
df -h /
```

This should show the increased size of the root filesystem.
