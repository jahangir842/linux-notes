Here are the detailed notes on **Configuring the Linux Console**:

---

# **Configuring the Linux Console**

The Linux console bootscript is responsible for setting up the **keyboard map**, **console font**, and **console kernel log level**. If non-ASCII characters (e.g., copyright symbol, British pound, Euro symbol) are not needed and the keyboard is **U.S. based**, this configuration may not be necessary.

## **1. Console Configuration File**
- The configuration file is located at:
  ```bash
  /etc/sysconfig/console
  ```
- If this file is absent, the console bootscript will not make any changes.

## **2. Checking Available Keymaps and Fonts**
- The keymaps are stored in:
  ```bash
  /usr/share/keymaps
  ```
- The console fonts are stored in:
  ```bash
  /usr/share/consolefonts
  ```
- To determine valid arguments for configuring keymaps and fonts, refer to:
  ```bash
  man loadkeys  # Keymap settings
  man setfont   # Console font settings
  ```

## **3. Configuration Variables**
The `/etc/sysconfig/console` file uses **key-value pairs** to configure the console.

| Variable | Description |
|----------|------------|
| **LOGLEVEL** | Specifies log level for kernel messages (1 to 8). Default: **7** |
| **KEYMAP** | Specifies the keymap name for `loadkeys`. Example: `it` for Italian keyboard. |
| **KEYMAP_CORRECTIONS** | Adjustments to the keymap. Example: `euro2` to add the Euro symbol. |
| **FONT** | Specifies console font for `setfont`. Example: `lat1-16 -m 8859-1`. |
| **UNICODE** | Set to `1`, `yes`, or `true` to enable **UTF-8 mode**. |
| **LEGACY_CHARSET** | Used when the keymap is not available in Unicode. Example: `iso-8859-15`. |

---

## **4. Configuration Examples**

### **Example 1: Enabling Unicode with a Default Console Font**
- Recommended when using **C.UTF-8** locale.
```bash
cat > /etc/sysconfig/console << "EOF"
# Begin /etc/sysconfig/console
UNICODE="1"
FONT="Lat2-Terminus16"
# End /etc/sysconfig/console
EOF
```

### **Example 2: Polish Keymap without Unicode**
```bash
cat > /etc/sysconfig/console << "EOF"
# Begin /etc/sysconfig/console
KEYMAP="pl2"
FONT="lat2a-16 -m 8859-2"
# End /etc/sysconfig/console
EOF
```

### **Example 3: Adding Euro Symbol to German Keymap**
```bash
cat > /etc/sysconfig/console << "EOF"
# Begin /etc/sysconfig/console
KEYMAP="de-latin1"
KEYMAP_CORRECTIONS="euro2"
FONT="lat0-16 -m 8859-15"
UNICODE="1"
# End /etc/sysconfig/console
EOF
```

### **Example 4: Bulgarian Keymap with Unicode**
```bash
cat > /etc/sysconfig/console << "EOF"
# Begin /etc/sysconfig/console
UNICODE="1"
KEYMAP="bg_bds-utf8"
FONT="LatArCyrHeb-16"
# End /etc/sysconfig/console
EOF
```

### **Example 5: Enabling Dead Keys & Autoconverting Keymap**
```bash
cat > /etc/sysconfig/console << "EOF"
# Begin /etc/sysconfig/console
UNICODE="1"
KEYMAP="de-latin1"
KEYMAP_CORRECTIONS="euro2"
LEGACY_CHARSET="iso-8859-15"
FONT="LatArCyrHeb-16 -m 8859-15"
# End /etc/sysconfig/console
EOF
```

---

## **5. Special Considerations**
1. **Framebuffers & Color Issues**  
   - Using a **512-glyph font** (e.g., `LatArCyrHeb-16`) disables **bright colors** unless a **framebuffer** is enabled.
   - If bright colors are necessary **without a framebuffer**, use a **256-glyph font**:
     ```bash
     FONT="cyr-sun16"
     ```

2. **Dead Keys & Multibyte Characters**  
   - **Dead keys** (keys that modify the next key pressed, like accents) work in **ISO-8859-1**, but not in UTF-8 mode on Linux console.
   - **Solution:** Use the **X Window System** instead.

3. **Chinese, Japanese, Korean (CJK) Language Support**  
   - The Linux console **cannot display** these characters properly.
   - **Solution:** Install the **X Window System**, proper fonts, and input methods like **SCIM**.

---

## **6. Important Notes**
- The **/etc/sysconfig/console** file **only** applies to the **Linux text console**.
- It does **not** affect:
  - X Window System keyboard layout and fonts.
  - SSH sessions.
  - Serial console configurations.

---

This covers the **configuration of the Linux console**, allowing you to set up the **keyboard layout**, **console font**, and **UTF-8 support**. 🚀
