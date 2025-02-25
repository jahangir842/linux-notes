# Creating Files at Boot

At times, it is necessary to create specific files or directories at boot time. For instance, the `/tmp/.ICE-unix` directory is often needed for certain applications. This can be done by adding an entry in the `/etc/sysconfig/createfiles` configuration script. The format for this file is embedded in the comments of the default configuration file.

---

## Configuring the Sysklogd Script

The `sysklogd` script invokes the `syslogd` program as part of the System V initialization process. By default, `syslogd` writes a periodic timestamp mark to log files every 20 minutes. This behavior can be controlled using the `-m` option:

- To disable the periodic timestamp, set the `-m 0` option.
- To enable or modify the periodic timestamp, edit `/etc/sysconfig/rc.site` and set the `SYSKLOGD_PARMS` variable to the desired value.

Example to remove all parameters:
```bash
SYSKLOGD_PARMS=
```

For more configuration options, refer to the `syslogd` manual:
```bash
man syslogd
```

---

## The `rc.site` File

The optional `/etc/sysconfig/rc.site` file contains settings that apply to all System V boot scripts. It can also override values specified in individual configuration files within `/etc/sysconfig/` (such as `hostname`, `console`, and `clock`). If conflicting values exist, the script-specific files take precedence.

### Customization Options

- **Bootscript Selective Execution**: Enable interactive startup by setting:
  ```bash
  IPROMPT="yes"
  itime="3"
  ```
- **Skipping `udev settle` to Speed Up Boot**:
  ```bash
  OMIT_UDEV_SETTLE=y
  ```
- **Skipping `udev_retry settle` if unnecessary**:
  ```bash
  OMIT_UDEV_RETRY_SETTLE=y
  ```
- **Enable verbose output for filesystem checks (`fsck`)**:
  ```bash
  VERBOSE_FSCK=y
  ```
- **Skipping `fsck` on reboot**:
  ```bash
  FASTBOOT=y
  ```
- **Force filesystem check on next reboot**:
  ```bash
  /forcefsck
  ```
  Or use:
  ```bash
  /sbin/shutdown -F -r now
  ```
- **Prevent clearing `/tmp` at boot time**:
  ```bash
  SKIPTMPCLEAN=y
  ```
- **Adjusting shutdown timing**:
  - Reduce shutdown delay to zero:
    ```bash
    /sbin/shutdown -t0 -r now
    ```
  - Skip `sendsignals` script delay:
    ```bash
    KILLDELAY=0
    ```

These configurations allow for a more customized and optimized boot and shutdown process.

