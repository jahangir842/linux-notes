🔄 Unattended Upgrades (Automatic Security Updates in Ubuntu)

Unattended Upgrades automatically install security (and optionally other) updates in the background—critical for keeping servers patched without manual work.


---

⚙️ 1. Install package

sudo apt update
sudo apt install unattended-upgrades


---

🚀 2. Enable it quickly

sudo dpkg-reconfigure unattended-upgrades

👉 Choose Yes → this enables automatic security updates


---

📁 3. Main configuration files

🔹 /etc/apt/apt.conf.d/50unattended-upgrades

Controls:

What updates are allowed

Blacklist packages

Auto reboot behavior


🔹 /etc/apt/apt.conf.d/20auto-upgrades

Controls:

Whether updates run automatically



---

🧩 4. Important config options

Enable security updates only (default safe setup)

Unattended-Upgrade::Allowed-Origins {
    "${distro_id}:${distro_codename}-security";
};


---

Enable all updates (more aggressive)

"${distro_id}:${distro_codename}-updates";


---

Auto reboot if required

Unattended-Upgrade::Automatic-Reboot "true";
Unattended-Upgrade::Automatic-Reboot-Time "03:00";


---

Exclude specific packages

Unattended-Upgrade::Package-Blacklist {
    "nginx";
    "mysql-server";
};


---

⏱️ 5. Schedule (Auto execution)

File: /etc/apt/apt.conf.d/20auto-upgrades

APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Unattended-Upgrade "1";

Meaning:

1 = daily

0 = disabled



---

📜 6. Logs (very important for debugging)

/var/log/unattended-upgrades/unattended-upgrades.log
/var/log/unattended-upgrades/unattended-upgrades-dpkg.log


---

🧪 7. Test manually

sudo unattended-upgrade --dry-run --debug

👉 Shows what would happen without actually installing


---

🔧 8. DevOps / Ansible Example

- name: Install unattended upgrades
  ansible.builtin.apt:
    name: unattended-upgrades
    state: present
    update_cache: true

- name: Enable unattended upgrades
  ansible.builtin.copy:
    dest: /etc/apt/apt.conf.d/20auto-upgrades
    content: |
      APT::Periodic::Update-Package-Lists "1";
      APT::Periodic::Unattended-Upgrade "1";


---

☁️ Cloud Best Practice

Environment	Recommendation

AWS EC2	Enable unattended + use AMI patching
Azure VM	Combine with Update Management
Huawei Cloud	Same pattern
Kubernetes Nodes	Avoid auto-updates → use rolling node replacement


👉 In production clusters:
Prefer immutable infra over auto patching


---

⚠️ When NOT to use unattended upgrades

Avoid or restrict if:

You run critical DBs (MySQL/Postgres)

You need strict change control

You use custom compiled packages


👉 Instead: schedule controlled maintenance windows


---

🧠 Memorization Trick

> “Unattended = Auto + Security + Silent”



Auto → runs itself

Security → focuses on security patches

Silent → no manual interaction



---

🔥 Real-world Setup Strategy

Balanced (recommended for servers):

Enable unattended upgrades

Only security updates

Disable auto reboot


Aggressive:

Enable all updates

Enable auto reboot (night time)



---
