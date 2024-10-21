### Create the `login-history.sh` Script

Create a script file named `login-history.sh` with the following code:

```bash
#!/bin/bash

# Change to the home directory
cd /home

# Append a header, the current date, and login history to the log file
{
    echo "-----------------"
    date
    echo "-----------------"
    last -20  # Get the last 20 login entries
} >> /home/user/user_login_history  # Output to the login history log file
```

---

### Set Up Crontab

To run this script daily at 15:00 (3:00 PM), add the following entry to your crontab file:

```bash
00 15 * * * cd /home/user/ && bash login-history.sh
```

To edit your crontab, run:

```bash
crontab -e
```

The cron job will execute the script every day at 15:00 hours (3:00 PM), appending the latest login history to the `/home/user/user_login_history` file.

---

### Additional Considerations:

1. **Permissions:** Ensure the script is executable by setting the correct permissions:
   ```bash
   chmod +x /home/user/login-history.sh
   ```

2. **Log File Location:** The script currently assumes the log file is `/home/user/user_login_history`. If the location or user directory changes, adjust the path accordingly.

3. **Sudo Requirement:** If the `last` command requires sudo privileges, consider configuring password-less sudo for the user running this script to avoid interruptions in the cron job. You can do this by modifying the `/etc/sudoers` file, but be careful when doing so.


