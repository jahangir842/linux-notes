### **What is CryptPad?**

**CryptPad** is an open-source, privacy-focused online collaboration platform that allows users to create, edit, and share documents securely. Unlike traditional collaboration tools, CryptPad prioritizes data privacy by employing **end-to-end encryption**, ensuring that no one except the intended users can access the content.

---

### **Key Features of CryptPad**
1. **End-to-End Encryption**: 
   - All data is encrypted in the browser before being sent to the server. Only users with the decryption key (e.g., a shared link) can view or edit the content.
   
2. **Collaboration Tools**:
   - Offers multiple tools for teamwork, including:
     - Rich text documents.
     - Spreadsheets.
     - Kanban boards.
     - Polls.
     - Code editors.
     - Slides.

3. **Zero-Knowledge Hosting**:
   - The server cannot read or analyze user data because it only stores encrypted files.

4. **Real-Time Collaboration**:
   - Allows multiple users to work on the same document simultaneously with live updates.

5. **Anonymous Usage**:
   - Does not require an account for basic use. Users can create and share documents anonymously.

6. **Self-Hosting**:
   - CryptPad can be installed on your own server, giving full control over the data and infrastructure.

7. **Customizable Storage**:
   - Free and premium storage options are available on the hosted platform, or unlimited storage when self-hosted.

8. **Open Source**:
   - Being open-source, anyone can review, audit, and modify its code. The source code is available on GitHub.

---

### **Use Cases of CryptPad**
1. **Privacy-Conscious Collaboration**:
   - For individuals or teams needing secure workspaces, such as journalists, researchers, and businesses.

2. **Educational Purposes**:
   - Useful for schools and universities for privacy-compliant collaboration between students and teachers.

3. **Project Management**:
   - The Kanban tool makes CryptPad suitable for task and project tracking.

4. **Secure Communication**:
   - It provides a safe environment for sensitive discussions and document sharing.

---

### **Advantages**
- Full control over data when self-hosted.
- No ads or trackers.
- Works directly in the browser, no additional software needed.
- Strong commitment to privacy and security.

---

### **Disadvantages**
- Heavily reliant on browser performance, which might impact usability for very large files.
- Requires server resources and technical knowledge for self-hosting.
- Collaboration tools are less feature-rich compared to traditional office suites like Google Docs or Microsoft 365.

---

### **How Does CryptPad Compare to Alternatives?**

| Feature              | CryptPad                  | Google Docs               | Microsoft 365            |
|----------------------|---------------------------|---------------------------|---------------------------|
| **Privacy**          | End-to-end encryption    | Limited                   | Limited                   |
| **Open Source**      | Yes                       | No                        | No                        |
| **Self-Hosting**     | Yes                       | No                        | No                        |
| **Feature-Richness** | Moderate                 | High                      | High                      |
| **Cost**             | Free / Premium Options    | Free / Paid Plans         | Paid Plans                |

---

### **Where to Learn More?**
- Official website: [https://cryptpad.org](https://cryptpad.org)
- GitHub repository: [https://github.com/xwiki-labs/cryptpad](https://github.com/xwiki-labs/cryptpad)

CryptPad is an excellent tool for those who prioritize security and privacy while collaborating online.

CryptPad is an open-source, privacy-focused collaboration tool that provides secure, encrypted document collaboration and storage. Here’s how to install CryptPad on an Ubuntu system:

---

## Installation

### **Prerequisites**
1. **A server running Ubuntu** (20.04 or later recommended).
2. **Node.js** installed (v16+ required for CryptPad).
3. **Nginx** or another web server (optional but recommended for reverse proxy).
4. **A domain name** (optional, for HTTPS setup).
5. **MongoDB** installed (used as a database for CryptPad).
6. **Git** for downloading CryptPad's source code.

---

### **Step 1: Update System Packages**
```bash
sudo apt update && sudo apt upgrade -y
```

---

### **Step 2: Install Required Dependencies**
Install Node.js, MongoDB, Git, and other tools:
1. **Install Node.js**:
   ```bash
   curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
   sudo apt install -y nodejs
   ```

2. **Install MongoDB**:
   ```bash
   sudo apt install -y mongodb
   sudo systemctl enable mongodb
   sudo systemctl start mongodb
   ```

3. **Install Git**:
   ```bash
   sudo apt install -y git
   ```

---

### **Step 3: Clone the CryptPad Repository**
```bash
git clone https://github.com/xwiki-labs/cryptpad.git
cd cryptpad
```

---

### **Step 4: Install Node.js Dependencies**
Install `npm` dependencies:
```bash
npm install --production
```

---

### **Step 5: Configure CryptPad**
1. Copy the default configuration file:
   ```bash
   cp config/config.example.js config/config.js
   ```
2. Edit the configuration file:
   ```bash
   nano config/config.js
   ```
   Key configurations:
   - **bindAddress**: Set the address to bind CryptPad (default: `127.0.0.1`).
   - **port**: Choose the port CryptPad will run on (default: `3000`).
   - **mongodbURI**: Use `mongodb://localhost:27017/cryptpad` to point to your MongoDB instance.

---

### **Step 6: Start CryptPad**
Run CryptPad using:
```bash
node server.js
```

To run it in the background, consider using **`pm2`**:
1. Install `pm2` globally:
   ```bash
   sudo npm install -g pm2
   ```
2. Start CryptPad with `pm2`:
   ```bash
   pm2 start server.js --name cryptpad
   ```
3. Save the process for auto-restart:
   ```bash
   pm2 save
   pm2 startup
   ```

---

### **Step 7: Configure Nginx as a Reverse Proxy (Optional)**
1. Install Nginx:
   ```bash
   sudo apt install nginx
   ```
2. Create a new configuration file for your domain:
   ```bash
   sudo nano /etc/nginx/sites-available/cryptpad
   ```
   Add the following configuration:
   ```nginx
   server {
       listen 80;
       server_name yourdomain.com;

       location / {
           proxy_pass http://127.0.0.1:3000;
           proxy_http_version 1.1;
           proxy_set_header Upgrade $http_upgrade;
           proxy_set_header Connection 'upgrade';
           proxy_set_header Host $host;
           proxy_cache_bypass $http_upgrade;
       }
   }
   ```
3. Enable the configuration:
   ```bash
   sudo ln -s /etc/nginx/sites-available/cryptpad /etc/nginx/sites-enabled/
   sudo nginx -t
   sudo systemctl restart nginx
   ```

---

### **Step 8: Enable HTTPS with Certbot (Optional)**
1. Install Certbot:
   ```bash
   sudo apt install certbot python3-certbot-nginx
   ```
2. Obtain and install a certificate:
   ```bash
   sudo certbot --nginx -d yourdomain.com
   ```
3. Verify the certificate installation:
   ```bash
   sudo certbot renew --dry-run
   ```

---

### **Step 9: Access CryptPad**
- Open a browser and navigate to:
  - **`http://<your-server-ip>:3000`** (if using the default setup).
  - **`https://yourdomain.com`** (if using a domain and HTTPS).

---

### **Step 10: Regular Maintenance**
1. **Update CryptPad**:
   ```bash
   cd cryptpad
   git pull
   npm install --production
   ```
2. Restart the service:
   ```bash
   pm2 restart cryptpad
   ```

---

With this setup, CryptPad will be running securely on your Ubuntu server.
