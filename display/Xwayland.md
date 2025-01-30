### **What is Xwayland?**  
**Xwayland** is a **compatibility layer** that allows applications designed for **X11 (Xorg)** to run on a **Wayland** session. It acts as a bridge between legacy X11 applications and the modern **Wayland display server**.

---

### **Why Does Xwayland Exist?**  
Many applications were built for **X11 (Xorg)** and do not support **Wayland natively**. Since Wayland is replacing X11 in many Linux distributions, Xwayland ensures that old X applications still work **without modification**.

---

### **How Xwayland Works**  
- When an **X11-only** application is launched on a **Wayland session**, Xwayland **automatically starts**.
- It provides a **virtual X server** that translates **X11 requests** into **Wayland-compatible** graphics.
- The **Wayland compositor** (e.g., GNOME's Mutter, KDE's KWin, Sway, Weston) then displays the app.

---

### **How to Check if an App is Running on Xwayland?**  
Run the following command:  
```bash
xlsclients
```
If the application appears in the list, it's running under **Xwayland** instead of native Wayland.

Alternatively, run:
```bash
echo $XDG_SESSION_TYPE
```
- If it says `wayland`, your session is on Wayland, and X apps are using **Xwayland**.

---

### **Limitations of Xwayland**  
- **No direct `xrandr` support** – Since Wayland handles display management differently, `xrandr` does not work as expected.
- **Performance overhead** – Running X11 apps through Xwayland can be **slower** than native Wayland apps.
- **No access to some Wayland features** – Apps running via Xwayland **cannot** take full advantage of **Wayland security features** (like sandboxed input handling).

---

### **How to Avoid Xwayland?**  
If possible, use **Wayland-native** applications instead of X11-based ones. Some apps already have Wayland support, such as:
- **Firefox & Chromium** → Launch with `MOZ_ENABLE_WAYLAND=1 firefox`
- **GIMP, Inkscape, Blender** → Native Wayland support in newer versions
- **Electron apps** → Some support Wayland via environment variables

To **fully disable Xwayland**, you usually need to start your Wayland session with:
```bash
export XWAYLAND_DISABLE=1
```
(but this may break X11-only applications).

---
