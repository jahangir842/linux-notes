# **What is `virsh`?**
`virsh` (Virtual Shell) is a **command-line tool** used to manage **KVM (Kernel-based Virtual Machine), QEMU, and Xen** virtual machines through **libvirt**. It allows system administrators to create, modify, start, stop, migrate, and monitor virtual machines.

---

## **1️⃣ Why Use `virsh`?**
✅ **Lightweight:** No need for a full GUI like `virt-manager`.  
✅ **Automation Friendly:** Can be used in scripts and Ansible.  
✅ **Remote Management:** Manage VMs over SSH.  
✅ **Advanced Features:** Live migration, snapshots, and VM cloning.  

---

## **2️⃣ Basic `virsh` Commands**
### **✅ 1. Check KVM & `libvirtd` Status**
```bash
systemctl status libvirtd
```
Start if not running:
```bash
sudo systemctl start libvirtd
sudo systemctl enable libvirtd
```

### **✅ 2. List VMs**
```bash
virsh list --all
```
- Shows **all virtual machines** (running and stopped).
- `virsh list` (without `--all`) shows only **running VMs**.

### **✅ 3. Start & Stop a VM**
```bash
virsh start my-vm
virsh shutdown my-vm
```
- `start` → Boots the VM.  
- `shutdown` → Gracefully shuts down the VM.

To **force stop** a VM:
```bash
virsh destroy my-vm
```
(**Warning:** This is like unplugging the power!)

### **✅ 4. Create a New VM**
Create a VM from an **existing XML definition**:
```bash
virsh define /path/to/vm.xml
virsh start my-vm
```

Or, use `virt-install`:
```bash
virt-install --name my-vm --ram 2048 --vcpus 2 --disk path=/var/lib/libvirt/images/my-vm.qcow2,size=20 --os-type linux --cdrom /path/to/ubuntu.iso --network bridge=virbr0
```

### **✅ 5. Delete a VM**
```bash
virsh undefine my-vm
rm -rf /var/lib/libvirt/images/my-vm.qcow2
```
(`undefine` removes metadata; delete disk manually!)

### **✅ 6. Check VM Information**
```bash
virsh dominfo my-vm
```

### **✅ 7. View VM Console**
```bash
virsh console my-vm
```
(Exit with `Ctrl+]`)

### **✅ 8. Live Migrate a VM**
```bash
virsh migrate --live my-vm qemu+ssh://destination-host/system
```

### **✅ 9. Snapshot Management**
Take a snapshot:
```bash
virsh snapshot-create-as my-vm snap1 "Backup before update"
```
List snapshots:
```bash
virsh snapshot-list my-vm
```
Revert to a snapshot:
```bash
virsh snapshot-revert my-vm snap1
```

### **✅ 10. Change VM Resources**
Increase RAM:
```bash
virsh setmem my-vm 4096 --config
```
Increase vCPUs:
```bash
virsh setvcpus my-vm 4 --config
```

---

## **3️⃣ Useful `virsh` Commands at a Glance**
| Command | Description |
|---------|-------------|
| `virsh list --all` | List all VMs |
| `virsh start <vm-name>` | Start a VM |
| `virsh shutdown <vm-name>` | Shut down a VM |
| `virsh destroy <vm-name>` | Force stop a VM |
| `virsh undefine <vm-name>` | Remove VM from libvirt |
| `virsh dominfo <vm-name>` | Show VM details |
| `virsh console <vm-name>` | Access VM console |
| `virsh migrate --live <vm-name> <dest>` | Live migrate a VM |
| `virsh snapshot-create-as <vm> <name>` | Take a snapshot |
| `virsh snapshot-revert <vm> <snapshot>` | Revert to a snapshot |

---

## **4️⃣ Conclusion**
- **`virsh` is a powerful command-line tool** for managing KVM virtual machines.
- It provides **better control & automation** than GUI tools.
- Supports **live migration, snapshots, and remote management**.

🚀 **Now you're ready to manage KVM VMs efficiently!** 🎯
