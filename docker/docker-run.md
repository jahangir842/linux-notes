### Detailed Notes on `docker run`

The `docker run` command is one of the most frequently used Docker commands. It creates and starts a new container from a specified image. This command provides a wide range of options to configure container behavior, set environment variables, manage volumes, and more.

#### Basic Syntax

```sh
docker run [OPTIONS] IMAGE [COMMAND] [ARG...]
```

- **`IMAGE`**: The name of the Docker image to use.
- **`COMMAND`**: (Optional) The command to run inside the container.
- **`ARG...`**: (Optional) Arguments for the command.

#### Common Options and Flags

1. **`-d` / `--detach`**
   - **Description**: Run the container in the background (detached mode).
   - **Example**: 
     ```sh
     docker run -d nginx
     ```

2. **`-it`**
   - **Description**: Combine `-i` (interactive) and `-t` (tty) to run the container in interactive mode with a terminal.
   - **Example**: 
     ```sh
     docker run -it ubuntu /bin/bash
     ```

3. **`--name`**
   - **Description**: Assign a name to the container.
   - **Example**: 
     ```sh
     docker run --name my_container nginx
     ```

4. **`-p` / `--publish`**
   - **Description**: Map a port on the host to a port in the container.
   - **Format**: `host_port:container_port`
   - **Example**: 
     ```sh
     docker run -p 8080:80 nginx
     ```

5. **`-v` / `--volume`**
   - **Description**: Bind mount a volume or directory from the host into the container.
   - **Format**: `host_path:container_path` or `volume_name:container_path`
   - **Example**: 
     ```sh
     docker run -v /host/data:/container/data nginx
     ```

6. **`--env` / `-e`**
   - **Description**: Set environment variables inside the container.
   - **Example**: 
     ```sh
     docker run -e MY_VAR=value nginx
     ```

7. **`--rm`**
   - **Description**: Automatically remove the container when it exits.
   - **Example**: 
     ```sh
     docker run --rm ubuntu
     ```

8. **`--network`**
   - **Description**: Connect the container to a specific network.
   - **Example**: 
     ```sh
     docker run --network my_network nginx
     ```

9. **`--restart`**
   - **Description**: Define the restart policy for the container.
   - **Options**: `no`, `always`, `unless-stopped`, `on-failure`
   - **Example**: 
     ```sh
     docker run --restart always nginx
     ```

10. **`--entrypoint`**
    - **Description**: Override the default entrypoint of the Docker image.
    - **Example**: 
      ```sh
      docker run --entrypoint /bin/sh nginx
      ```

11. **`--workdir` / `-w`**
    - **Description**: Set the working directory inside the container.
    - **Example**: 
      ```sh
      docker run -w /app -it ubuntu
      ```

12. **`--link`**
    - **Description**: Link to another container (deprecated in favor of networks).
    - **Example**: 
      ```sh
      docker run --link my_db:mysql nginx
      ```

13. **`--detach-keys`**
    - **Description**: Override the key sequence for detaching from a container.
    - **Example**: 
      ```sh
      docker run --detach-keys "ctrl-\\,ctrl-c" -it ubuntu
      ```

#### Examples

1. **Run a Container in Detached Mode**

   ```sh
   docker run -d --name my_nginx -p 8080:80 nginx
   ```

   This command runs an Nginx container in the background with port 8080 on the host mapped to port 80 in the container.

2. **Run a Container with Interactive Shell**

   ```sh
   docker run -it ubuntu /bin/bash
   ```

   This command runs an Ubuntu container interactively with a Bash shell.

3. **Run a Container with Mounted Volume**

   ```sh
   docker run -v /host/data:/container/data nginx
   ```

   This mounts `/host/data` on the host to `/container/data` in the container.

4. **Run a Container with Environment Variables**

   ```sh
   docker run -e ENV_VAR=value nginx
   ```

   This sets the environment variable `ENV_VAR` to `value` inside the container.

5. **Run a Container with Restart Policy**

   ```sh
   docker run --restart unless-stopped nginx
   ```

   This container will automatically restart unless stopped manually.

6. **Run a Container with Custom Entry Point**

   ```sh
   docker run --entrypoint /bin/sh nginx
   ```

   This overrides the default entry point of the Nginx image to `/bin/sh`.

7. **Run a Container with Network**

   ```sh
   docker run --network my_network nginx
   ```

   This connects the container to the specified Docker network.

#### Advanced Usage

1. **Run a Container with Resource Limits**

   ```sh
   docker run --memory="512m" --cpus="1.0" nginx
   ```

   This limits the container to 512 MB of memory and 1 CPU.

2. **Run a Container with Logs Streaming**

   ```sh
   docker run --name my_app -d nginx
   docker logs -f my_app
   ```

   Start the container and then stream logs using `docker logs -f`.

3. **Run a Container with Health Checks**

   You can configure health checks in your Dockerfile or Docker Compose file, but `docker run` doesn’t directly support health checks. Use Docker Compose for more advanced configurations.

### Docker `--rm` and `-it` Options Notes

#### `--rm`
- **Description**: Automatically removes the container after it exits.
- **Purpose**: Helps to clean up containers by removing them once they are done running. This avoids accumulating stopped containers on your system.
- **Example**:
  ```bash
  docker run --rm ubuntu echo "Hello, World!"
  ```
  In this example, the container will be deleted immediately after the `echo` command finishes executing.

#### `-it`
- **Description**: Combines `-i` and `-t` options.
- **Purpose**: Enables interactive mode and allocates a terminal.
  
  - **`-i` (interactive)**:
    - **Description**: Keeps STDIN open for interaction.
    - **Purpose**: Allows users to interact with the container via the command line or script.
    - **Example**:
      ```bash
      docker run -i ubuntu cat
      ```
      This keeps the input open so you can type into the `cat` command.

  - **`-t` (pseudo-TTY)**:
    - **Description**: Allocates a pseudo-TTY for terminal emulation.
    - **Purpose**: Provides a terminal interface, which is useful for running commands that require a terminal.
    - **Example**:
      ```bash
      docker run -t ubuntu
      ```
      This allocates a terminal for the container, which is necessary for interactive commands.

- **Combined Example**:
  ```bash
  docker run -it ubuntu bash
  ```
  - **`-it`**: Provides an interactive terminal session inside the Ubuntu container.
  - **`bash`**: Starts a bash shell in the container, allowing you to interact with the file system and execute commands.

### Practical Use Case
To run a command interactively and automatically clean up after execution:
```bash
docker run --rm -it amazon/aws-cli help
```
- **`--rm`**: Removes the container after `help` is executed.
- **`-it`**: Allows interactive access and terminal emulation for the `aws-cli` help command.

### Summary

The `docker run` command is a powerful tool for creating and managing Docker containers with a wide array of options to configure container behavior, manage storage, and set environment variables. Understanding these options allows for better control over containerized applications and their interactions with the host system and other containers.
