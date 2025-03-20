### Docker Compose Detailed Notes

Docker Compose is a tool for defining and running multi-container Docker applications. With Compose, you can use a YAML file to configure your application’s services. Then, with a single command, you can create and start all the services from your configuration.

### Key Features

1. **Multi-Container Deployment**: Easily define and manage multiple containers within a single YAML file.
2. **Service Definitions**: Specify container configurations, such as build context, ports, volumes, and environment variables, for each service.
3. **Environment Management**: Simplify environment management by defining variables in the Compose file.
4. **Networking**: Automatically create and manage isolated networks for inter-container communication.
5. **Scaling**: Easily scale services up or down using the `docker-compose up --scale` command.
6. **Portable Environments**: Create reusable, version-controlled environment configurations.

### Basic Structure

A typical `docker-compose.yml` file consists of the following sections:

- `version`: Specifies the Compose file format version.
- `services`: Defines the individual services/containers that make up your application.
- `networks` (optional): Configures custom networks for your services.
- `volumes` (optional): Defines shared volumes accessible by multiple services.

### Example `docker-compose.yml`

```yaml
version: '3.8'

services:
  web:
    image: nginx
    ports:
      - "80:80"
    volumes:
      - ./html:/usr/share/nginx/html
    environment:
      - NGINX_HOST=localhost
      - NGINX_PORT=80

  db:
    image: postgres
    environment:
      POSTGRES_DB: example
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
    volumes:
      - db_data:/var/lib/postgresql/data

volumes:
  db_data:
```

### Detailed Sections

#### Services

**Service Definition**:
- **`image`**: Specifies the Docker image to use.
- **`build`**: Specifies the build context for creating an image.
- **`command`**: Overrides the default command for the container.
- **`ports`**: Maps host ports to container ports.
- **`volumes`**: Defines volume mounts.
- **`environment`**: Sets environment variables.
- **`depends_on`**: Specifies dependencies between services.

**Example**:
```yaml
services:
  web:
    build: .
    ports:
      - "5000:5000"
    volumes:
      - .:/code
    environment:
      FLASK_ENV: development
    depends_on:
      - db

  db:
    image: postgres
    environment:
      POSTGRES_DB: example
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
```

#### Volumes

Volumes persist data outside of containers and can be defined at the top level of the Compose file or within a service definition.

**Top-Level Volumes**:
```yaml
volumes:
  db_data:
```

**Service-Level Volumes**:
```yaml
services:
  db:
    volumes:
      - db_data:/var/lib/postgresql/data
```

#### Networks

Custom networks allow for better control over container communication.

**Example**:
```yaml
version: '3.8'

services:
  web:
    image: nginx
    networks:
      - front
      - back

  db:
    image: postgres
    networks:
      - back

networks:
  front:
  back:
```

### Commands

#### `docker-compose up`
Starts and runs your entire application.

```sh
docker-compose up
```

- **`-d`**: Runs containers in the background (detached mode).
- **`--build`**: Rebuilds images before starting containers.

#### `docker-compose down`
Stops and removes containers, networks, and volumes.

```sh
docker-compose down
```

- **`-v`**: Removes named volumes declared in the `volumes` section of the Compose file.

#### `docker-compose build`
Builds or rebuilds services.

```sh
docker-compose build
```

#### `docker-compose ps`
Lists containers.

```sh
docker-compose ps
```

#### `docker-compose logs`
Displays log output from services.

```sh
docker-compose logs
```

#### `docker-compose exec`
Executes a command in a running container.

```sh
docker-compose exec <service_name> <command>
```

### Advanced Features

#### Environment Variables

You can define environment variables in a `.env` file or directly in the Compose file.

**.env File**:
```plaintext
POSTGRES_USER=user
POSTGRES_PASSWORD=password
```

**docker-compose.yml**:
```yaml
version: '3.8'

services:
  db:
    image: postgres
    environment:
      - POSTGRES_USER=${POSTGRES_USER}
      - POSTGRES_PASSWORD=${POSTGRES_PASSWORD}
```

#### Extending Services

You can extend services using the `extends` keyword, which allows you to share common configurations.

**Common Configuration**:
```yaml
version: '3.8'

services:
  base:
    image: nginx
    environment:
      - BASE_VAR=base_value
```

**Extended Configuration**:
```yaml
version: '3.8'

services:
  web:
    extends:
      service: base
    environment:
      - WEB_VAR=web_value
```

#### Overriding Configuration

Use multiple Compose files to override configuration settings for different environments (e.g., development, testing, production).

```sh
docker-compose -f docker-compose.yml -f docker-compose.prod.yml up
```

### Best Practices

1. **Modular Configuration**: Use multiple Compose files to separate concerns and manage different environments.
2. **Version Control**: Keep your Compose files in version control to track changes and collaborate with your team.
3. **Use Named Volumes**: For persistent data, prefer named volumes over bind mounts for better portability and management.
4. **Limit Service Dependencies**: Minimize the use of `depends_on` to keep services loosely coupled.
5. **Environment-Specific Files**: Use environment variables and multiple Compose files to handle different deployment scenarios.

### Conclusion

Docker Compose simplifies the orchestration and management of multi-container applications. By leveraging its features, you can streamline your development workflow, ensure consistent environments, and manage complex applications with ease. Understanding the structure and commands of Docker Compose, along with best practices, will help you effectively utilize this powerful tool in your containerization strategy.
