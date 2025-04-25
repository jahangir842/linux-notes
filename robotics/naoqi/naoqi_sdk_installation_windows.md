**Guide to Install NAOqi SDK on Windows**  
This guide provides step-by-step instructions for installing the NAOqi SDK (Python SDK, version 2.8.6 or later) on a Windows system for use with NAO robots.

---

### **System Requirements**

Ensure your Windows system meets the following requirements:

- **Operating System:** Windows 10 or later (64-bit recommended).  
- **Python Version:** Python 2.7 (required, as the NAOqi Python SDK for version 2.8.6 is built for Python 2.7; newer versions are not compatible).  
- **Disk Space:** Sufficient space for the SDK and its dependencies.

---

### **Step 1: Install Python 2.7**

- If Python 2.7 is not installed, download it from the official Python website:  
  https://www.python.org/downloads/
- Run the installer and follow the prompts to install Python 2.7.
- Verify the installation by opening a Command Prompt and typing:

  ```bash
  python --version
  ```

- This should return `Python 2.7.x`.

---

### **Step 2: Download and Extract NAOqi SDK**

- Visit the Aldebaran NAO6 software downloads page:  
  https://aldebaran.com/en/support/kb/nao6/downloads/nao6-software-downloads/
- Locate the “SDKs” or “NAOqi SDK” section and download the Python SDK for Windows (version 2.8.6 or later).
- Extract the downloaded `.zip` archive to a directory of your choice, e.g., `C:\NAOqiSDK`.

---

### **Step 3: Configure System PATH**

Add the SDK’s `lib` directory to your system’s `PATH` environment variable to allow Python to locate NAOqi modules:

1. Right-click **“This PC”** and select **Properties**.  
2. Click **Advanced system settings** > **Environment Variables**.  
3. Under **“System variables,”** find **Path**, click **Edit**, and add the path to the SDK’s lib folder (e.g., `C:\NAOqiSDK\lib`).  
4. Click **OK** to save changes.

---

### **Step 4: Set Up the Python Environment**

- Open a Command Prompt and verify Python 2.7 is installed:

  ```bash
  python --version
  ```

- Ensure it returns `Python 2.7.x`.
- Test the NAOqi SDK installation by attempting to import the `naoqi` module:

  ```bash
  python -c "import naoqi"
  ```

- If no errors occur, the SDK is correctly installed.

- If you encounter a `ModuleNotFoundError: No module named 'naoqi'`, ensure the SDK’s `lib` directory is in your `PYTHONPATH`. Add it by including the following in your Python script or environment:

  ```python
  import sys
  sys.path.append("C:\\NAOqiSDK\\lib")
  ```

- Retest the import:

  ```bash
  python -c "import naoqi"
  ```

---

### **Step 5: Optional - Install Choregraphe**

- For graphical programming, download **Choregraphe** (version 2.8.7 or 2.8.8) from the same Aldebaran downloads page.
- Run the Choregraphe setup executable (`.exe`) and follow the installation prompts.
- Use the same license key as for the SDK if prompted.

---

### **Troubleshooting**

- If the download page requires a license key, use:  
  `654e-4564-153c-6518-2f44-7562-206e-4c60-5f47-5f45`.

- If the `naoqi` module fails to import, double-check the `Path` and `PYTHONPATH` settings.
- Ensure your NAO robot is running a compatible NAOqi version (e.g., 2.8.7 for Python SDK).
- For further assistance, refer to Aldebaran’s documentation:  
  https://doc.aldebaran.com/  
  or contact support via:  
  https://support.aldebaran.com/

---

### **Notes**

- The NAOqi Python SDK is designed for Python 2.7. **Do not use Python 3.x.**
- Ensure your NAO robot is on the same network as your Windows system for testing.
- This guide is based on a verified process as of **April 25, 2025**, and may require updates if Aldebaran changes their download portal or SDK versions.

---
