Download Docker Compose Binary
*****************************************************************
https://github.com/docker/compose/releases

Find the latest stable release version and download the corresponding binary for Linux. 

*****************************************************************
You can do this using the following command:
   
   curl -L "https://github.com/docker/compose/releases/download/v2.27.1/docker-compose-$(uname -s)-$(uname -m)" -o docker-compose
   
   Replace `<version>` with the latest version number, e.g., `1.29.2`.
*****************************************************************
3. Make the binary executable:
   
   chmod +x docker-compose
   
*****************************************************************

Install Docker Compose on the Offline PC

Copy the `docker-compose` binary to a directory in your PATH, e.g., `/usr/local/bin/`:
   
   sudo cp /path/to/docker-compose /usr/local/bin/docker-compose
   

2. Verify the installation by checking the version:
   
   docker-compose --version
   
*****************************************************************
verify Docker Compose works with Docker by running:
   
   docker-compose --version
   

By following these steps, you should have Docker Compose installed and running on your offline Ubuntu PC.

