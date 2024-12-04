
### **1. Enable Auto-Activation of the Base Environment**

To re-enable the auto-activation of the `base` environment when opening a terminal:

#### **Command:**
```bash
conda config --set auto_activate_base true
```

#### **Explanation:**
- This restores the default behavior, making the `base` environment activate every time a new terminal session is started.

---### **2. Disable Auto-Activation of the Base Environment**

To stop Conda from activating the `base` environment automatically when a new terminal session starts:

#### **Command:**
```bash
conda config --set auto_activate_base false
```

#### **Explanation:**
- This updates your Conda configuration file (`.condarc`) to disable the default activation behavior.
- After running this, the base environment will no longer activate automatically, but Conda commands (like `conda activate`) will still work.

---


### **3. Quick Notes for Reference**

#### **Commands to Enable/Disable Auto-Activation**
- **Disable Auto-Activation**:  
  ```bash
  conda config --set auto_activate_base false
  ```
- **Enable Auto-Activation**:  
  ```bash
  conda config --set auto_activate_base true
  ```

#### **How to Check Current Setting**
To verify if auto-activation is enabled or disabled:
```bash
conda config --show | grep auto_activate_base
```
- Output will show either `auto_activate_base: True` or `auto_activate_base: False`.

#### **Manually Deactivate Base in a Session**
If auto-activation is enabled and you want to deactivate `base` temporarily:
```bash
conda deactivate
```

#### **Manually Activate Base**
If auto-activation is disabled and you want to activate `base` manually:
```bash
conda activate base
```

---

### **4. Optional: Advanced Notes**

- **Remove Conda Initialization Completely**:  
  If you want to stop Conda from modifying the shell altogether (including Conda commands availability), remove the Conda initialization block from your shell configuration file (`.bashrc` or `.zshrc`).

- **Restore Initialization**:  
  If you’ve removed initialization and want to bring it back:
  ```bash
  conda init
  ```

