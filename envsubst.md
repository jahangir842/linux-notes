### envsubst

`envsubst` is a utility in Unix-like systems that is used to substitute the value of environment variables into a template file. It’s commonly used in GitLab CI/CD pipelines to dynamically generate configuration files or scripts based on environment variables.

Here’s how it works:

1. **Template Creation**: You create a template file where certain values are placeholders that will be replaced with environment variable values. The placeholders are usually written in the format `${VARIABLE_NAME}`.

2. **Using `envsubst`**: During the pipeline execution, `envsubst` is used to replace these placeholders with actual values from the environment variables.

### Example

Imagine you have a configuration file template `config.template` with the following content:

```ini
[database]
host=${DB_HOST}
port=${DB_PORT}
```

In your `.gitlab-ci.yml`, you could use `envsubst` to generate the final configuration file:

```yaml
stages:
  - build

variables:
  DB_HOST: "localhost"
  DB_PORT: "5432"

build_job:
  stage: build
  script:
    - envsubst < config.template > config.conf
    - cat config.conf
```

In this example, `envsubst` reads `config.template`, replaces `${DB_HOST}` with `localhost` and `${DB_PORT}` with `5432`, and writes the result to `config.conf`. The `cat` command is then used to display the content of `config.conf`, which should look like this:

```ini
[database]
host=localhost
port=5432
```

This approach helps in dynamically configuring files based on the environment where the pipeline runs, making it versatile and adaptable to different environments or stages in your CI/CD process.
Sure, let's dive deeper into the usage of `envsubst` in the context of GitLab CI/CD pipelines, including more detailed examples and practical scenarios.

### Detailed Usage

`envsubst` is particularly useful for generating configuration files, scripts, or any other text files where certain values need to be dynamically set based on the environment. This is common in deployment pipelines where different environments (e.g., development, staging, production) require different configurations.

#### Example 1: Dynamic Configuration File Generation

Let's say you have a web application that requires different database configurations for different environments. You can create a template configuration file and use `envsubst` to substitute the environment-specific values.

**Template File (`config.template`):**

```ini
[database]
host=${DB_HOST}
port=${DB_PORT}
user=${DB_USER}
password=${DB_PASSWORD}

[server]
port=${SERVER_PORT}
```

**GitLab CI/CD Configuration (`.gitlab-ci.yml`):**

```yaml
stages:
  - build
  - deploy

variables:
  DB_HOST: "localhost"
  DB_PORT: "5432"
  DB_USER: "user"
  DB_PASSWORD: "password"
  SERVER_PORT: "8080"

build_job:
  stage: build
  script:
    - echo "Building the application..."
    # Simulate the build process
    - mkdir -p build
    - touch build/app

deploy_job:
  stage: deploy
  script:
    - echo "Generating configuration file..."
    - envsubst < config.template > config.conf
    - cat config.conf
    - echo "Deploying the application..."
    # Simulate deployment
    - cp build/app /path/to/deployment
    - echo "Application deployed successfully!"
  only:
    - main
```

**Explanation:**
- **Stages**: Define the stages of the pipeline (`build` and `deploy`).
- **Variables**: Define environment variables that will be used to substitute values in the template.
- **Build Job**: A placeholder for the build process.
- **Deploy Job**: Uses `envsubst` to replace placeholders in `config.template` with the actual environment variable values and generate `config.conf`. The configuration file is then displayed and the application is "deployed".

When the `deploy_job` runs, `config.conf` will contain:

```ini
[database]
host=localhost
port=5432
user=user
password=password

[server]
port=8080
```

#### Example 2: Conditional Configuration Based on Environment

You can also use `envsubst` to handle different configurations for different environments (e.g., development, staging, production) by setting environment-specific variables.

**Template File (`config.template`):**

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
data:
  DATABASE_HOST: ${DB_HOST}
  DATABASE_PORT: ${DB_PORT}
  LOG_LEVEL: ${LOG_LEVEL}
```

**GitLab CI/CD Configuration (`.gitlab-ci.yml`):**

```yaml
stages:
  - build
  - deploy

variables:
  LOG_LEVEL: "info"  # Default log level

build_job:
  stage: build
  script:
    - echo "Building the application..."
    - mkdir -p build
    - touch build/app

deploy_dev:
  stage: deploy
  variables:
    DB_HOST: "dev-db.example.com"
    DB_PORT: "5432"
  script:
    - echo "Deploying to development..."
    - envsubst < config.template > config-dev.yaml
    - cat config-dev.yaml
  only:
    - develop

deploy_prod:
  stage: deploy
  variables:
    DB_HOST: "prod-db.example.com"
    DB_PORT: "5432"
    LOG_LEVEL: "error"  # Override log level for production
  script:
    - echo "Deploying to production..."
    - envsubst < config.template > config-prod.yaml
    - cat config-prod.yaml
  only:
    - main
```

**Explanation:**
- **Stages**: Define the stages (`build` and `deploy`).
- **Variables**: Set default variables (e.g., `LOG_LEVEL`).
- **Build Job**: Placeholder for the build process.
- **Deploy Dev Job**: Specific deployment job for the development environment. It sets `DB_HOST` and `DB_PORT` for the development database and generates `config-dev.yaml`.
- **Deploy Prod Job**: Specific deployment job for the production environment. It sets `DB_HOST`, `DB_PORT`, and overrides `LOG_LEVEL` for production, generating `config-prod.yaml`.

When `deploy_dev` runs, `config-dev.yaml` will look like this:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
data:
  DATABASE_HOST: dev-db.example.com
  DATABASE_PORT: 5432
  LOG_LEVEL: info
```

When `deploy_prod` runs, `config-prod.yaml` will look like this:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
data:
  DATABASE_HOST: prod-db.example.com
  DATABASE_PORT: 5432
  LOG_LEVEL: error
```

### Benefits of Using `envsubst` in GitLab CI/CD

1. **Dynamic Configuration**: Easily generate configuration files based on the environment, reducing manual effort and errors.
2. **Environment-Specific Settings**: Handle different settings for different environments (e.g., development, staging, production) within the same pipeline.
3. **Flexibility**: Adjust configurations without changing the code or template files.
4. **Security**: Use environment variables to manage sensitive information, keeping it out of source control.

By leveraging `envsubst` in your GitLab CI/CD pipelines, you can create more robust, adaptable, and maintainable CI/CD workflows.
