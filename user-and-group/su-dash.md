### Notes on the Dash (`-`) in `su` Command

1. **Dash (`-`) after `su`**:
   - When using `su - <username>`, the dash (`-`) signifies that you want to start a **login shell** for the target user.

2. **Login Shell**:
   - A login shell initializes the user’s environment, including environment variables, user-specific configurations, and aliases.
   - It reads and applies files like `.bash_profile`, `.bashrc`, and `.profile`.

3. **Effect**:
   - **With `-`**: The environment of the target user is fully loaded, ensuring proper configuration and setup.
   - **Without `-`**: The user is switched, but the environment remains from the previous user, potentially leading to inconsistent settings.

4. **Purpose**:
   - The dash ensures the shell simulates a fresh login for the user, applying their environment and configuration settings as if they logged in directly.
