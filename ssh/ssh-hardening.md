🔐 SSH Hardening — What You’re Defending Against

Common threats:

Brute-force login attempts

Credential theft (password reuse)

Lateral movement inside network

Exploiting SSH features (port forwarding, tunneling)



---

🧱 1. PermitRootLogin no

PermitRootLogin no

🔍 What it does

Completely blocks direct login as root


🧠 Why it matters

Root is a known username → attackers only need password/key

Disabling forces:

Guess username AND

Compromise another account



⚙️ Internals

SSH daemon (sshd) checks this directive before authentication and rejects root sessions early.


---

🔑 2. PasswordAuthentication no

PasswordAuthentication no
ChallengeResponseAuthentication no

🔍 What it does

Disables password-based login

Only allows public key authentication


🧠 Why it matters

Passwords are vulnerable to:

Brute force

Phishing


SSH keys use asymmetric cryptography



---

🔐 How SSH keys work

Private key → stays on client

Public key → stored on server (~/.ssh/authorized_keys)


Login flow:

1. Server sends challenge


2. Client signs with private key


3. Server verifies with public key



👉 No password is transmitted


---

🔐 3. ed25519 Keys

ssh-keygen -t ed25519

🔍 What it is

Modern elliptic-curve algorithm


🧠 Why better than RSA

Smaller keys

Faster authentication

Stronger security per bit



---

🚪 4. Port 2222 (Change default port)

Port 2222

🔍 What it does

Moves SSH from port 22 → custom port


🧠 Why it helps

Bots scan port 22 automatically

Reduces noise in logs


⚠️ Important

Not real security (security through obscurity)

Always combine with firewall rules



---

👥 5. AllowUsers / AllowGroups

AllowUsers devops jahangir

🔍 What it does

Whitelists allowed users


🧠 Why it matters

Even if attacker creates a user → cannot SSH


⚙️ Internals

sshd checks username before authentication


---

⏱️ 6. MaxAuthTries & LoginGraceTime

MaxAuthTries 3
LoginGraceTime 30

🔍 What they do

MaxAuthTries → max login attempts per connection

LoginGraceTime → time allowed before disconnect


🧠 Why it matters

Slows brute-force attacks significantly



---

🔌 7. Disable Unused Features

X11Forwarding no
AllowTcpForwarding no
PermitTunnel no


---

🔍 Feature explanations

🖥️ X11Forwarding

Allows GUI apps over SSH


👉 Risk:

Can expose graphical session

Rarely needed on servers



---

🔀 AllowTcpForwarding

Allows port forwarding:


ssh -L 8080:localhost:80 user@server

👉 Risk:

Can bypass firewalls

Used for data exfiltration



---

🌐 PermitTunnel

Allows VPN-like tunnels


👉 Risk:

Hidden network channels



---

🧠 Principle:

> Disable anything you don’t explicitly need




---

🧠 8. Fail2Ban

🔍 What it does

Monitors logs

Bans IPs after failed login attempts


⚙️ How it works

1. Reads logs (via journalctl or /var/log/auth.log)


2. Detects patterns (e.g., failed SSH login)


3. Adds firewall rule (iptables/ufw)




---

Example:

fail2ban-client status sshd


---

🔍 9. Logging (journalctl)

journalctl -u ssh -f

🔍 What it does

Shows real-time SSH logs


🧠 Why important

Detect attacks early

Audit access



---

🔒 10. authorized_keys restrictions

Example:

command="backup.sh",no-port-forwarding,no-agent-forwarding ssh-ed25519 AAAA...


---

🔍 What these mean

Option	Explanation

command=	Forces a specific command
no-port-forwarding	Disables tunneling
no-agent-forwarding	Prevents key reuse


👉 Useful for automation keys


---

🔧 11. SSH Client Config (~/.ssh/config)

Host prod
  HostName 1.2.3.4
  User ubuntu
  IdentityFile ~/.ssh/key

🔍 What it does

Simplifies SSH usage


🧠 Why important

Prevents using wrong keys

Enforces correct identity



---

🌐 12. Firewall (UFW / Security Groups)

ufw allow from YOUR_IP to any port 22

🔍 What it does

Restricts who can connect


🧠 Why it's critical

Even if SSH is vulnerable → attacker cannot reach it



---

☁️ 13. Bastion Host (Jump Server)

ssh -J bastion user@private-server

🔍 What it does

Single entry point to private network


🧠 Why it matters

Reduces exposed attack surface

Centralized logging & control



---

🔄 14. Safe Reload

sshd -t
systemctl restart ssh

🔍 What it does

sshd -t validates config before restart


🧠 Why critical

Prevents lockout due to misconfiguration



---

🧠 Big Picture Architecture

❌ Weak Setup

Internet → SSH (password, root enabled)

✅ Hardened Setup

Internet → Firewall → Bastion → Private Servers (key-only SSH)


---

🧠 Memorization Trick

> “Keys not passwords, no root, restrict entry, disable extras, monitor always”




---

🔥 Production Blueprint (What you should actually do)

Minimum:

Disable root

Disable passwords

Use ed25519 keys

Enable Fail2Ban

Restrict via firewall


Advanced:

Bastion host

Private network only

SSH certificate auth (Vault/CA)



---

🚀 Real Example Scenario

Your FastAPI server:

1. Only allow your IP:



ufw allow from YOUR_IP to any port 22

2. Disable password login


3. Use key:



ssh -i key.pem ubuntu@server

4. Monitor:



journalctl -u ssh -f


---

Way forward:

🔐 SSH Certificate-based auth (like AWS IAM but for SSH)

🔑 Vault dynamic SSH access (temporary credentials)

🚫 Completely removing SSH using cloud-native access (SSM / Azure Bastion)