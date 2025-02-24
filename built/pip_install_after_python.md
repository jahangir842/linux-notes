If Python is installed but `pip3` is not found in **Linux From Scratch (LFS)**, you need to install `pip` manually. Follow these steps:

---

## **1. Verify Python Installation**
Check if Python is installed and locate its version:

```bash
python3 --version
```
or
```bash
which python3
```

Ensure `python3` is correctly installed and available in `$PATH`.

---

## **2. Check if `pip3` is Installed**
Run:

```bash
python3 -m ensurepip --default-pip
```

If `pip` is already installed, this command will return the path to `pip`.

---

## **3. Manually Install `pip3`**
If `pip3` is missing, install it using the official method:

```bash
curl -O https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py --user
```

This will install `pip` in the user directory.

---

## **4. Ensure `pip3` is in `$PATH`**
If `pip3` is installed but not found, it might not be in `$PATH`. Try:

```bash
export PATH=$HOME/.local/bin:$PATH
```

To make it permanent, add this line to `~/.bashrc` or `~/.profile`:

```bash
echo 'export PATH=$HOME/.local/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
```

---

## **5. Verify Installation**
Check if `pip3` is now available:

```bash
pip3 --version
```

---

## **6. Alternative: Install `pip` via Package Manager**
If you're using a package manager, you may install `pip3` using:

```bash
python3 -m ensurepip
python3 -m pip install --upgrade pip
```

---

### **Final Notes**
- In **Linux From Scratch**, package managers are not available by default, so manual installation is required.
- Ensure dependencies like `openssl` and `setuptools` are installed before running `pip`.

