### Detailed Notes on the `ip addr` Command

The `ip addr` command is a powerful tool in the `iproute2` suite used for managing IP addresses on network interfaces in Linux. It allows you to view, add, and remove IP addresses, and provides detailed information about the network interfaces and their IP configurations.

#### **1. Basic Syntax**
The basic syntax for the `ip addr` command is:

```bash
ip addr [ COMMAND ] [ OPTIONS ]
```

- **COMMAND**: The specific action you want to perform, such as `show`, `add`, `del`, etc.
- **OPTIONS**: Optional flags that modify the behavior of the command, such as specifying an interface or an IP address.

#### **2. Common Commands**

##### **2.1. `ip addr show`**
The `ip addr show` command displays the IP addresses assigned to network interfaces.

- **Display all IP addresses:**
  ```bash
  ip addr show
  ```

- **Display IP addresses for a specific interface:**
  ```bash
  ip addr show dev <interface_name>
  ```

- **Display only IPv4 or IPv6 addresses:**
  ```bash
  ip -4 addr show
  ip -6 addr show
  ```

- **Display IP addresses with more detailed information:**
  ```bash
  ip -s addr show
  ```

**Example Output:**

```bash
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:34:12:56 brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.100/24 brd 192.168.1.255 scope global dynamic enp0s3
       valid_lft 86387sec preferred_lft 86387sec
    inet6 fe80::a00:27ff:fe34:1256/64 scope link
       valid_lft forever preferred_lft forever
```

##### **2.2. `ip addr add`**
The `ip addr add` command is used to assign a new IP address to a network interface.

- **Add an IPv4 address:**
  ```bash
  ip addr add <ip_address>/<prefix_length> dev <interface_name>
  ```

- **Add an IPv6 address:**
  ```bash
  ip -6 addr add <ipv6_address>/<prefix_length> dev <interface_name>
  ```

- **Add a secondary IP address:**
  ```bash
  ip addr add <ip_address>/<prefix_length> dev <interface_name> label <interface_name>:1
  ```

**Example:**

```bash
ip addr add 192.168.1.10/24 dev enp0s3
```

##### **2.3. `ip addr del`**
The `ip addr del` command is used to remove an IP address from a network interface.

- **Remove an IPv4 address:**
  ```bash
  ip addr del <ip_address>/<prefix_length> dev <interface_name>
  ```

- **Remove an IPv6 address:**
  ```bash
  ip -6 addr del <ipv6_address>/<prefix_length> dev <interface_name>
  ```

**Example:**

```bash
ip addr del 192.168.1.10/24 dev enp0s3
```

##### **2.4. `ip addr flush`**
The `ip addr flush` command removes all IP addresses from a network interface.

- **Flush all IP addresses on an interface:**
  ```bash
  ip addr flush dev <interface_name>
  ```

- **Flush only IPv4 or IPv6 addresses:**
  ```bash
  ip -4 addr flush dev <interface_name>
  ip -6 addr flush dev <interface_name>
  ```

**Example:**

```bash
ip addr flush dev enp0s3
```

##### **2.5. `ip addr replace`**
The `ip addr replace` command adds a new IP address if it doesn't exist, or replaces an existing one.

- **Replace an IP address:**
  ```bash
  ip addr replace <ip_address>/<prefix_length> dev <interface_name>
  ```

**Example:**

```bash
ip addr replace 192.168.1.10/24 dev enp0s3
```

##### **2.6. `ip addr show label`**
The `ip addr show label` command is used to display IP addresses associated with a specific label on an interface.

- **Show IP addresses with a specific label:**
  ```bash
  ip addr show dev <interface_name> label <label_name>
  ```

**Example:**

```bash
ip addr show dev enp0s3 label enp0s3:1
```

#### **3. Advanced Usage**

##### **3.1. Managing Multiple IP Addresses on a Single Interface**
You can assign multiple IP addresses to a single interface by using labels or just adding additional addresses.

- **Add a secondary IP address:**
  ```bash
  ip addr add 192.168.1.11/24 dev enp0s3 label enp0s3:1
  ```

- **List all IP addresses on an interface:**
  ```bash
  ip addr show dev enp0s3
  ```

##### **3.2. Setting Up IP Address Aliases**
IP address aliases allow you to assign multiple IP addresses to the same network interface.

- **Add an alias IP address:**
  ```bash
  ip addr add 192.168.1.12/24 dev enp0s3 label enp0s3:2
  ```

- **Remove an alias IP address:**
  ```bash
  ip addr del 192.168.1.12/24 dev enp0s3
  ```

##### **3.3. Configuring Link-Local Addresses**
Link-local addresses are used for communication within the local network segment.

- **Add a link-local IPv6 address:**
  ```bash
  ip -6 addr add fe80::1/64 dev enp0s3
  ```

- **View link-local addresses:**
  ```bash
  ip -6 addr show dev enp0s3 scope link
  ```

#### **4. Common Options**

- **`-4` or `-6`**: Restrict the command to IPv4 or IPv6 addresses.
  ```bash
  ip -4 addr show
  ip -6 addr show
  ```

- **`-s` or `-stats`**: Display more detailed statistics for each address.
  ```bash
  ip -s addr show
  ```

#### **5. Summary**

The `ip addr` command is an essential tool for network management in Linux. It provides detailed control over the IP addresses assigned to your network interfaces, including the ability to view, add, delete, and manage multiple IP addresses on a single interface. Whether you are configuring a simple static IP or managing complex multi-homed systems, `ip addr` is a vital part of your networking toolkit.