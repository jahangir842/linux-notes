# `timedatectl`

The `timedatectl` command is a tool in Linux used to query and modify the system’s date, time, and timezone settings. It is part of the `systemd` suite and provides a simple interface for managing time-related configurations.

---

## **Key Features of `timedatectl`**
1. **Display current date and time settings.**
2. **Set the system clock and hardware clock.**
3. **Enable or disable time synchronization via NTP (Network Time Protocol).**
4. **Set or change the system's timezone.**
5. **Manage the system’s clock configuration.**

---

## **Syntax**
The basic syntax for `timedatectl` is:
```bash
timedatectl [OPTIONS] COMMAND [ARGUMENTS]
```

---

## **Common Commands and Their Usage**

### **1. Check the Current Date and Time**
To display the current system date, time, and timezone settings:
```bash
timedatectl
```
**Example Output:**
```
Local time: Fri 2025-01-08 14:33:24 UTC
Universal time: Fri 2025-01-08 14:33:24 UTC
RTC time: Fri 2025-01-08 14:33:23
Time zone: UTC (UTC, +0000)
System clock synchronized: yes
NTP service: active
RTC in local TZ: no
```

**Explanation:**
- `Local time`: Current local time on the system.
- `Universal time`: Time in UTC (Coordinated Universal Time).
- `RTC time`: The time stored in the hardware (Real-Time Clock).
- `Time zone`: The system’s timezone.
- `System clock synchronized`: Whether the system time is synchronized with an NTP server.
- `NTP service`: Indicates if the NTP service is active.
- `RTC in local TZ`: Whether the hardware clock is set to local time.

---

### **2. List Available Timezones**
To list all available timezones:
```bash
timedatectl list-timezones
```

**Example:**
```
Africa/Abidjan
Africa/Accra
America/New_York
Asia/Kolkata
```

---

### **3. Set the Timezone**
To change the timezone, use the `set-timezone` command:
```bash
timedatectl set-timezone <TIMEZONE>
```

**Example:**
```bash
timedatectl set-timezone Asia/Kolkata
```

---

### **4. Set the System Time**
To set the system’s date and time manually:
```bash
timedatectl set-time "YYYY-MM-DD HH:MM:SS"
```

**Example:**
```bash
timedatectl set-time "2025-01-08 15:00:00"
```

---

### **5. Enable/Disable NTP Synchronization**
- **Enable NTP synchronization:**
  ```bash
  timedatectl set-ntp true
  ```
- **Disable NTP synchronization:**
  ```bash
  timedatectl set-ntp false
  ```

---

### **6. Set the Hardware Clock**
- Sync the hardware clock (RTC) with the system clock:
  ```bash
  hwclock --systohc
  ```
- Sync the system clock with the hardware clock:
  ```bash
  hwclock --hctosys
  ```

---

### **7. Display the Status of NTP**
To check whether NTP is enabled or the service status:
```bash
timedatectl show-timesync
```

**Example Output:**
```
SystemNTPServiceRunning=yes
ServerName=0.arch.pool.ntp.org
PollInterval=32s
```

---

### **8. Check RTC Settings**
To view the current hardware clock (RTC) configuration:
```bash
timedatectl show --property=RTC
```

---

## **Examples in Practice**

### **Set and Verify the Timezone**
1. Set the timezone to New York:
   ```bash
   timedatectl set-timezone America/New_York
   ```
2. Verify:
   ```bash
   timedatectl
   ```

### **Enable NTP Synchronization**
1. Enable NTP:
   ```bash
   timedatectl set-ntp true
   ```
2. Check the status:
   ```bash
   timedatectl show-timesync
   ```

---

## **Configuration Files Involved**
- **`/etc/timezone`:** Stores the system's timezone.
- **`/etc/localtime`:** A symbolic link to the timezone file under `/usr/share/zoneinfo`.

---

## **Key Notes**
1. **Privileges:** Most `timedatectl` commands require superuser privileges (`sudo`).
2. **NTP Service:** On systems using `chronyd` or `systemd-timesyncd`, `timedatectl` interacts with those services for time synchronization.
3. **Persistent Changes:** Changes made via `timedatectl` are persistent across reboots.
4. **RTC Configuration:** It’s recommended to keep the hardware clock (RTC) in UTC to avoid issues during daylight saving time changes.

---

## **Troubleshooting**

### **1. Incorrect Time After Reboot**
- Ensure the hardware clock is synchronized:
  ```bash
  hwclock --systohc
  ```

### **2. NTP Not Working**
- Check if `systemd-timesyncd` or `chronyd` is running:
  ```bash
  systemctl status systemd-timesyncd
  ```
- Restart the service if necessary:
  ```bash
  sudo systemctl restart systemd-timesyncd
  ```

---

`timedatectl` is a versatile tool for managing time and date configurations in Linux systems. It simplifies tasks such as setting timezones, enabling NTP, and synchronizing system and hardware clocks.
