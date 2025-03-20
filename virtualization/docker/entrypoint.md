In Docker, `ENTRYPOINT` is an instruction used in a Dockerfile to specify the command that will be run when a container starts. It defines the primary executable or script that the container should run as its main process.

### Key Points About `ENTRYPOINT`

1. **Main Process**: The `ENTRYPOINT` instruction sets the main process for the container. When the container starts, Docker will execute this command. This is the primary command that should be running in the container, and it will continue running until the container stops.

2. **Immutable Command**: Unlike `CMD`, which can be overridden at runtime with different arguments, `ENTRYPOINT` is generally used to define the main executable and is less flexible. However, you can still provide default arguments to `ENTRYPOINT`, which can be overridden if needed.

3. **Two Forms**:
   - **Exec Form**: `ENTRYPOINT ["executable", "param1", "param2"]`
     - Preferred form, as it avoids shell processing, making it more predictable.
   - **Shell Form**: `ENTRYPOINT command param1 param2`
     - This form runs the command in a shell (`/bin/sh -c`), which can be useful but less predictable and has additional overhead.

### Examples

**Exec Form Example:**

```Dockerfile
# Use Debian Bookworm as the base image
FROM debian:bookworm

# Copy the application into the container
COPY myapp /usr/local/bin/myapp

# Set the entry point to the application
ENTRYPOINT ["/usr/local/bin/myapp"]

# Provide default arguments (optional)
ENTRYPOINT ["/usr/local/bin/myapp", "--default-arg"]
```

In this example:
- `ENTRYPOINT ["/usr/local/bin/myapp"]` specifies that `/usr/local/bin/myapp` will be the main process of the container.
- If you use the shell form (`ENTRYPOINT /usr/local/bin/myapp`), it will execute the command using the shell, which can have different behavior.

**Shell Form Example:**

```Dockerfile
# Use Debian Bookworm as the base image
FROM debian:bookworm

# Set the entry point to a shell command
ENTRYPOINT /usr/local/bin/myapp
```

In this example:
- `ENTRYPOINT /usr/local/bin/myapp` will run `/usr/local/bin/myapp` using `/bin/sh -c`.

### How `ENTRYPOINT` Differs from `CMD`

- **`ENTRYPOINT`**: Specifies the main command that will always be executed when the container starts. It cannot be easily overridden.
- **`CMD`**: Provides default arguments for the `ENTRYPOINT` command. It can be overridden by providing new arguments when running the container.

**Combined Example:**

```Dockerfile
# Use Debian Bookworm as the base image
FROM debian:bookworm

# Set the entry point to the application
ENTRYPOINT ["/usr/local/bin/myapp"]

# Provide default arguments for the application
CMD ["--default-arg"]
```

In this combined example:
- `ENTRYPOINT ["/usr/local/bin/myapp"]` sets the main executable.
- `CMD ["--default-arg"]` provides default arguments that can be overridden when running the container.

### How to Remember `ENTRYPOINT`

1. **Main Command**: Think of `ENTRYPOINT` as setting up the main command or application that should run when the container starts.

2. **Fixed Behavior**: Unlike `CMD`, which can be changed at runtime, `ENTRYPOINT` is like setting a default program that will always be executed.

3. **Similar to Executable**: It’s similar to specifying the executable or script you want to run when starting a program on your computer.
