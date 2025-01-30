# **Live Migration of VMs in KVM**
Live migration in **KVM (Kernel-based Virtual Machine)** allows you to move a **running virtual machine (VM) from one host to another** with **zero downtime**. This is useful in **high-availability environments, load balancing, and system maintenance** without interrupting services.

---

## **1️⃣ Prerequisites**
### **✅ Hosts Configuration**
- Both source and destination hosts must **support KVM** and have `libvirtd` running.
- Both hosts should have the **same CPU architecture** (Intel or AMD).
- The guest VM should have a **shared storage backend** (e.g., NFS, GlusterFS, Ceph, or iSCSI).
- Ensure both hosts use the **same networking setup**.

### **✅ Install Required Packages**
On **both** source and destination hosts, install KVM and necessary tools:

```bash
sudo apt update
sudo apt install -y qemu-kvm libvirt-daemon libvirt-daemon-system libvirt-clients bridge-utils
```

Enable and start `libvirtd`:

```bash
sudo systemctl enable --now libvirtd
```

### **✅ Enable Passwordless SSH Between Hosts**
The migration process requires SSH access between the hosts.

1. **Generate SSH keys** on the **source host**:
   ```bash
   ssh-keygen -t rsa -b 4096
   ```

2. **Copy the public key to the destination host**:
   ```bash
   ssh-copy-id user@destination-host
   ```

Test SSH access:
```bash
ssh user@destination-host
```
It should connect **without asking for a password**.

---

## **2️⃣ Types of Live Migration in KVM**
### **1. Shared Storage Live Migration (Recommended)**
- VM disk is stored on a **shared filesystem** (NFS, Ceph, GlusterFS, etc.).
- Only **RAM and CPU state** are transferred.

### **2. Non-Shared Storage Live Migration**
- VM disk is copied **over the network**, increasing migration time.

---

## **3️⃣ Performing Live Migration**
### **✅ Check Running VMs**
On the **source host**, list running VMs:
```bash
virsh list
```

Assume we want to migrate a VM named **`ubuntu-vm`**.

### **✅ Migrate VM to Another Host**
#### **🔹 1. With Shared Storage**
If the VM's disk is stored on **NFS or Ceph**, use:
```bash
virsh migrate --live --persistent --undefinesource --verbose \
--copy-storage-all ubuntu-vm \
qemu+ssh://user@destination-host/system
```
- `--live` → Migrates VM **without downtime**.
- `--persistent` → Keeps the VM defined on the destination.
- `--undefinesource` → Removes VM from the source after migration.
- `--copy-storage-all` → Transfers disk storage **if not on shared storage**.

#### **🔹 2. With Non-Shared Storage**
If the VM's disk is **not on shared storage**, copy everything over:
```bash
virsh migrate --live --persistent --undefinesource --copy-storage-all \
ubuntu-vm qemu+ssh://user@destination-host/system
```

---

## **4️⃣ Verifying the Migration**
### **✅ On the Destination Host**
Check if the VM is running:
```bash
virsh list
```

If the VM appears in the list, the migration was successful! ✅

### **✅ On the Source Host**
Run:
```bash
virsh list --all
```
The VM **should no longer be listed** on the source host.

---

## **5️⃣ Troubleshooting Live Migration Issues**
### **🚨 Issue: SSH Connection Failure**
**Error:**  
```
Permission denied (publickey).
```
**Fix:** Ensure passwordless SSH works:
```bash
ssh user@destination-host
```
If prompted for a password, re-run:
```bash
ssh-copy-id user@destination-host
```

### **🚨 Issue: Migration Fails Due to Different CPU Types**
**Error:**  
```
unsupported configuration: live migration between different CPU models is not supported
```
**Fix:** Use **CPU mode host-passthrough** in the VM XML:
```bash
virsh edit ubuntu-vm
```
Find `<cpu>` section and set:
```xml
<cpu mode='host-passthrough'/>
```
Save and restart the VM.

### **🚨 Issue: Storage Not Found on Destination**
**Error:**  
```
Cannot access storage path
```
**Fix:** Ensure both hosts have **shared storage** like NFS or Ceph.

---

## **6️⃣ Automating Live Migration with Ansible**
Use an **Ansible playbook** to migrate a VM:

### **📝 Create an Ansible Playbook (`migrate_vm.yml`)**
```yaml
- hosts: source_host
  tasks:
    - name: Migrate VM
      command: >
        virsh migrate --live --persistent --undefinesource --verbose
        ubuntu-vm qemu+ssh://user@destination-host/system
```

### **Run the Playbook**
```bash
ansible-playbook -i inventory migrate_vm.yml
```
✅ This automates live migration between KVM hosts.

---

## **7️⃣ Conclusion**
✅ **KVM Live Migration allows seamless movement of running VMs between hosts**  
✅ **Recommended method:** Use **shared storage** for faster migration  
✅ **Ensure proper SSH access & identical hardware**  
✅ **Use Ansible to automate migration for high-availability environments**  

🚀 **Now you can migrate VMs in production without downtime!** 🎉
