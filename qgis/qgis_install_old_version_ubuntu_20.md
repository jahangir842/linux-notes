Thanks for clarifying — since you're installing **QGIS 3.34.11** on **Ubuntu 20.04 Focal**, a few adjustments are needed because:

* Ubuntu 20.04 is `focal`, not `jammy`.
* QGIS 3.34.11 is **available** for `focal` in the official QGIS LTR repository.
* You had issues earlier likely due to an incorrect or incomplete APT setup.

---

## ✅ Step-by-Step Guide to Install QGIS 3.34.11 on Ubuntu 20.04 (Focal)

### 🧹 1. Clean Up Any Previous Conflicting Sources (if any)

```bash
sudo rm -f /etc/apt/sources.list.d/qgis*.list
sudo rm -f /etc/apt/preferences.d/qgis*
```

---

### 🔑 2. Add QGIS GPG Key

```bash
sudo mkdir -p /etc/apt/keyrings
wget -O /etc/apt/keyrings/qgis-archive-keyring.gpg https://download.qgis.org/downloads/qgis-archive-keyring.gpg
```

---

### 📦 3. Add QGIS LTR Repository for Ubuntu 20.04

```bash
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/qgis-archive-keyring.gpg] https://qgis.org/ubuntu-ltr focal main" | sudo tee /etc/apt/sources.list.d/qgis-ltr.list
```

---

### 📌 4. Pin QGIS 3.34.11 Version (Optional but Recommended)

```bash
sudo nano /etc/apt/preferences.d/qgis-3.34.pref
```

Paste the following:

```text
Package: qgis*
Pin: version 1:3.34.11+36focal
Pin-Priority: 1001
```

Save and exit (`Ctrl+O`, `Enter`, `Ctrl+X`).

---

### 🔄 5. Update Package List

```bash
sudo apt update
```

Then verify:

```bash
apt-cache policy qgis
```

You should see `1:3.34.11+36focal` listed.

---

### ✅ 6. Install QGIS 3.34.11

```bash
sudo apt install \
  qgis=1:3.34.11+36focal \
  qgis-providers=1:3.34.11+36focal \
  qgis-common=1:3.34.11+36focal \
  python3-qgis=1:3.34.11+36focal \
  python3-qgis-common=1:3.34.11+36focal \
  qgis-plugin-grass=1:3.34.11+36focal
```

---

### 🔒 7. Prevent Automatic Upgrades (Optional)

```bash
sudo apt-mark hold qgis qgis-providers qgis-common \
  python3-qgis python3-qgis-common qgis-plugin-grass
```

---

### 🧪 8. Launch QGIS

```bash
qgis
```

---

Let me know if you’d like this exported as a markdown or PDF guide.
