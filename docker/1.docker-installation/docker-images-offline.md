# Using Docker Images on an Offline System  

This guide explains how to download Docker images on an online system, transfer them to an offline system, and set them up.  

## Step 1: Download Docker Images on an Online System  

1. Pull the required Docker image(s) using the `docker pull` command:  
   ```bash
   docker pull <image_name>
   ```  
   Replace `<image_name>` with the name of the desired image (e.g., `prom/prometheus`, `nginx`, etc.).

2. Save the Docker image(s) to tar files using the `docker save` command:  
   ```bash
   docker save -o <image_name>.tar <image_name>
   ```  
   Replace `<image_name>` with the image name (e.g., `prometheus.tar` for `prom/prometheus`).

## Step 2: Transfer Docker Images to the Offline System  

1. Use any file transfer method to copy the `.tar` files from the online system to the offline system. Common methods include:  
   - USB drives  
   - Secure Copy (`scp`)  
   - External storage  

   Example using `scp`:  
   ```bash
   scp <image_name>.tar user@offline-system-ip:/path/to/destination
   ```  

2. Place the `.tar` files in a directory accessible to Docker on the offline system.  

## Step 3: Load Docker Images on the Offline System  

1. Load the `.tar` file(s) into Docker on the offline system using the `docker load` command:  
   ```bash
   docker load -i <image_name>.tar
   ```  

2. Verify that the image is loaded:  
   ```bash
   docker images
   ```  

## Step 4: Run the Docker Container  

1. Run the Docker container using the `docker run` command. Replace the following placeholders with actual values:  
   ```bash
   docker run -d \
     -p <host_port>:<container_port> \
     --name <container_name> \
     <image_name>
   ```  
   - `<host_port>`: Port on the host machine to expose the container's service.  
   - `<container_port>`: Port used by the container.  
   - `<container_name>`: Name for the running container.  
   - `<image_name>`: Name of the Docker image.  

2. (Optional) If the container requires additional configuration files, mount them using the `-v` flag:  
   ```bash
   -v /path/to/config:/container/config/path
   ```  

## Example Commands Summary  

### On Online System:  
```bash
# Pull the Docker image
docker pull nginx

# Save the Docker image to a tar file
docker save -o nginx.tar nginx
```

### Transfer to Offline System:  
```bash
scp nginx.tar user@offline-system-ip:/path/to/destination
```

### On Offline System:  
```bash
# Load the Docker image
docker load -i nginx.tar

# Run the container
docker run -d -p 8080:80 --name webserver nginx
```

---
