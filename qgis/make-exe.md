# Create Exe File of AT_TEVA

To create an executable file for a QGIS-based desktop application, you can use **PyInstaller**. This guide will walk you through the process of packaging your QGIS application (`.py` file) into an `.exe` file.

---

### **Prerequisites**
1. **QGIS Installed**  
   Ensure QGIS Desktop is installed, including its Python environment and libraries. For example, QGIS 3.22.3.

2. **Use Python Interpreter**  
   Use the Python interpreter provided by QGIS, located in the QGIS installation directory.

3. **PyInstaller Installed**  
   Install PyInstaller using the Python environment associated with QGIS:
   ```bash
   pip install --no-index --find-links=http://192.168.1.109/libraries --trusted-host 192.168.1.109 pyinstaller
   ```

4. **Test Your Script**  
   Make sure your QGIS application runs correctly with the QGIS Python environment before proceeding.

---

### **Steps to Create the `.exe`**


#### **Step 1: Use PyInstaller**
Run the following command to package your script into an `.exe` file:

```bash
pyinstaller --onefile ^
--paths=apps\qgis\bin ^
--paths=apps\qgis\python ^
--paths=apps\qgis\python\plugins ^
--paths=apps\qgis\python\plugins\processing ^
--paths=apps\qgis\python\plugins\processing\core ^
--paths=apps\qgis\python\plugins\processing\algs\qgis ^
--add-data "Code_Files/*;Code_Files" ^
--add-data "Data_Files/*;Data_Files" ^
--add-data "Images/*;Images" ^
--add-data "Layers/*;Layers" ^
--add-data "Documentation/*;Documentation" ^
--add-data "ML_models/*;ML_models" ^
--add-data "Recording_Files/*;Recording_Files" ^
--add-data "C:\Program Files\QGIS 3.22.3\share\proj\*;proj_data" ^
--add-binary "C:\Program Files\QGIS 3.22.3\apps\qgis\bin\qgis_core.dll;." ^
--add-binary "C:\Program Files\QGIS 3.22.3\apps\qgis\bin\qgis_gui.dll;." ^
--hidden-import=qgis.core ^
--hidden-import=qgis.PyQt ^
--hidden-import=qgis.gui ^
--hidden-import=qgis._gui ^
--hidden-import=PyQt5.QtPositioning ^
--hidden-import=PyQt5.QtPrintSupport ^
--hidden-import=PyQt5.QtSql ^
--hidden-import=PyQt5.QtNetwork ^
--hidden-import=PyQt5.QtXml ^
--hidden-import=PyQt5.QtCore ^
--hidden-import=PyQt5.QtGui ^
--hidden-import=numpy ^
--hidden-import=scipy ^
--hidden-import=pyproj ^
--hidden-import=threat_evaluation ^
--hidden-import=weapon_assignment ^
--hidden-import=simulate_PV_data ^
--hidden-import=append_PV_data ^
--hidden-import=clustering_file ^
--hidden-import=config_parameters ^
--hidden-import=projection_file ^
gui_main.py

```

- **`--onefile`**: Packages everything into a single `.exe`.
- **`--paths`**: Adds the QGIS Python path.

#### **Step 2: Include QGIS Dependencies**
QGIS applications rely on many dynamic libraries. You need to ensure these are included:
1. Locate QGIS DLLs in the installation directory, typically under:
   ```
   C:\Program Files\QGIS 3.22.3\bin
   C:\Program Files\QGIS 3.22.3\apps\qgis\bin
   ```

2. Copy these directories into the `dist` folder (created by PyInstaller):
   ```
   dist/
   ├── gui_main.exe
   ├── qgis/
   └── other required DLLs...
   ```

#### **Step 3: Test the Executable**
1. Navigate to the `dist` directory:
   ```bash
   cd dist
   ```

2. Run the generated `.exe` file to verify:
   ```bash
   gui_main.exe
   ```

#### **Step 4: Debug Missing Libraries**
If the `.exe` doesn't work due to missing dependencies:
1. Check the PyInstaller log for warnings about missing modules.
2. Manually copy any missing DLLs or Python files to the `dist` directory.
3. Repeat the packaging process as needed.

---

### **Customizing the Build**

#### **Add an Icon**
Include a custom icon for your executable:
```bash
pyinstaller --onefile --icon=your_icon.ico --paths "C:\Program Files\QGIS 3.22.3\apps\qgis\python" gui_main.py
```

#### **Use a Spec File**
For more complex configurations, create a PyInstaller `.spec` file. Example:
```python
# gui_main.spec
# -*- mode: python -*-

block_cipher = None

a = Analysis(
    ['gui_main.py'],
    pathex=['C:\\Program Files\\QGIS 3.22.3\\apps\\qgis\\python'],
    binaries=[],
    datas=[],
    hiddenimports=[],
    hookspath=[],
    runtime_hooks=[],
    excludes=[],
    win_no_prefer_redirects=False,
    win_private_assemblies=False,
    cipher=block_cipher,
)
pyz = PYZ(a.pure, a.zipped_data, cipher=block_cipher)
exe = EXE(
    pyz,
    a.scripts,
    [],
    exclude_binaries=True,
    name='gui_main',
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=True,
    console=True,
)
```

Run:
```bash
pyinstaller gui_main.spec
```

---

### **Tips and Troubleshooting**
- **Check PyQt5 and QGIS Compatibility**: Ensure the `PyQt5` version matches the version used by QGIS.
- **Dynamic Libraries**: If you encounter errors related to `.dll` files, use a dependency walker tool like [Dependency Walker](http://www.dependencywalker.com/) to identify missing libraries.
- **Verbose Mode**: Use the `--log-level=DEBUG` flag with PyInstaller for detailed logs:
  ```bash
  pyinstaller --onefile --log-level=DEBUG gui_main.py
  ```

---

### **Packaging and Distribution**
- Include all required DLLs in the final package.
- Test the `.exe` on a clean system to ensure no dependencies are missing.
- Use tools like [Inno Setup](https://jrsoftware.org/isinfo.php) to create an installer for your application.

This guide should help you package and distribute your QGIS-based desktop application successfully. Let me know if you face any specific issues!