### Environment Variables in Linux

Environment variables are dynamic values that affect the processes or programs on a computer. They provide a way to influence the behavior of software on the system. Here's a detailed overview of environment variables in Linux:

#### 1. What are Environment Variables?

Environment variables are key-value pairs that can affect the way running processes behave on a computer. They are used by the operating system and applications to store configuration settings.

#### 2. Common Environment Variables

- **PATH**: Specifies a list of directories where the shell looks for executable files.
  - Example: `/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin`
- **HOME**: Represents the current user's home directory.
  - Example: `/home/username`
- **USER**: Contains the name of the current user.
  - Example: `username`
- **SHELL**: Indicates the path of the current user's shell.
  - Example: `/bin/bash`
- **PWD**: Stores the current working directory.
  - Example: `/home/username/project`
- **LANG**: Determines the locale and character encoding settings.
  - Example: `en_US.UTF-8`
- **EDITOR**: Specifies the default text editor.
  - Example: `vim`
- **LOGNAME**: Shows the login name of the user.
  - Example: `username`
- **HOSTNAME**: Displays the name of the host system.
  - Example: `mycomputer.local`

#### 3. Viewing Environment Variables

To view environment variables, you can use the following commands:

- `printenv`: Displays all environment variables.
- `env`: Shows all environment variables.
- `echo $VARIABLE_NAME`: Prints the value of a specific variable.

Example:
```bash
echo $PATH
```

#### 4. Setting Environment Variables

Environment variables can be set temporarily or permanently.

- **Temporarily (for the current session):**
  ```bash
  VARIABLE_NAME=value
  export VARIABLE_NAME
  ```

  Example:
  ```bash
  export MY_VAR="Hello World"
  ```

- **Permanently (for all sessions):**
  Add the export command to the `.bashrc`, `.bash_profile`, or `.profile` file in the user's home directory.

  Example:
  ```bash
  echo 'export MY_VAR="Hello World"' >> ~/.bashrc
  source ~/.bashrc
  ```

#### 5. Removing Environment Variables

To unset an environment variable, use the `unset` command:

Example:
```bash
unset MY_VAR
```

#### 6. Special Files for Environment Variables

- **/etc/environment**: Used to set global environment variables for all users.
  Example:
  ```bash
  PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
  ```

- **/etc/profile**: Script executed by Bourne shell and Bourne-compatible shells (like Bash) for login shells.
- **~/.bashrc**: Script executed whenever a new terminal session is started in interactive mode.
- **~/.profile**: Similar to `/etc/profile`, but for individual users.

#### 7. Precedence of Environment Variables

The order of precedence for environment variables is generally as follows:
1. Variables set in the shell (temporary).
2. Variables set in the user's profile files (`~/.bashrc`, `~/.profile`).
3. Variables set in global profile files (`/etc/profile`).
4. Variables set in `/etc/environment`.

#### 8. Using Environment Variables in Scripts

Environment variables can be used in scripts to make them more dynamic and flexible.

Example of a shell script using environment variables:
```bash
#!/bin/bash

echo "Home Directory: $HOME"
echo "Current User: $USER"
echo "Current Directory: $PWD"
```

Save this script as `script.sh`, make it executable with `chmod +x script.sh`, and run it with `./script.sh`.

#### 9. Practical Examples

- **Adding a directory to the PATH variable:**
  ```bash
  export PATH=$PATH:/new/directory/path
  ```

- **Setting Java Home:**
  ```bash
  export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
  export PATH=$JAVA_HOME/bin:$PATH
  ```

- **Setting AWS CLI Environment Variables:**
  ```bash
  export AWS_ACCESS_KEY_ID=your_access_key
  export AWS_SECRET_ACCESS_KEY=your_secret_key
  export AWS_DEFAULT_REGION=your_region
  ```

Understanding and managing environment variables is essential for configuring and running applications on Linux systems. They help ensure that processes have the necessary configuration and resources to execute correctly.
