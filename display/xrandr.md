### **1. `xrandr` (X Resize, Rotate, and Reflect Extension)**
`xrandr` is a command-line utility for managing display settings in X11-based systems (like Ubuntu with Xorg). It allows you to:
- Check the current screen resolution.
- List available resolutions and refresh rates.
- Change the screen resolution and orientation.
- Enable or disable connected monitors.

#### **Example Commands:**
- Show current resolution:
  ```bash
  xrandr | grep '*'
  ```
- List all available resolutions:
  ```bash
  xrandr
  ```
- Change resolution to 1920x1080:
  ```bash
  xrandr --output HDMI-1 --mode 1920x1080
  ```
  (Replace `HDMI-1` with your actual display name from `xrandr` output.)

---

### **2. `xdpyinfo` (X Display Information)**
`xdpyinfo` provides detailed information about the X server, including:
- Screen dimensions (resolution in pixels).
- Physical display size (in mm).
- Color depth and other display settings.

#### **Example Commands:**
- Show screen resolution:
  ```bash
  xdpyinfo | grep dimensions
  ```
- Show all display details:
  ```bash
  xdpyinfo
  ```

---

### **Which One to Use?**
- Use `xrandr` for dynamic display adjustments and resolution changes.
- Use `xdpyinfo` for static information about the X server and screen settings.
