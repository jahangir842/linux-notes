To build a **wheel (.whl) file** for **Windows and Linux** from a `.tar.gz` file **without extracting** it manually, follow these steps:

---

## **1. Ensure Required Tools are Installed**
Install `pip`, `wheel`, and `build`:

```bash
pip install wheel build
```

---

## **2. Build a Wheel File Without Extracting**
Run the following command:

```bash
pip wheel package-name.tar.gz --no-deps --wheel-dir dist/
```

This will:
- Build a **.whl** file directly from the `.tar.gz` source distribution.
- Store the output inside the `dist/` directory.

---

## **3. Build a Wheel for a Specific Python Version**
To target a **specific Python version**, use:

```bash
pip wheel --python-version 39 package-name.tar.gz --wheel-dir dist/
```

For example:
- `--python-version 38` → Python 3.8
- `--python-version 39` → Python 3.9
- `--python-version 310` → Python 3.10

---

## **4. Build a Wheel for a Specific Platform (Windows/Linux)**
By default, `pip wheel` builds for the current platform.

To build for a **specific platform**, use **`manylinux` for Linux** and **`win_amd64` for Windows**:

- **Linux (manylinux2014)**
  ```bash
  pip wheel --platform manylinux2014_x86_64 package-name.tar.gz --wheel-dir dist/
  ```

- **Windows (win_amd64)**
  ```powershell
  pip wheel --platform win_amd64 package-name.tar.gz --wheel-dir dist/
  ```

---

## **5. Check the Built Wheel**
After building, list the generated wheel files:

```bash
ls dist/
```

or on Windows:

```powershell
dir dist
```

You should see a file like:

```
package_name-1.0-py3-none-any.whl
```

---

## **6. Install the Wheel File**
Once built, install it using:

```bash
pip install dist/package_name-1.0-py3-none-any.whl
```

---

### **Summary**
| Task                          | Command |
|--------------------------------|---------|
| Build wheel without extracting | `pip wheel package-name.tar.gz --no-deps --wheel-dir dist/` |
| Target a specific Python version | `pip wheel --python-version 39 package-name.tar.gz --wheel-dir dist/` |
| Build for Linux | `pip wheel --platform manylinux2014_x86_64 package-name.tar.gz --wheel-dir dist/` |
| Build for Windows | `pip wheel --platform win_amd64 package-name.tar.gz --wheel-dir dist/` |

This allows **cross-platform** wheel building without manually extracting the source distribution! 🚀
