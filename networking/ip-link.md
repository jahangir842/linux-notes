The `ip link` command is part of the `ip` command suite in Linux, which is used for network management. Specifically, `ip link` is used to display and modify network interface information.

### Usage of `ip link` Command

- **Display Information:**
  - Running `ip link` without any arguments will display information about all the network interfaces on the system, such as their name, MAC address, MTU (Maximum Transmission Unit), and status (up or down).
  
  ```bash
  ip link
  ```

  **Example Output:**
  ```bash
  1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
      link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
  2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP mode DEFAULT group default qlen 1000
      link/ether 08:00:27:34:12:56 brd ff:ff:ff:ff:ff:ff
  ```

  - `lo` is the loopback interface.
  - `enp0s3` is a typical Ethernet interface.

- **Bring an Interface Up or Down:**
  - To bring a network interface up (activate it):
  
  ```bash
  ip link set dev <interface_name> up
  ```

  - To bring a network interface down (deactivate it):

  ```bash
  ip link set dev <interface_name> down
  ```

  **Example:**
  ```bash
  ip link set dev enp0s3 up
  ip link set dev enp0s3 down
  ```

- **Change MTU (Maximum Transmission Unit):**
  - You can change the MTU size for a network interface using the following command:

  ```bash
  ip link set dev <interface_name> mtu <mtu_size>
  ```

  **Example:**
  ```bash
  ip link set dev enp0s3 mtu 1400
  ```

- **Change MAC Address:**
  - To change the MAC address of a network interface:

  ```bash
  ip link set dev <interface_name> address <new_mac_address>
  ```

  **Example:**
  ```bash
  ip link set dev enp0s3 address 00:11:22:33:44:55
  ```

### Practical Examples

1. **Display Network Interfaces:**
   ```bash
   ip link
   ```
   This command lists all network interfaces and their current states.

2. **Bring Down the Ethernet Interface:**
   ```bash
   ip link set dev enp0s3 down
   ```
   This command deactivates the `enp0s3` network interface.

3. **Bring Up the Ethernet Interface:**
   ```bash
   ip link set dev enp0s3 up
   ```
   This command reactivates the `enp0s3` network interface.

4. **Change the MTU of a Network Interface:**
   ```bash
   ip link set dev enp0s3 mtu 1400
   ```
   This command sets the MTU of the `enp0s3` network interface to 1400 bytes.

5. **Change the MAC Address of an Interface:**
   ```bash
   ip link set dev enp0s3 address 00:11:22:33:44:55
   ```
   This command assigns a new MAC address to the `enp0s3` network interface.

### Summary

The `ip link` command is a powerful tool for managing and configuring network interfaces in Linux. It allows you to view, modify, and manage the state and configuration of network interfaces on your system.
