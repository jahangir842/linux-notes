## `--add-host` in Docker

The `--add-host` flag in Docker is used to add custom host-to-IP mappings to the `/etc/hosts` file inside a container. This is useful for scenarios like DNS resolution, testing network configurations, and simulating different environments.

### Syntax
The general syntax for using the `--add-host` flag is:
```bash
docker run --add-host <hostname>:<ip_address> <image>
```

### Example
To add a custom host mapping of `myhost` to IP address `192.168.1.100` inside a container:
```bash
docker run --add-host myhost:192.168.1.100 ubuntu
```

### Use Cases
1. **Custom DNS Resolution:**
   - Simulate a DNS entry by adding a hostname and its corresponding IP address.
   ```bash
   docker run --add-host example.com:93.184.216.34 nginx
   ```

2. **Testing Environments:**
   - Redirect certain domain requests to specific IPs in testing environments.
   ```bash
   docker run --add-host testserver.local:10.0.0.1 myapp
   ```

3. **Development Setups:**
   - Ensure your container can reach services running on different hosts in local development.
   ```bash
   docker run --add-host db.local:172.17.0.2 myapp
   ```

### Practical Example

#### Step-by-Step Guide
1. **Create a Simple Web Server Container:**
   ```bash
   docker run -d --name webserver nginx
   ```

2. **Inspect the IP Address of the Container:**
   ```bash
   docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' webserver
   ```

3. **Run a New Container and Add Host Mapping:**
   Assuming the webserver's IP address is `172.17.0.2`.
   ```bash
   docker run -it --add-host mywebserver:172.17.0.2 ubuntu /bin/bash
   ```

4. **Check the /etc/hosts File Inside the New Container:**
   ```bash
   cat /etc/hosts
   ```
   You should see an entry like:
   ```plaintext
   172.17.0.2 mywebserver
   ```

5. **Verify Connectivity:**
   Inside the new container, you can verify connectivity to the `mywebserver`.
   ```bash
   curl http://mywebserver
   ```
   This should return the default Nginx web page if everything is set up correctly.

### Using `host.docker.internal`

`host.docker.internal` is a special DNS name that resolves to the internal IP address used by the host. It is particularly useful for accessing host services from a container. Starting with Docker Desktop 18.03+ for Mac and Windows, you can use this feature to simplify host access.

#### Adding `host.docker.internal`
You can use the `--add-host` flag to map `host.docker.internal` to the gateway IP address of the host.

```bash
docker run --add-host=host.docker.internal:host-gateway ubuntu
```

#### Use Case Example
1. **Run a Service on the Host:**
   Start a web server on your host machine, for example on port 8000.

2. **Run a Docker Container:**
   Map `host.docker.internal` to `host-gateway` to access the host service from inside the container.
   ```bash
   docker run -it --add-host=host.docker.internal:host-gateway ubuntu /bin/bash
   ```

3. **Access Host Service:**
   Inside the container, you can access the host's web server.
   ```bash
   curl http://host.docker.internal:8000
   ```

### Multiple Host Entries
You can add multiple host entries by repeating the `--add-host` flag.
```bash
docker run --add-host host1:192.168.1.1 --add-host host2:192.168.1.2 ubuntu
```

### Important Notes
- **Temporary Nature:** The host entries added using `--add-host` are temporary and only exist for the container's lifecycle. Once the container is stopped or removed, the entries are lost.
- **Network Modes:** The `--add-host` flag works with all Docker network modes, including bridge, host, and none.
- **Security Considerations:** Be cautious when adding host entries, especially in production environments, as it can potentially expose your container to malicious hosts or misconfigured DNS entries.

### Conclusion
The `--add-host` flag is a powerful tool for customizing the networking behavior of Docker containers. It allows for precise control over hostname resolution, making it invaluable in development, testing, and complex deployment scenarios. The ability to map `host.docker.internal` to `host-gateway` provides a convenient way to access host services from within a container, further enhancing Docker's flexibility.
