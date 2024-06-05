
********************************************************************************
			Docker Install on Offline Ubuntu
********************************************************************************
Installing Docker on an offline system involves downloading the necessary packages on a system with internet access and then transferring them to the offline system. Here's a step-by-step guide:

### Step 1: Download Docker Packages on an Online System

1. **Update the package database**:
    ```bash
    sudo apt-get update
    ```

2. **Download the Docker CE packages**:
    - Create a directory to store the packages:
      ```bash
      mkdir docker-offline
      cd docker-offline
      ```
    - Download the Docker packages:
      ```bash
      apt-get download docker-ce docker-ce-cli containerd.io docker-compose-plugin
      ```

3. **Resolve dependencies**:
    - Use `apt-rdepends` to find the dependencies:
      ```bash
      apt-get install apt-rdepends
      apt-rdepends docker-ce docker-ce-cli containerd.io docker-compose-plugin | grep -v "^ " | xargs apt-get download
      ```
    - The `grep -v "^ "` command filters out indentation which represents already resolved dependencies.

### Step 2: Transfer the Packages to the Offline System

1. **Copy the packages**:
    - Use a USB drive, external hard drive, or any other method to copy the `docker-offline` directory to the offline system.

### Step 3: Install Docker on the Offline System

1. **Create a directory to store the packages**:
    ```bash
    mkdir docker-offline
    cd docker-offline
    ```

2. **Copy the packages from the USB drive or other media to the `docker-offline` directory**.

3. **Install the downloaded packages**:
    ```bash
    sudo dpkg -i *.deb
    ```

4. **Resolve dependencies**:
    - If there are missing dependencies, you can use the `dpkg` command again:
      ```bash
      sudo apt-get install -f
      ```

### Step 4: Verify the Installation

1. **Start Docker**:
    ```bash
    sudo systemctl start docker
    ```

2. **Enable Docker to start at boot**:
    ```bash
    sudo systemctl enable docker
    ```

3. **Verify that Docker is running**:
    ```bash
    sudo systemctl status docker
    ```

4. **Run a test Docker container**:
    ```bash
    sudo docker run hello-world
    ```

This method ensures you can install Docker on an offline system by preparing all necessary files on a system with internet access and then transferring them.

