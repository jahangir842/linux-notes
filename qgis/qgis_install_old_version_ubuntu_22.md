# ✅ QGIS 3.34.11 Installation Guide on Ubuntu 22.04 (Jammy)

This guide outlines how to install **QGIS 3.34.11 (LTR)** on Ubuntu while avoiding version conflicts and ensuring stability using APT pinning.

---

## 🔧 Prerequisites

Ensure the system is up-to-date:

```bash
sudo apt update && sudo apt upgrade -y
```

---

## 🗝️ 1. Add QGIS Official Repository & Signing Key

```bash
sudo apt install -y gnupg software-properties-common
sudo mkdir -m755 -p /etc/apt/keyrings
wget -O /etc/apt/keyrings/qgis-archive-keyring.gpg https://download.qgis.org/downloads/qgis-archive-keyring.gpg
```

Add the Long Term Release (LTR) repository:

```bash
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/qgis-archive-keyring.gpg] https://qgis.org/ubuntu-ltr jammy main" | sudo tee /etc/apt/sources.list.d/qgis-ltr.list
```

---

## 🔁 2. Update APT Metadata

```bash
sudo apt update
```

---

## 📌 3. Pin QGIS to Version 3.34.11

Create a pinning file to force APT to select the 3.34.11 version:

```bash
sudo nano /etc/apt/preferences.d/qgis-3.34.pref
```

Paste the following:

```text
Package: qgis*
Pin: version 1:3.34.11+36jammy
Pin-Priority: 1001
```

Save and exit (`Ctrl+O`, `Enter`, `Ctrl+X`).

---

## 📦 4. Install QGIS 3.34.11 and Required Dependencies

Install QGIS with all dependencies pinned:

```bash
sudo apt install \
  qgis=1:3.34.11+36jammy \
  qgis-providers=1:3.34.11+36jammy \
  qgis-common=1:3.34.11+36jammy \
  python3-qgis=1:3.34.11+36jammy \
  python3-qgis-common=1:3.34.11+36jammy \
  qgis-plugin-grass=1:3.34.11+36jammy
```

---

## 🔒 5. (Optional) Prevent Accidental Upgrades

To keep your system from automatically upgrading QGIS to a newer version:

```bash
sudo apt-mark hold qgis qgis-providers qgis-common \
  python3-qgis python3-qgis-common qgis-plugin-grass
```

---

## 🧪 6. Verify Installation

Run QGIS from terminal:

```bash
qgis
```

Or check the version:

```bash
qgis --version
```

Expected:

```
QGIS version 3.34.11-Prizren
```

---

## 🧰 Optional: Clean Up

If you had previously broken installs or want to clean up:

```bash
sudo apt --fix-broken install
sudo apt autoremove
```

---

## 📂 Where to Find/Load Data

* **Shapefiles / GeoJSON / GPKG** can be added via:

  * `Layer → Add Layer → Add Vector Layer`
  * Or drag-and-drop into the map canvas

---

## 📝 Final Notes

* You are now running the **Long-Term Release (LTR)** version of QGIS, best for stability.
* You can manage plugins through: `Plugins → Manage and Install Plugins`

---

Let me know if you want this as a markdown file, PDF, or if you'd like to add sections for **loading vector layers**, **setting up a project**, or **installing plugins**.
