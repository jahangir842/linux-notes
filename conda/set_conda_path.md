### Setting the PATH in Ubuntu for Conda

To ensure that Conda and its tools (like `conda`, `jupyter`, etc.) are accessible from any terminal session, you need to add the Conda installation's `bin` directory to your system’s `PATH`.

Here's a quick guide to set the `PATH` for Conda:

1. **Open the `.bashrc` file:**

   The `.bashrc` file is used to configure user-specific settings for interactive shells. Open it using a text editor like `nano`:

   ```bash
   nano ~/.bashrc
   ```

2. **Add Conda's `bin` directory to the `PATH`:**

   Add the following line to the end of the `.bashrc` file:

   ```bash
   export PATH="$HOME/miniconda3/bin:$PATH"
   ```

   - This line tells the shell to look in Conda's `bin` directory for executables before checking other directories listed in the `PATH`.
   - Replace `$HOME/miniconda3` with the appropriate path if your Conda is installed elsewhere.

3. **Save and exit the editor:**

   - In `nano`, press `CTRL + X`, then press `Y` to confirm, and `Enter` to save.

4. **Apply the changes:**

   Reload the `.bashrc` file to apply the changes:

   ```bash
   source ~/.bashrc
   ```

5. **Verify the change:**

   To confirm that Conda is now in your `PATH`, you can check the version of Conda:

   ```bash
   conda --version
   ```

   If the installation path was set correctly, you should see the Conda version.

This procedure ensures that Conda is available in your terminal, and you can run Conda commands from anywhere.
