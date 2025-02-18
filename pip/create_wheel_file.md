To build a **wheel (.whl) file** for **Windows and Linux** from a `.tar.gz` file


---

-- **For Window:** Build on Windows
-- **For Linux:** Build on Linux

**For Sepecific Python Version:** Create Conda evn with that Python Version: 

```shell
conda create --name myenv39 python=3.9 -y
conda activate myenv39
```

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
pip wheel package-name.tar.gz dist/
```

This will:
- Build a **.whl** file directly from the `.tar.gz` source distribution.
- Store the output inside the `dist/` directory.
- 

---

## **6. Install the Wheel File**
Once built, install it using:

```bash
pip install dist/package_name-1.0-py3-none-any.whl
```

---

## Build a Wheel File by Extracting

### Prerequisites
1. **Python**: Ensure you have Python installed on your system.
2. **pip**: Make sure `pip` is installed and up-to-date.
3. **setuptools** and **wheel**: Install these packages using `pip`.
   ```bash
   pip install setuptools wheel
   ```
4. **Cython** (if needed): If your package includes C extensions, you might need `Cython`.
   ```bash
   pip install cython
   ```

### Step 1: Extract the Tar Package
First, extract the tar package to a directory.
```bash
tar -xvf your_package.tar.gz
cd your_package
```

### Step 2: Create a `setup.py` File
If your package doesn't already have a `setup.py` file, you'll need to create one. This file is essential for building the wheel.

Here’s a basic example of a `setup.py` file:
```python
from setuptools import setup, find_packages

setup(
    name='your_package_name',
    version='0.1',
    packages=find_packages(),
    install_requires=[
        # List your dependencies here
    ],
    python_requires='>=3.6',
)
```

### Step 3: Build the Wheel
To build the wheel, run the following command in the directory containing the `setup.py` file:
```bash
python setup.py bdist_wheel
```

This will create a `.whl` file in the `dist` directory.

### Step 4: Build for Multiple Platforms
To build wheels for both Windows and Linux, you can use the `--plat-name` option to specify the platform.

#### For Windows
```bash
python setup.py bdist_wheel --plat-name win_amd64
```

#### For Linux
```bash
python setup.py bdist_wheel --plat-name manylinux1_x86_64
```

### Step 5: Verify the Wheels
After building the wheels, you can verify them by installing them in a virtual environment.

```bash
pip install dist/your_package_name-0.1-py3-none-win_amd64.whl
pip install dist/your_package_name-0.1-py3-none-manylinux1_x86_64.whl
```

### Step 6: Upload to PyPI (Optional)
If you want to distribute your package, you can upload it to PyPI.

1. **Install `twine`**:
   ```bash
   pip install twine
   ```

2. **Upload the wheels**:
   ```bash
   twine upload dist/*
   ```

### Troubleshooting
- **Platform-specific issues**: Ensure you have the necessary compilers and libraries installed for the target platform.
- **Dependencies**: Make sure all dependencies are correctly listed in `setup.py`.

### Example Directory Structure
```
your_package/
├── setup.py
├── your_package/
│   ├── __init__.py
│   └── module.py
└── dist/
    ├── your_package_name-0.1-py3-none-win_amd64.whl
    └── your_package_name-0.1-py3-none-manylinux1_x86_64.whl
```

By following these steps, you should be able to create Python wheels for both Windows and Linux platforms from a tar package.
