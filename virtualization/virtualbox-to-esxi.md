# Migrate a VirtualBox VM to VMware ESXi

The simplest migration path is:

```text
VirtualBox VM -> export as OVA/OVF -> deploy on ESXi -> install VMware Tools
```

An **OVA** is a single archive containing the OVF configuration and virtual disks. An
**OVF** export creates several files, normally an `.ovf`, one or more `.vmdk` files,
and optionally a manifest. OVA is usually easier to transfer.

> Keep the original VirtualBox VM until the imported ESXi VM has been tested. Do not
> run both copies on the same network at the same time because they may have the same
> hostname, IP address, or application identity.

---

## 1. Prepare the VirtualBox VM

1. Back up or clone the VM.
2. Record its CPU, memory, firmware mode (**BIOS or EFI**), disk layout, MAC address,
   static IP configuration, and any VLAN settings.
3. Remove mounted installation ISOs and unnecessary USB devices.
4. Shut down the guest operating system normally. Do not export a running VM or one
   in a saved state.
5. If possible, ensure the guest can use standard SATA/SCSI storage and a common
   Ethernet adapter. This is especially important for older Windows guests.
6. Make sure the destination datastore has enough free space.

VirtualBox-specific features such as shared folders, USB filters, snapshots, and
Guest Additions settings are not transferred as ESXi features.

---

## 2. Export the VM from VirtualBox

### Graphical method

1. Open **VirtualBox Manager**.
2. Open **File > Export Appliance**, or **Tools > Export** on versions that use the
   newer interface.
3. Select the powered-off VM.
4. Choose **Open Virtualization Format** and save it as `vm-name.ova`.
5. Start the export and wait for it to finish.

### Command-line method

List the available VMs:

```bash
VBoxManage list vms
```

Confirm that the source VM is powered off:

```bash
VBoxManage showvminfo "vm-name" --machinereadable | grep '^VMState='
```

Export it as an OVA appliance:

```bash
VBoxManage export "vm-name" \
  --output "/path/to/vm-name.ova" \
  --ovf10 \
  --manifest
```

OVF 1.0 is used here for broad compatibility. If the target environment explicitly
requires OVF 2.0, replace `--ovf10` with `--ovf20`.

Create a checksum before transferring the appliance:

```bash
sha256sum /path/to/vm-name.ova > /path/to/vm-name.ova.sha256
```

After copying it to another Linux machine, verify it with:

```bash
sha256sum --check vm-name.ova.sha256
```

---

## 3. Deploy the Appliance on ESXi

### Standalone ESXi Host Client

1. Open `https://ESXI-HOST/ui` and sign in.
2. Go to **Virtual Machines**.
3. Select **Create/Register VM**.
4. Select **Deploy a virtual machine from an OVF or OVA file**.
5. Enter a VM name and upload `vm-name.ova`.
6. Select the destination datastore.
7. Map the virtual network to the correct ESXi port group.
8. Select disk provisioning, normally **Thin** unless thick provisioning is required.
9. Review the settings and finish the deployment.

On ESX 9.1, the deployment command may instead be under **Host > Actions > Deploy
OVF Template**.

### ESXi managed by vCenter

Deploy through the **vSphere Client** instead of directly through the host:

1. Right-click the destination datacenter, cluster, host, or resource pool.
2. Select **Deploy OVF Template**.
3. Upload the OVA, choose compute and storage resources, map the network, and finish
   the wizard.

---

## 4. Review the VM Before Its First Boot

Do not start the VM until these settings have been checked:

- Firmware mode matches the source VM: **BIOS** or **EFI**.
- CPU and memory values are suitable for the guest OS.
- Every virtual disk is present and attached to a supported controller.
- The network adapter is connected to the correct port group.
- **Connect at power on** is enabled for the network adapter.
- Unneeded virtual CD/DVD and floppy devices are removed or disconnected.
- Secure Boot is enabled only if the guest already supports it.

For an older guest, an **E1000E** network adapter can be useful for the initial boot.
After VMware Tools is installed, **VMXNET3** normally provides better performance.

---

## 5. First Boot and Guest Cleanup

1. Open the ESXi console and power on the imported VM.
2. Confirm that it boots and detects its disks.
3. Check networking. The interface name or MAC address may have changed, so static
   network configuration may need to be updated.
4. Install VMware Tools. For most modern Linux guests, install `open-vm-tools`:

   ```bash
   # Debian/Ubuntu
   sudo apt update
   sudo apt install -y open-vm-tools

   # RHEL/Rocky/AlmaLinux/Fedora
   sudo dnf install -y open-vm-tools
   ```

   For a Linux desktop guest, also install `open-vm-tools-desktop` if it is available.
   For Windows, use **Guest OS > Install VMware Tools** in the vSphere/ESXi client and
   run the installer inside the guest.

5. After VMware Tools is working, remove VirtualBox Guest Additions from the guest.
6. Reboot and test application services, DNS, time synchronization, storage, and
   network access.
7. Take a new ESXi backup before making further changes.

Keep the source VirtualBox VM powered off until the ESXi VM has passed validation.

---

## Optional: Deploy with VMware OVF Tool

VMware OVF Tool is useful for automation or when a browser upload fails. It prompts
for the ESXi password if the password is not embedded in the URL:

```bash
ovftool \
  --name="vm-name" \
  --datastore="datastore1" \
  --diskMode=thin \
  --network="VM Network" \
  "/path/to/vm-name.ova" \
  "vi://root@esxi-host.example.com/"
```

If the host uses a self-signed certificate, trust/import that certificate when
possible. `--noSSLVerify` can be used temporarily in a trusted management network,
but it disables certificate verification.

OVF Tool can also normalize an appliance before deployment:

```bash
ovftool "/path/to/vm-name.ova" "/path/to/vm-name-normalized.ova"
```

---

## Troubleshooting

### The OVF/OVA is rejected as invalid

- Export again with `--ovf10`.
- Verify the SHA-256 checksum to rule out a damaged transfer.
- Try normalizing or deploying the appliance with VMware OVF Tool.
- If using separate OVF files, keep the `.ovf`, `.vmdk`, and `.mf` files together and
  select/upload all files required by the deployment wizard.

### ESXi rejects a VirtualBox OVA hardware definition

If ESXi reports an unsupported OVF hardware type, unpack the OVA and inspect its OVF
descriptor. The following example assumes the appliance is named `redmine.ova` and
the commands are run from the directory that contains it:

```bash
mkdir redmine-ova-edit
tar -xf redmine.ova -C redmine-ova-edit
ls redmine-ova-edit

# Find the OVF descriptor.
find redmine-ova-edit -maxdepth 1 -name '*.ovf'
```

Open the returned `.ovf` filename in Nano (replace `redmine.ovf` if needed):

```bash
nano redmine-ova-edit/redmine.ovf
```

In Nano, press <kbd>Ctrl</kbd>+<kbd>W</kbd> and search for `VirtualHardwareSection`.
If it exists, confirm that it is inside `<VirtualSystem ...>` and contains the
hardware `<Item>` entries. If it does not exist, search for `<Item>`: the item blocks
must be inside a `VirtualHardwareSection`; do not add an empty section separately.
Save with <kbd>Ctrl</kbd>+<kbd>O</kbd>, press <kbd>Enter</kbd>, and exit with
<kbd>Ctrl</kbd>+<kbd>X</kbd>.

To display the relevant XML with line numbers for review, run:

```bash
nl -ba redmine-ova-edit/*.ovf | sed -n '1,160p'
```

Only the `.ovf` text is relevant for this diagnosis. Do not share or inspect the
contents of any `.vmdk` virtual-disk file.

#### Replace the VirtualBox virtual hardware version

A VirtualBox export can declare the unsupported type below:

```xml
<vssd:VirtualSystemType>virtualbox-2.2</vssd:VirtualSystemType>
```

For ESXi 7, change only that value to the conservative VMware-compatible value
`vmx-14`:

```xml
<vssd:VirtualSystemType>vmx-14</vssd:VirtualSystemType>
```

From the directory containing `redmine-ova-edit`, make the replacement and confirm
it:

```bash
sed -i.bak \
  's#<vssd:VirtualSystemType>virtualbox-2.2</vssd:VirtualSystemType>#<vssd:VirtualSystemType>vmx-14</vssd:VirtualSystemType>#' \
  redmine-ova-edit/*.ovf

grep VirtualSystemType redmine-ova-edit/*.ovf
```

The `grep` output should include:

```xml
<vssd:VirtualSystemType>vmx-14</vssd:VirtualSystemType>
```

Rebuild the appliance without its old `.mf` manifest, because the descriptor edit
invalidates that file's checksum:

```bash
cd redmine-ova-edit
tar -cvf ../redmine-esxi.ova *.ovf *.vmdk
```

Upload and deploy `redmine-esxi.ova`.

#### Remove the unsupported VirtualBox sound card

ESXi does not support OVF `ResourceType` `35`, which is the VirtualBox sound device.
Remove the entire matching `<Item>` block from the `.ovf`:

```xml
<Item>
  <rasd:AddressOnParent>3</rasd:AddressOnParent>
  <rasd:AutomaticAllocation>false</rasd:AutomaticAllocation>
  <rasd:Caption>sound</rasd:Caption>
  <rasd:Description>Sound Card</rasd:Description>
  <rasd:ElementName>sound</rasd:ElementName>
  <rasd:InstanceID>7</rasd:InstanceID>
  <rasd:ResourceSubType>ensoniq1371</rasd:ResourceSubType>
  <rasd:ResourceType>35</rasd:ResourceType>
</Item>
```

Open the descriptor:

```bash
nano redmine-ova-edit/*.ovf
```

Search for `<rasd:InstanceID>7</rasd:InstanceID>`, then delete from its opening
`<Item>` through its closing `</Item>`. Save with <kbd>Ctrl</kbd>+<kbd>O</kbd>, press
<kbd>Enter</kbd>, and exit with <kbd>Ctrl</kbd>+<kbd>X</kbd>. Rebuild the OVA again:

```bash
cd redmine-ova-edit
tar -cvf ../redmine-esxi.ova *.ovf *.vmdk
```

Deploy the rebuilt OVA. The server VM will have no virtual sound device, which is
normally fine for a service such as Redmine.

### The VM cannot find a boot device

- Confirm that BIOS/EFI mode matches VirtualBox.
- Check that the boot disk is attached and first in the boot order.
- Try a controller supported by the guest, such as **LSI Logic SAS** for many older
  operating systems.
- Boot from the operating-system recovery ISO and repair the bootloader if the disk
  is visible but the OS does not boot.

### Windows shows `INACCESSIBLE_BOOT_DEVICE`

The Windows installation may not have a driver for the new storage controller.
Restore the source VM, enable an appropriate storage driver before exporting, and
repeat the migration. Avoid repeatedly changing controller types on the only copy.

### Linux boots but has no network

Check the new interface name and MAC address:

```bash
ip link
ip address
```

Update Netplan, NetworkManager, or the distribution's network configuration, then
restart networking or reboot.

### The imported VM has no network connectivity

Check both of these settings in ESXi:

- The adapter is mapped to the correct port group/VLAN.
- **Connected** and **Connect at power on** are enabled.

### Deployment fails when ESXi is managed by vCenter

Use **Deploy OVF Template** in the vSphere Client. Direct host deployment can be
restricted when vCenter manages the host and its networking.

---

## Migration Checklist

- [ ] Source VM backed up or cloned
- [ ] Source VM shut down cleanly
- [ ] Firmware mode and network settings recorded
- [ ] OVA exported and checksum verified
- [ ] Appliance deployed to the correct datastore and port group
- [ ] Firmware, disks, and network adapter checked before first boot
- [ ] Guest boot and network tested
- [ ] VMware Tools or `open-vm-tools` installed
- [ ] Application services validated
- [ ] Source VM retained, powered off, until migration acceptance

---

## References

- [Oracle VirtualBox: VBoxManage export](https://docs.oracle.com/en/virtualization/virtualbox/7.2/user/vboxmanage.html)
- [Broadcom: OVF Tool command syntax for ESXi and vCenter](https://knowledge.broadcom.com/external/article/340425/ovf-tool-command-syntax-to-export-and-de.html)
- [Broadcom: OVF deployment location in ESX 9.1 Host Client](https://knowledge.broadcom.com/external/article/455075/unable-to-locate-option-to-deploy-ovf-te.html)
