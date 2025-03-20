### Docker Installation on Offline Ubuntu  

---

https://docs.docker.com/compose/install/

To install Docker Compose on Ubuntu, please follow these steps:

### Step 1: Download the Docker Compose Binary  
Obtain the latest stable release of Docker Compose with the following command:  
```bash  
sudo curl -L "https://github.com/docker/compose/releases/download/v2.17.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose  
```

### Step 2: Set Executable Permissions  
Grant executable permissions to the Docker Compose binary:  
```bash  
sudo chmod +x /usr/local/bin/docker-compose  
```

### Step 3: Verify the Installation  
Check the installation by verifying the version of Docker Compose:  
```bash  
docker-compose --version  
```

### Step 4: Optional - Create a Symbolic Link  
If `/usr/local/bin` is not included in your PATH, or if you prefer to use a different location, you can create a symbolic link as follows:  
```bash  
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose  
```

### Summary of Commands  
For quick reference, here are all the commands you'll need to run:  
```bash  
sudo curl -L "https://github.com/docker/compose/releases/download/v2.17.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose  
sudo chmod +x /usr/local/bin/docker-compose  
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose    
```

By completing these steps, you will successfully install Docker Compose on your Ubuntu system, enabling you to manage multi-container Docker applications effectively.
