### Setting Date, Time, and Time Zone

#### Summary of Different Methods:

- **date**: Quick way to manually set date and time.
- **timedatectl**: Modern and recommended method with systemd.
- **hwclock**: Manages hardware clock.
- **ntpd**: Traditional NTP daemon for network time synchronization.
- **chrony**: Modern and efficient NTP client for time synchronization.

---

#### 1. Using the `date` Command (Old Method)

To set the date and time manually:
```bash
sudo date MMDDhhmm[[CC]YY][.ss]
```
Example: To set the date to June 9, 2023, and the time to 10:45:30 AM:
```bash
sudo date 060910452023.30
```

---

#### 2. Using the `timedatectl` Command

**Check Current Time and Date:**
```bash
timedatectl
timedatectl status
timedatectl show
```

---

**Set the Time and Date:**
```bash
sudo timedatectl set-time 14:30:00
sudo timedatectl set-time 2024-06-07
sudo timedatectl set-time '2023-06-09 10:45:30'
```

---

**List All Timezones:**
```bash
timedatectl list-timezones
```

---

**Set the Timezone:**
```bash
sudo timedatectl set-timezone Asia/Karachi
```

---

**Synchronize Time with NTP:**

Ensure that Network Time Protocol (NTP) synchronization is enabled:
```bash
sudo timedatectl set-ntp true
```
