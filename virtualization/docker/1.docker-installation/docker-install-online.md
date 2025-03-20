## Installing Docker on Offline Ubuntu

https://docs.docker.com/engine/install/ubuntu/

To set up Docker on Ubuntu, follow these steps:

#### Step 1: Update Your System
Make sure your system is current:
```sh
sudo apt-get update
sudo apt-get upgrade
```

#### Run the following command to uninstall all conflicting packages:

```
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
```

#### Step 2: Install Required Packages
Install essential packages that enable `apt` to work with HTTPS repositories:
```sh
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
```

#### Step 3: Add Docker’s Official GPG Key
Import Docker's GPG key:
```sh
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
```

#### Step 4: Set Up the Docker Repository
Add the Docker APT repository:
```sh
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

#### Step 5: Update the Package Database
Refresh your package database to include Docker packages:
```sh
sudo apt-get update
```

#### Step 6: Install Docker Engine
Now, install Docker:
```sh
sudo apt-get install docker-ce
```

#### Step 7: Verify the Installation
Check the installed Docker version:
```sh
sudo docker --version
```

#### Step 8: Manage Docker as a Non-root User (Optional)
To use Docker without `sudo`, add your user to the `docker` group:
```sh
sudo usermod -aG docker $USER
```
Log out and back in to apply changes. Verify it by running:
```sh
docker --version
```

#### Step 9: Test Docker
Run the `hello-world` image to confirm Docker is working:
```sh
docker run hello-world
```
You should see a message saying "Hello from Docker!" if the installation was successful.

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

By following these steps, you'll have Docker installed on your Ubuntu system, ready for containerization tasks.
