# 📘 NVIDIA NGC CLI Installation Guide (Ubuntu 22.04+)

This guide explains how to install the NVIDIA NGC CLI on Ubuntu systems manually via the command line.

---

## ✅ Prerequisites

* Ubuntu 22.04 or later
* `unzip` installed
* User with sudo privileges
* Internet connection

---

## 📦 Step 1: Download NGC CLI

Download the latest `ngccli_linux.zip` file from the official NVIDIA NGC website:
👉 [https://ngc.nvidia.com/setup](https://ngc.nvidia.com/setup)

Save it to your `~/Downloads` directory.

---

## 📁 Step 2: Extract the CLI

Open a terminal and run:

```bash
cd ~/Downloads
rm -rf ngccli  # Clean up any old extracted versions
unzip ngccli_linux.zip -d ngccli
```

This will extract files into:

```bash
~/Downloads/ngccli/ngc-cli/
```

---

## 🔐 Step 3: Make the CLI Executable

```bash
chmod +x ~/Downloads/ngccli/ngc-cli/ngc
```

---

## 🔗 Step 4: Create a Symlink

Instead of moving the binary (which breaks internal paths), link it system-wide:

```bash
sudo ln -sf "$HOME/Downloads/ngccli/ngc-cli/ngc" /usr/local/bin/ngc
```

---

## 🧪 Step 5: Verify the Installation

Run:

```bash
ngc --version
```

Expected output:

```
NGC CLI Version x.x.x
```

If you see an error about missing `libpython`, it likely means you moved the binary instead of linking it. Ensure the binary stays in its original directory.

---

## 🧼 (Optional) Add to PATH Permanently

Alternatively, you can add the directory to your shell’s `PATH`:

```bash
echo 'export PATH="$HOME/Downloads/ngccli/ngc-cli:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

---

## 📎 Tips

* Use `ngc config set` to configure your API key and default org/project.
* Documentation: [https://docs.nvidia.com/ngc/index.html](https://docs.nvidia.com/ngc/index.html)

---

