### Detailed Notes on the `ip tunnel` Command

The `ip tunnel` command is part of the `iproute2` suite in Linux and is used to manage network tunnels. Tunnels are virtual network interfaces that encapsulate packets within another packet, allowing the transport of data across different networks, possibly with different protocols. Tunnels are commonly used in Virtual Private Networks (VPNs) and to connect different subnets across the internet.

#### **1. Basic Syntax**

The basic syntax for the `ip tunnel` command is:

```bash
ip tunnel { add | change | del | show | prl | 6rd } [ options ]
```

- **add**: Create a new tunnel.
- **change**: Modify an existing tunnel.
- **del**: Delete an existing tunnel.
- **show**: Display information about existing tunnels.
- **prl**: Manage the Prefix Routing List for 6to4 tunnels.
- **6rd**: Manage 6rd (IPv6 Rapid Deployment) tunnels.

#### **2. Common Tunnel Types**

##### **2.1. GRE (Generic Routing Encapsulation) Tunnel**
GRE is a tunneling protocol that encapsulates a wide variety of network layer protocols inside virtual point-to-point links.

- **Create a GRE Tunnel:**
  ```bash
  ip tunnel add <tunnel_name> mode gre local <local_ip> remote <remote_ip> ttl <time_to_live>
  ```

  **Example:**
  ```bash
  ip tunnel add gre1 mode gre local 192.168.1.1 remote 192.168.2.1 ttl 255
  ```

- **Activate the GRE Tunnel:**
  ```bash
  ip link set <tunnel_name> up
  ```

  **Example:**
  ```bash
  ip link set gre1 up
  ```

- **Delete a GRE Tunnel:**
  ```bash
  ip tunnel del <tunnel_name>
  ```

  **Example:**
  ```bash
  ip tunnel del gre1
  ```

##### **2.2. SIT (Simple Internet Transition) Tunnel**
SIT is used for IPv6 over IPv4 tunneling, commonly used in 6to4 and 6in4 tunnels.

- **Create a SIT Tunnel:**
  ```bash
  ip tunnel add <tunnel_name> mode sit local <local_ipv4> remote <remote_ipv4>
  ```

  **Example:**
  ```bash
  ip tunnel add sit1 mode sit local 192.168.1.1 remote 192.168.2.1
  ```

- **Set the Tunnel’s IPv6 Address:**
  ```bash
  ip addr add <ipv6_address>/<prefix> dev <tunnel_name>
  ```

  **Example:**
  ```bash
  ip addr add 2001:db8::1/64 dev sit1
  ```

- **Activate the SIT Tunnel:**
  ```bash
  ip link set <tunnel_name> up
  ```

  **Example:**
  ```bash
  ip link set sit1 up
  ```

- **Delete a SIT Tunnel:**
  ```bash
  ip tunnel del <tunnel_name>
  ```

  **Example:**
  ```bash
  ip tunnel del sit1
  ```

##### **2.3. IPIP (IP-in-IP) Tunnel**
IPIP is a simple protocol that encapsulates one IPv4 packet within another IPv4 packet.

- **Create an IPIP Tunnel:**
  ```bash
  ip tunnel add <tunnel_name> mode ipip local <local_ip> remote <remote_ip>
  ```

  **Example:**
  ```bash
  ip tunnel add ipip1 mode ipip local 192.168.1.1 remote 192.168.2.1
  ```

- **Activate the IPIP Tunnel:**
  ```bash
  ip link set <tunnel_name> up
  ```

  **Example:**
  ```bash
  ip link set ipip1 up
  ```

- **Delete an IPIP Tunnel:**
  ```bash
  ip tunnel del <tunnel_name>
  ```

  **Example:**
  ```bash
  ip tunnel del ipip1
  ```

##### **2.4. VTI (Virtual Tunnel Interface)**
VTI is used for creating virtual interfaces that can be used with IPsec to support dynamic routing protocols over encrypted tunnels.

- **Create a VTI Tunnel:**
  ```bash
  ip tunnel add <tunnel_name> mode vti local <local_ip> remote <remote_ip> key <key>
  ```

  **Example:**
  ```bash
  ip tunnel add vti1 mode vti local 192.168.1.1 remote 192.168.2.1 key 42
  ```

- **Assign an IP Address to the VTI Interface:**
  ```bash
  ip addr add <ip_address>/<prefix> dev <tunnel_name>
  ```

  **Example:**
  ```bash
  ip addr add 10.0.0.1/24 dev vti1
  ```

- **Activate the VTI Tunnel:**
  ```bash
  ip link set <tunnel_name> up
  ```

  **Example:**
  ```bash
  ip link set vti1 up
  ```

- **Delete a VTI Tunnel:**
  ```bash
  ip tunnel del <tunnel_name>
  ```

  **Example:**
  ```bash
  ip tunnel del vti1
  ```

#### **3. Common Options**

- **`mode <mode>`**: Specifies the tunnel mode (`gre`, `sit`, `ipip`, `vti`, etc.).
- **`local <local_ip>`**: Specifies the local IP address of the tunnel endpoint.
- **`remote <remote_ip>`**: Specifies the remote IP address of the tunnel endpoint.
- **`ttl <time_to_live>`**: Specifies the Time to Live value for packets sent through the tunnel.
- **`key <key>`**: Specifies the key for VTI tunnels.

#### **4. Managing Tunnels**

##### **4.1. Display Tunnel Information**
You can display information about existing tunnels using the `show` command.

- **Show All Tunnels:**
  ```bash
  ip tunnel show
  ```

- **Show Specific Tunnel:**
  ```bash
  ip tunnel show <tunnel_name>
  ```

##### **4.2. Change Tunnel Parameters**
You can change parameters of an existing tunnel using the `change` command.

- **Change Tunnel TTL:**
  ```bash
  ip tunnel change <tunnel_name> ttl <time_to_live>
  ```

- **Example:**
  ```bash
  ip tunnel change gre1 ttl 128
  ```

#### **5. Use Cases**

- **VPN Setup:** GRE, IPIP, and VTI tunnels are commonly used in VPN setups for securely connecting remote networks.
- **IPv6 Deployment:** SIT tunnels are often used to transition from IPv4 to IPv6 networks.
- **Routing Protocols over IPsec:** VTI tunnels are used in conjunction with IPsec to enable dynamic routing over encrypted tunnels.

#### **6. Summary**

The `ip tunnel` command is a versatile tool for creating and managing various types of network tunnels in Linux. These tunnels enable advanced networking configurations, such as connecting remote networks, encapsulating different protocols, and transitioning between IPv4 and IPv6. Understanding the different tunnel modes and their appropriate use cases is essential for network engineers and administrators working in complex environments.