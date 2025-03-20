In a Dockerfile, `RUN` and `CMD` are two different instructions that serve distinct purposes. Here's an explanation of each and how they differ:

### `RUN`

- **Purpose**: The `RUN` instruction is used to execute commands in the container during the build process. It typically installs software packages or sets up the environment.
- **Layer Creation**: Each `RUN` instruction creates a new layer in the Docker image, which can impact the image size.
- **Usage**: Commonly used for updating package repositories, installing software, and configuring the container environment.

**Example:**

```Dockerfile
# Use Debian Bookworm as the base image
FROM debian:bookworm

# Update the package repository and install curl
RUN apt-get update && apt-get install -y curl

# Clean up to reduce image size
RUN apt-get clean && rm -rf /var/lib/apt/lists/*
```

### `CMD`

- **Purpose**: The `CMD` instruction sets the default command and/or arguments to be executed when a container starts. It can be overridden by specifying a different command when running the container.
- **Only One**: Only the last `CMD` instruction in the Dockerfile is used. If multiple `CMD` instructions are present, only the last one will take effect.
- **Usage**: Typically used to specify the main application or script to run when the container starts.

**Example:**

```Dockerfile
# Use Debian Bookworm as the base image
FROM debian:bookworm

# Copy the application script into the container
COPY myscript.sh /usr/local/bin/myscript.sh

# Set the default command to execute the script
CMD ["/usr/local/bin/myscript.sh"]
```

### Differences Between `RUN` and `CMD`

1. **Execution Time**:
   - `RUN`: Executes during the build process of the Docker image.
   - `CMD`: Executes when the container starts.

2. **Purpose**:
   - `RUN`: Used to install software and configure the image.
   - `CMD`: Used to set the default command to run when the container starts.

3. **Layer Creation**:
   - `RUN`: Creates a new layer in the image.
   - `CMD`: Does not create a new layer; it only sets metadata for the container.

### Combining `ENTRYPOINT` and `CMD`

You can use `ENTRYPOINT` and `CMD` together to create a more flexible container setup. `ENTRYPOINT` defines the executable, and `CMD` provides the default arguments, which can be overridden.

**Example:**

```Dockerfile
# Use Debian Bookworm as the base image
FROM debian:bookworm

# Copy the application script into the container
COPY myapp.sh /usr/local/bin/myapp.sh

# Set the entry point to the script
ENTRYPOINT ["/usr/local/bin/myapp.sh"]

# Provide default arguments
CMD ["--default-arg"]
```

In this example:
- `ENTRYPOINT` ensures that `/usr/local/bin/myapp.sh` is always executed.
- `CMD` provides default arguments (`--default-arg`), which can be overridden when the container is run.

**Running the Container with Overrides:**

```sh
docker run myimage
# Executes: /usr/local/bin/myapp.sh --default-arg

docker run myimage --another-arg
# Executes: /usr/local/bin/myapp.sh --another-arg
```

### Summary

- Use `RUN` to execute commands and configure the image during the build process.
- Use `CMD` to specify the default command and arguments to run when the container starts.
- Combine `ENTRYPOINT` and `CMD` to set a fixed entry point with flexible default arguments.
