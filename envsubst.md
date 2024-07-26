`envsubst` is a utility in Unix-like systems that is used to substitute the value of environment variables into a template file. It’s commonly used in GitLab CI/CD pipelines to dynamically generate configuration files or scripts based on environment variables.

`envsubst` is a command-line utility used for variable substitution in shell scripts. It is part of the `gettext` package. To install `envsubst` on Ubuntu, you need to install the `gettext` package.

Here are the steps to install `envsubst`:

1. **Update the Package List:**

   Open a terminal and run:
   ```bash
   sudo apt update
   ```

2. **Install `gettext`:**

   Install the `gettext` package, which includes `envsubst`:
   ```bash
   sudo apt install gettext
   ```

3. **Verify the Installation:**

   Confirm that `envsubst` is installed by checking its version:
   ```bash
   envsubst --version
   ```

This will display the version of `envsubst` if the installation was successful.

### Example Usage of `envsubst`

To demonstrate the use of `envsubst`, let's consider a simple example:

1. **Create a Template File:**

   Create a file named `template.txt` with the following content:
   ```bash
   echo "Hello, \$USER! Welcome to \$HOSTNAME."
   ```

2. **Substitute Variables Using `envsubst`:**

   Use `envsubst` to replace the variables with their values:
   ```bash
   envsubst < template.txt > output.txt
   ```

3. **View the Output:**

   Check the content of `output.txt`:
   ```bash
   cat output.txt
   ```

   You should see the variables replaced with their actual values:
   ```bash
   Hello, your_username! Welcome to your_hostname.
   ```

That's it! You've successfully installed `envsubst` and used it to perform variable substitution in a file.


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
