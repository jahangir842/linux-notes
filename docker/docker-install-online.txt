
********************************************************************************
			Docker Install on Offline Ubuntu
********************************************************************************
To install Docker on Ubuntu, you can follow these steps:

### Step 1: Update Your System
First, ensure your system is up to date:
```sh
sudo apt-get update
sudo apt-get upgrade
```

### Step 2: Install Required Packages
Install necessary packages that allow `apt` to use repositories over HTTPS:
```sh
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
```

### Step 3: Add Docker’s Official GPG Key
Add Docker's official GPG key to your system:
```sh
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
```

### Step 4: Set Up the Docker Repository
Add the Docker APT repository to your sources:
```sh
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

### Step 5: Update the Package Database
Update the package database with Docker packages from the newly added repo:
```sh
sudo apt-get update
```

### Step 6: Install Docker Engine
Install Docker:
```sh
sudo apt-get install docker-ce
```

### Step 7: Verify Docker Installation
Check the Docker version to verify that Docker is installed and running:
```sh
sudo docker --version
```

### Step 8: Manage Docker as a Non-root User (Optional)
By default, Docker requires root privileges. To avoid using `sudo` with every Docker command, add your user to the `docker` group:
```sh
sudo usermod -aG docker $USER
```
Then, log out and log back in for the changes to take effect. Verify you can run Docker commands without `sudo`:
```sh
docker --version
```

### Step 9: Test Docker Installation
Run the `hello-world` image to test your Docker installation:
```sh
docker run hello-world
```

If everything is set up correctly, you should see a message that says "Hello from Docker!"

### Summary of Commands
```sh
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce
sudo docker --version
sudo usermod -aG docker $USER
docker run hello-world
```

Following these steps will install Docker on your Ubuntu system, allowing you to start using Docker for containerization.
