### Detailed Notes on the `ip route` Command

The `ip route` command is part of the `ip` command suite in Linux and is used to display and manipulate the kernel's IP routing tables. This command is a powerful tool for managing and configuring how packets are routed within and between networks.

#### **1. Basic Syntax**
The basic syntax for the `ip route` command is:

```bash
ip route [ OPTIONS ] COMMAND [ ARGUMENTS ]
```

- **COMMAND**: The specific operation you want to perform (e.g., `add`, `del`, `show`, `flush`).
- **OPTIONS**: Optional flags that modify the behavior of the command.

#### **2. Common Commands**

##### **2.1. `ip route show`**
Displays the current routing table.

- **Display the main routing table:**
  ```bash
  ip route show
  ```

- **Display routes for a specific network:**
  ```bash
  ip route show <network>/<prefix>
  ```
  **Example:**
  ```bash
  ip route show 192.168.1.0/24
  ```

- **Display routes for a specific protocol family (IPv4 or IPv6):**
  ```bash
  ip -4 route show
  ip -6 route show
  ```

##### **2.2. `ip route add`**
Adds a new route to the routing table.

- **Add a route to a specific network:**
  ```bash
  ip route add <network>/<prefix> via <gateway_ip> dev <interface_name>
  ```
  **Example:**
  ```bash
  ip route add 192.168.2.0/24 via 192.168.1.1 dev enp0s3
  ```

- **Add a default gateway (default route):**
  ```bash
  ip route add default via <gateway_ip> dev <interface_name>
  ```
  **Example:**
  ```bash
  ip route add default via 192.168.1.1 dev enp0s3
  ```

- **Add a route for a specific source address:**
  ```bash
  ip route add <network>/<prefix> via <gateway_ip> src <source_ip> dev <interface_name>
  ```
  **Example:**
  ```bash
  ip route add 10.10.10.0/24 via 192.168.1.1 src 10.10.10.1 dev enp0s3
  ```

##### **2.3. `ip route delete`**
Deletes a route from the routing table.

- **Delete a specific route:**
  ```bash
  ip route del <network>/<prefix> via <gateway_ip> dev <interface_name>
  ```
  **Example:**
  ```bash
  ip route del 192.168.2.0/24 via 192.168.1.1 dev enp0s3
  ```

- **Delete the default route:**
  ```bash
  ip route del default
  ```

##### **2.4. `ip route replace`**
Replaces an existing route or adds it if it does not exist.

- **Replace a route (or add it if it does not exist):**
  ```bash
  ip route replace <network>/<prefix> via <gateway_ip> dev <interface_name>
  ```
  **Example:**
  ```bash
  ip route replace 192.168.2.0/24 via 192.168.1.1 dev enp0s3
  ```

##### **2.5. `ip route flush`**
Flushes routes from the routing table, effectively clearing them.

- **Flush all routes:**
  ```bash
  ip route flush table main
  ```

- **Flush routes matching a specific criteria:**
  ```bash
  ip route flush <network>/<prefix>
  ```
  **Example:**
  ```bash
  ip route flush 192.168.2.0/24
  ```

##### **2.6. `ip route get`**
Gets the route an IP packet would take to reach a specific destination.

- **Get the route to a specific destination:**
  ```bash
  ip route get <destination_ip>
  ```
  **Example:**
  ```bash
  ip route get 8.8.8.8
  ```

- **Get the route from a specific source to a destination:**
  ```bash
  ip route get <destination_ip> from <source_ip>
  ```
  **Example:**
  ```bash
  ip route get 8.8.8.8 from 192.168.1.10
  ```

#### **3. Advanced Features**

##### **3.1. Policy Routing**
Policy routing allows routing decisions to be based on policies other than just the destination address. 

- **Add a policy routing rule to use a specific table:**
  ```bash
  ip rule add from <source_ip> table <table_number>
  ```
  **Example:**
  ```bash
  ip rule add from 192.168.1.10 table 100
  ```

- **View all policy routing rules:**
  ```bash
  ip rule show
  ```

- **Delete a policy routing rule:**
  ```bash
  ip rule del from <source_ip>
  ```

##### **3.2. Equal-Cost Multi-Path (ECMP) Routing**
ECMP allows for load balancing across multiple paths with the same cost.

- **Add multiple routes for ECMP:**
  ```bash
  ip route add <network>/<prefix> nexthop via <gateway1_ip> nexthop via <gateway2_ip>
  ```
  **Example:**
  ```bash
  ip route add 192.168.2.0/24 nexthop via 192.168.1.1 nexthop via 192.168.1.2
  ```

##### **3.3. Multipath Routing**
Multipath routing allows you to define multiple gateways for a route.

- **Add a multipath route:**
  ```bash
  ip route add <network>/<prefix> nexthop via <gateway1> nexthop via <gateway2>
  ```
  **Example:**
  ```bash
  ip route add 192.168.2.0/24 nexthop via 192.168.1.1 nexthop via 192.168.1.2
  ```

#### **4. Common Options**

- **`dev <interface_name>`**: Specifies the interface to use for the route.
  ```bash
  ip route add 192.168.2.0/24 dev enp0s3
  ```

- **`via <gateway_ip>`**: Specifies the next-hop gateway for the route.
  ```bash
  ip route add 192.168.2.0/24 via 192.168.1.1
  ```

- **`table <table_name>`**: Specifies the routing table to use or modify.
  ```bash
  ip route add 192.168.2.0/24 table main
  ```

- **`metric <value>`**: Sets the metric for the route, which influences the priority of the route.
  ```bash
  ip route add 192.168.2.0/24 via 192.168.1.1 metric 100
  ```

- **`src <source_ip>`**: Specifies the source address for the route.
  ```bash
  ip route add 192.168.2.0/24 via 192.168.1.1 src 192.168.1.10
  ```

#### **5. Summary**

The `ip route` command is a fundamental tool for network management in Linux, allowing you to display, add, modify, and delete routes within the kernel routing table. Its versatility makes it essential for managing both simple and complex network environments, including policy-based routing, multipath routing, and advanced route management features. Understanding and mastering `ip route` can significantly enhance your ability to manage and troubleshoot network-related issues in Linux.