#### Install Python 3 Pip



Out of `virtual environment` if pip (Python package installer) is not already installed, you can install it using:

```sh
sudo apt install python3-pip
```

### Install a Virtual Environment

- When you activate a Python virtual environment, tools like pip become available because the `virtual environment` includes its isolated installation of pip
- This is the recommended approach to avoid interfering with the system-wide Python installation.

#### **Create a virtual environment**:
   ```bash
   sudo apt install python3-venv
   python3 -m venv myenv
   ```

#### **Activate the virtual environment**:
   ```bash
   source myenv/bin/activate
   ```
