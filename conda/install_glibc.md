1. **Create a New Conda Environment**:
   ```bash
   conda create -n glibc-2.35-env
   ```
   This sets up an isolated environment for `glibc` 2.35.

2. **Activate the Environment**:
   ```bash
   conda activate glibc-2.35-env
   ```
   You should see `(glibc-2.35-env)` in your prompt.

3. **Install the Package**:
   ```bash
   conda install /path/to/glibc-2.35-0.conda --offline
   ```
   Replace `/path/to/` with the actual location (e.g., `/home/user/usb/glibc-2.35-0.conda`). The `--offline` flag ensures Conda doesn’t try to connect to the internet.

   *Note*: If you get an error about `libgcc-ng` missing, you’ll need to transfer that package too (see Troubleshooting below).

4. **Verify the Installation**:
   ```bash
   strings ~/miniconda3/envs/glibc-2.35-env/lib/libc.so.6 | grep GLIBC
   ```
   Look for `GLIBC_2.35` in the output to confirm the environment is using `glibc` 2.35. Compare with the system:
   ```bash
   strings /lib/x86_64-linux-gnu/libc.so.6 | grep GLIBC
   ```
   This should show up to `GLIBC_2.28`, confirming the system `glibc` remains unchanged.

5. **Test Your Application**:
   Run your program that requires `glibc` 2.35 within this environment:
   ```bash
   /path/to/your/program
   ```
   If it runs without `glibc` version errors, you’re all set!

#### Troubleshooting
- **Missing `libgcc-ng`**:
  If `conda install` complains about `libgcc-ng`, you’ll need to:
  1. On the online PC (vm2):
     ```bash
     conda install libgcc-ng -c conda-forge
     conda package --pkg-name libgcc-ng --pkg-version <version>
     ```
     Find the `.tar.bz2` file in `~/miniconda3/conda-bld/linux-64/` and transfer it.
  2. On the offline PC:
     ```bash
     conda install /path/to/libgcc-ng-<version>.tar.bz2 --offline
     ```
     Then retry step 3.

- **Older Conda Version**:
  If `.conda` isn’t supported, use a `.tar.bz2` version instead:
  1. On vm2, rebuild:
     ```bash
     conda-build . --output-format tar.bz2
     ```
     Transfer `glibc-2.35-0.tar.bz2`.
  2. Install with:
     ```bash
     conda install /path/to/glibc-2.35-0.tar.bz2 --offline
     ```

- **Program Errors**:
  If your program fails with linking errors, check dependencies:
  ```bash
  ldd /path/to/your/program
  ```
  Share any `not found` entries, and I’ll help resolve them.
