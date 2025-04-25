### **Domain ID in ROS 2?**
In **ROS 2**, a **Domain ID** is an **integer identifier** that allows multiple ROS 2 networks to operate independently on the same physical network. It is used to **isolate** or **group** different ROS 2 systems so that nodes within the same domain can communicate, while nodes in different domains remain separate.

By default, **ROS 2 nodes communicate using the DDS (Data Distribution Service) middleware**, which is responsible for discovery and communication. The **Domain ID** helps DDS **segregate different ROS 2 instances**, preventing interference between unrelated ROS 2 applications.

---

### **Why is the Domain ID Used?**
1. **Avoiding Cross-Talk Between Systems:**  
   If multiple ROS 2 applications are running on the same network but should not communicate with each other, different Domain IDs ensure that their topics, services, and actions remain separate.

2. **Enabling Multi-Robot Communication:**  
   If you have multiple robots operating in the same environment, assigning different **Domain IDs** allows each robot to have its own communication space.

3. **Testing and Debugging:**  
   Developers may run multiple instances of ROS 2 without interference by using different **Domain IDs**.

---

### **How to Set the Domain ID**
You can set the **ROS_DOMAIN_ID** environment variable to specify a custom domain ID.

#### **Temporary (for the current session)**
```bash
export ROS_DOMAIN_ID=5
```
This sets the **Domain ID** to **5** for the current terminal session.

#### **Permanent (for all sessions)**
Add the following line to `~/.bashrc` or `~/.bash_profile`:
```bash
echo "export ROS_DOMAIN_ID=5" >> ~/.bashrc
source ~/.bashrc
```

---

### **Checking the Current Domain ID**
To check the current **Domain ID**, run:
```bash
echo $ROS_DOMAIN_ID
```
If it is **empty**, it means the default **Domain ID (0)** is being used.

---

### **Example Use Case: Multi-Robot Setup**
Imagine you have two robots in the same physical environment:

- **Robot 1** should use `ROS_DOMAIN_ID=1`
- **Robot 2** should use `ROS_DOMAIN_ID=2`

By setting different Domain IDs, the two robots **won't interfere** with each other’s ROS topics.

#### **On Robot 1:**
```bash
export ROS_DOMAIN_ID=1
ros2 run my_robot_pkg robot_node
```

#### **On Robot 2:**
```bash
export ROS_DOMAIN_ID=2
ros2 run my_robot_pkg robot_node
```
Even though both are running `robot_node`, they operate in **separate ROS 2 domains**.

---

### **Summary**
- **ROS 2 Domain ID** isolates ROS 2 instances to prevent communication overlap.
- Used for **multi-robot systems**, **network isolation**, and **testing**.
- Default **Domain ID is 0**.
- Set using `export ROS_DOMAIN_ID=<ID>`.
