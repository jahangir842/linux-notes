## SSH Jump Host (Bastion Host) – Detailed Notes

### 1. What is an SSH Jump Host

An **SSH Jump Host** (also called a **Bastion Host**) is an intermediate server used to access machines in a **private network that are not directly reachable from the internet**.

Instead of connecting directly to the target server, you connect through a **secure gateway server**.

```
Your Laptop
     │
     │ SSH
     ▼
Jump Host / Bastion (Public IP)
     │
     │ SSH
     ▼
Private Server (No Public IP)
```

This architecture is very common in **cloud environments and secure corporate networks**.

---

# 2. Why Jump Hosts Are Used

### 1. Security

Private servers remain **hidden from the internet**.

Only the bastion host has a public IP.

Example:

```
Internet
   │
   ▼
Bastion Host (public)
   │
   ▼
Private DB Server
Private Application Server
Private Kubernetes Nodes
```

Attack surface becomes **one controlled entry point**.

---

### 2. Network Isolation

Private servers may live in:

* Private subnet
* VPN-only network
* Internal datacenter VLAN

Example:

```
VPC
 ├── Public Subnet
 │      Bastion
 │
 └── Private Subnet
        App Servers
        DB Servers
```

---

### 3. Centralized Access Control

Admins only access servers through one host.

This allows:

* session monitoring
* logging
* MFA
* access policies

---

# 3. SSH Jump Host Using `-J`

Modern OpenSSH supports **ProxyJump** using `-J`.

### Syntax

```bash
ssh -J user@jump_host user@target_host
```

Example:

```bash
ssh -J ubuntu@3.90.120.10 ubuntu@10.0.1.25
```

Flow:

```
Your Computer
      │
      ▼
3.90.120.10  (Jump Host)
      │
      ▼
10.0.1.25  (Target Server)
```

SSH automatically tunnels traffic.

---

# 4. SSH Jump Host with Identity Key

```bash
ssh -i key.pem -J ubuntu@bastion-ip ubuntu@private-ip
```

Example:

```bash
ssh -i aws-key.pem -J ec2-user@54.21.12.90 ec2-user@10.0.2.15
```

---

# 5. Multiple Jump Hosts

Sometimes environments have multiple security layers.

Example architecture:

```
Laptop
  │
  ▼
Jump Host 1
  │
  ▼
Jump Host 2
  │
  ▼
Private Server
```

Command:

```bash
ssh -J user@jump1,user@jump2 user@target
```

Example:

```bash
ssh -J admin@bastion1,admin@bastion2 admin@10.10.1.10
```

---

# 6. SSH Config File Method (Best Practice)

Instead of writing long commands every time, use:

```
~/.ssh/config
```

Example:

```bash
Host bastion
    HostName 54.10.20.30
    User ubuntu
    IdentityFile ~/.ssh/id_rsa

Host private-server
    HostName 10.0.1.20
    User ubuntu
    ProxyJump bastion
```

Now connect with:

```bash
ssh private-server
```

SSH automatically uses the jump host.

---

# 7. Old Method (Before `-J`) Using ProxyCommand

Before OpenSSH 7.3, this was used:

```bash
ssh -o ProxyCommand="ssh -W %h:%p bastion" user@target
```

Example:

```bash
ssh -o ProxyCommand="ssh -W %h:%p ubuntu@54.10.20.30" ubuntu@10.0.1.20
```

Explanation:

```
-W %h:%p
```

means forward traffic to host and port.

But today `-J` is preferred.

---

# 8. Port Forwarding Through Jump Host

You can forward ports through the bastion.

Example: Access private database.

```
Local Machine → Bastion → Database Server
```

Command:

```bash
ssh -L 5432:10.0.1.50:5432 -J ubuntu@bastion ubuntu@private
```

Now connect locally:

```
localhost:5432
```

---

# 9. SSH Jump Host in Cloud Environments

### Amazon Web Services

Common architecture:

```
VPC
│
├── Public Subnet
│     Bastion Host
│
└── Private Subnet
      EC2 Instances
      RDS
```

Access:

```bash
ssh -J ec2-user@bastion ec2-user@private-instance
```

---

### Microsoft Azure Equivalent

Azure calls this concept:

**Azure Bastion**

It allows access to VMs without exposing them publicly.

Equivalent architecture:

```
Azure Bastion
      │
      ▼
Private Virtual Machines
```

---

### Huawei Cloud Equivalent

Huawei Cloud uses:

**ECS Bastion Host**

It performs the same role.

---

### Open Source Alternative

Instead of bastion servers you can use:

* **Teleport**
* **StrongDM**
* **Boundary**
* **OpenSSH Bastion**
* **WireGuard VPN**

---

# 10. Security Best Practices

### 1. Disable password login

```
PasswordAuthentication no
```

Only allow keys.

---

### 2. Restrict allowed users

```
AllowUsers admin devops
```

---

### 3. Enable logging

Monitor:

```
/var/log/auth.log
```

---

### 4. Use MFA

Tools like:

* Duo Security
* Google Authenticator
* Teleport

---

### 5. Use Fail2ban

Blocks brute force attempts.

---

### 6. Rotate SSH Keys

Regular key rotation reduces risk.

---

# 11. Example Real DevOps Environment

Example company infrastructure:

```
Internet
   │
   ▼
Bastion Host (Public)
   │
   ├── Kubernetes Master
   ├── Kubernetes Workers
   ├── Database Servers
   └── Internal Services
```

Connection flow:

```
Laptop
   │
ssh bastion
   │
ssh internal servers
```

Or directly:

```bash
ssh -J bastion worker-node
```

---

# 12. SSH Jump Host with Ansible (Very Important for DevOps)

In Ansible inventory:

```ini
[servers]
app1 ansible_host=10.0.1.10
app2 ansible_host=10.0.1.11

[servers:vars]
ansible_user=ubuntu
ansible_ssh_common_args='-o ProxyJump=ubuntu@bastion'
```

Now run:

```bash
ansible servers -m ansible.builtin.ping
```

Ansible automatically uses the jump host.

---

# 13. Advantages of SSH Jump Hosts

| Benefit        | Explanation                          |
| -------------- | ------------------------------------ |
| Security       | Private servers hidden from internet |
| Central Access | One entry point                      |
| Monitoring     | All access logged                    |
| Control        | Easy user management                 |
| Compliance     | Meets many security policies         |

---

# 14. Disadvantages

| Problem                 | Explanation                     |
| ----------------------- | ------------------------------- |
| Single point of failure | If bastion fails, access breaks |
| Maintenance             | Needs patching                  |
| Performance             | Slight extra hop                |

---

# 15. Memorization Trick

Think:

```
J = Jump
B = Bastion
```

Flow:

```
You → Jump → Target
```

Or visualize:

```
Laptop → Gateway → Private Server
```

---

