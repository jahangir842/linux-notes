### `neigh` Command in Linux (`ip neigh`)

The `neigh` (short for **neighbor**) command is part of the `ip` command suite, specifically used to manage and view **neighbor objects**, such as ARP (Address Resolution Protocol) entries in IPv4 and **Neighbor Discovery Protocol (NDP)** entries in IPv6. These objects map network layer addresses (e.g., IP addresses) to link-layer addresses (e.g., MAC addresses) on a local network, facilitating communication between devices.

This command effectively replaces older tools like `arp` for managing ARP tables in IPv4 networks and also works for neighbor entries in IPv6.

#### Key Concepts:
- **Neighbor Objects**: Devices on the local network whose link-layer (MAC) address must be resolved for communication.
- **ARP (Address Resolution Protocol)**: Used in IPv4 to map IP addresses to MAC addresses.
- **NDP (Neighbor Discovery Protocol)**: The equivalent of ARP for IPv6, which resolves IPv6 addresses to MAC addresses.

#### Basic Syntax:
```bash
ip neigh [OPTIONS] COMMAND [arguments]
```

- **COMMAND**: Specifies the action to take (e.g., show, add, delete).
- **arguments**: The specific details such as IP address, MAC address, and interface.

### Common Commands and Options

1. **View Neighbor (ARP/NDP) Table**:
   ```bash
   ip neigh show
   ```
   - This displays the current ARP (IPv4) or NDP (IPv6) entries for all interfaces.
   - Example output:
     ```bash
     192.168.1.1 dev eth0 lladdr 00:11:22:33:44:55 REACHABLE
     fe80::1 dev eth0 lladdr 00:11:22:33:44:55 router STALE
     ```
     - **192.168.1.1**: IP address of the neighbor.
     - **eth0**: Interface where this entry exists.
     - **lladdr 00:11:22:33:44:55**: The MAC address (link-layer address) of the neighbor.
     - **REACHABLE/STALE**: The state of the ARP entry.

   **IPv4 ARP Example**:
   ```bash
   ip neigh show
   ```
   **IPv6 NDP Example**:
   ```bash
   ip -6 neigh show
   ```

2. **View Neighbor Entries for a Specific Interface**:
   To show neighbor entries for a specific network interface (e.g., `eth0`):
   ```bash
   ip neigh show dev eth0
   ```

   This filters the neighbor table for a specific interface, like `eth0`.

3. **Add a Static Neighbor Entry**:
   You can manually add a static ARP entry using:
   ```bash
   sudo ip neigh add 192.168.1.100 lladdr 00:11:22:33:44:55 dev eth0
   ```
   - **192.168.1.100**: The IP address of the device.
   - **lladdr 00:11:22:33:44:55**: The MAC address of the device.
   - **dev eth0**: The interface where the neighbor resides.

4. **Delete a Neighbor Entry**:
   To delete an ARP/NDP entry from the neighbor table:
   ```bash
   sudo ip neigh del 192.168.1.100 dev eth0
   ```
   This command removes the entry associated with the IP address `192.168.1.100` on the `eth0` interface.

5. **Modify an Existing Neighbor Entry**:
   To modify or update the MAC address for an existing IP address entry:
   ```bash
   sudo ip neigh change 192.168.1.100 lladdr 00:11:22:33:44:56 dev eth0
   ```
   This changes the MAC address of the device to `00:11:22:33:44:56`.

6. **Flush the Neighbor Table**:
   To flush (clear) all entries in the neighbor table:
   ```bash
   sudo ip neigh flush all
   ```
   This will remove all ARP (or NDP) entries from the cache.

### Neighbor Entry States
The `ip neigh` command provides a list of states that indicate the status of a neighbor entry:

1. **REACHABLE**: The neighbor is reachable, and its address is confirmed.
2. **STALE**: The entry hasn’t been used recently, and its state is unconfirmed.
3. **DELAY**: The system is delaying the sending of probes to confirm the neighbor.
4. **PROBE**: The system is actively sending probes to confirm the neighbor.
5. **FAILED**: The neighbor has failed to respond, and its address resolution failed.
6. **NOARP**: No ARP resolution is needed (common for certain link types).
7. **PERMANENT**: A static neighbor entry, usually added manually.

### Examples

- **View all neighbor entries (IPv4 and IPv6)**:
  ```bash
  ip neigh show
  ```

- **View neighbor entries for a specific interface**:
  ```bash
  ip neigh show dev eth0
  ```

- **Add a static ARP entry**:
  ```bash
  sudo ip neigh add 192.168.1.10 lladdr 00:11:22:33:44:55 dev eth0
  ```

- **Delete a specific ARP entry**:
  ```bash
  sudo ip neigh del 192.168.1.10 dev eth0
  ```

- **Flush all entries in the neighbor table**:
  ```bash
  sudo ip neigh flush all
  ```

### Use Cases

- **Network Troubleshooting**: The `ip neigh` command can help diagnose network issues related to ARP/NDP resolution, especially if there are connectivity issues between devices on the local network.
  
- **Static ARP Entries**: You can add static ARP entries to improve security (e.g., for critical infrastructure devices) and prevent ARP spoofing attacks.

- **Performance**: Static entries can be used to reduce the overhead of dynamic ARP requests for frequently accessed devices.

### Conclusion

The `ip neigh` command is a versatile and modern tool for managing ARP (IPv4) and NDP (IPv6) entries on Linux systems. It is part of the `iproute2` package and is commonly used in place of older commands like `arp`. This command allows for more detailed control over network neighbor entries and provides useful features for troubleshooting, static entry configuration, and managing both IPv4 and IPv6 neighbors.
