### **🔹 Backup Procedure for a Web Server**  

Backing up a web server is **critical** to ensure **data integrity, quick recovery, and minimal downtime** in case of failures. A proper backup plan should include **files, databases, and configurations** while ensuring automation and security.

---

## **1️⃣ Identify What to Backup**  
A web server typically consists of:  

📂 **Website Files** – HTML, PHP, JavaScript, images, CSS, etc.  
📂 **Web Server Configuration** – Nginx/Apache settings, Virtual Hosts, SSL certificates.  
📂 **Database** – MySQL, PostgreSQL, or any other database storing dynamic content.  
📂 **Logs & Custom Scripts** – Important logs, crontab jobs, custom scripts.  

---

## **2️⃣ Backup Strategy**  
A reliable web server backup strategy should follow the **3-2-1 Rule**:  

✔ **3 copies** (one primary + two backups)  
✔ **2 different storage types** (local & remote/cloud)  
✔ **1 offsite backup** (to prevent total loss in case of disaster)  

---

## **3️⃣ Backup Methods**  

### **🔸 1. File & Configuration Backup**
#### ✅ **Using `tar` (Manual Full Backup)**
```sh
tar -czvf /backup/webserver_backup_$(date +%F).tar.gz /var/www /etc/nginx /etc/apache2 /etc/letsencrypt
```
📌 *Creates a compressed backup of website files, Nginx/Apache configs, and SSL certificates.*  

#### ✅ **Using `rsync` (Efficient & Incremental)**
```sh
rsync -avz --delete /var/www /backup/
```
📌 *Syncs only changed files, making backups faster and saving space.*  

#### ✅ **Using `scp` to Copy to Remote Server**
```sh
scp /backup/webserver_backup.tar.gz user@remote-server:/remote-backups/
```
📌 *Sends the backup to another server for **offsite storage**.*  

---

### **🔸 2. Database Backup**
#### ✅ **Backup MySQL Database**
```sh
mysqldump -u root -p --all-databases > /backup/db_backup.sql
```
📌 *Exports all MySQL databases into a single `.sql` file.*  

#### ✅ **Backup PostgreSQL Database**
```sh
pg_dump -U postgres -F c mydatabase > /backup/db_backup.pgdump
```
📌 *Creates a PostgreSQL dump (`.pgdump`) for easy restoration.*  

#### ✅ **Automate with `cron` (Run Every Night at 2 AM)**
```sh
crontab -e
```
Add this line:
```sh
0 2 * * * mysqldump -u root -p mydatabase > /backup/db_backup_$(date +\%F).sql
```
📌 *Automatically backs up the database every night at `2 AM`.*  

---

### **🔸 3. Cloud & Remote Backups**
#### ✅ **AWS S3 Storage**
```sh
aws s3 cp /backup/webserver_backup.tar.gz s3://mybackup-bucket/
```
📌 *Uploads the backup to Amazon S3 for **long-term storage**.*  

#### ✅ **Google Drive (`rclone`)**
```sh
rclone copy /backup/webserver_backup.tar.gz remote:WebServerBackup/
```
📌 *Syncs backups to Google Drive or another cloud provider.*  

#### ✅ **Backup with `rsync` to Another Server**
```sh
rsync -avz /backup/ user@remote-server:/backups/
```
📌 *Sends backups to a remote Linux server for redundancy.*  

---

## **4️⃣ Full Automation with a Script**
Create a **script** (`backup.sh`) to handle everything automatically:  

```sh
#!/bin/bash

# Define variables
BACKUP_DIR="/backup"
DATE=$(date +%F)
DB_USER="root"
DB_PASS="yourpassword"
S3_BUCKET="s3://mybackup-bucket"

# Create backup directory if not exists
mkdir -p $BACKUP_DIR

# Backup website files
tar -czvf $BACKUP_DIR/webserver_files_$DATE.tar.gz /var/www /etc/nginx /etc/apache2 /etc/letsencrypt

# Backup MySQL database
mysqldump -u $DB_USER -p$DB_PASS --all-databases > $BACKUP_DIR/db_backup_$DATE.sql

# Sync to remote server
rsync -avz $BACKUP_DIR/ user@remote-server:/backups/

# Upload to AWS S3
aws s3 cp $BACKUP_DIR/webserver_files_$DATE.tar.gz $S3_BUCKET/
aws s3 cp $BACKUP_DIR/db_backup_$DATE.sql $S3_BUCKET/

# Clean up old backups (older than 7 days)
find $BACKUP_DIR -type f -mtime +7 -exec rm {} \;

echo "Backup completed successfully!"
```
📌 *This script:*  
✔ Backs up **website files & database**  
✔ Syncs backups to a **remote server & S3**  
✔ Deletes **old backups (>7 days)** to save space  

⏩ **Schedule with `cron` (Run Every Night at 1 AM)**:  
```sh
0 1 * * * /bin/bash /backup.sh
```
📌 *Ensures fully **automated backups** without manual effort.*  

---

## **5️⃣ Disaster Recovery Plan**
### **Restoring Backups**
#### 🔄 **Restore Website Files**
```sh
tar -xzvf webserver_backup.tar.gz -C /
```
📌 *Extracts the backup to the root directory, restoring files.*  

#### 🔄 **Restore MySQL Database**
```sh
mysql -u root -p < db_backup.sql
```
📌 *Restores the database from the `.sql` backup.*  

---

## **📌 Final Thoughts**
✅ **For small web servers:** `tar` + `rsync` + `cron`  
✅ **For cloud backups:** `AWS S3` + `rclone`  
✅ **For full automation:** Use **scripts & cron jobs**  

🚀 Let me know if you need a **custom backup script!** 🔥
