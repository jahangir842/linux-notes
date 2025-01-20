### Sensitivity Levels in SELinux

In SELinux (Security-Enhanced Linux), sensitivity levels are a core part of the **Multi-Level Security (MLS)** model. These levels are used to classify the sensitivity of information and processes, enforcing strict access control policies based on these classifications.

The primary goal of sensitivity levels is to prevent unauthorized access to data by users or processes that do not have the required clearance or permission. This mechanism is especially useful in environments that require stringent security, such as military, government, or high-security enterprises.

### Key Concepts

1. **Sensitivity Level**:
   - The **sensitivity level** is part of the SELinux security context, represented by a label in the format `s0`, `s1`, `s2`, etc.
   - It defines the **security classification** of data or processes, indicating the **degree of sensitivity** or **confidentiality** associated with them.
   - The levels can range from `s0` (lowest) to `s15` (highest). The exact range can vary depending on the system configuration and security policy.

2. **MLS (Multi-Level Security)**:
   - MLS is a model that extends the basic DAC (Discretionary Access Control) and MAC (Mandatory Access Control) models used by SELinux.
   - It defines multiple levels of security for different resources (e.g., files, processes) in a system, ensuring that data is only accessible by authorized users or processes based on their security level.

3. **Security Context**:
   - Every process and file in SELinux has an associated **security context** that consists of four components:
     - **User**: Specifies the SELinux user identity.
     - **Role**: Defines the set of permissions a user has on the system.
     - **Type**: Identifies the type or domain of the process or object.
     - **Level**: Defines the **sensitivity level**, which controls access based on the confidentiality of the data.

4. **Structure of a Security Context**:
   The security context is typically written as:
   ```
   user:role:type:level
   ```
   - For example: `system_u:system_r:nfs_t:s0`
     - **User**: `system_u` — SELinux user identity.
     - **Role**: `system_r` — SELinux role.
     - **Type**: `nfs_t` — SELinux type for NFS-related processes.
     - **Level**: `s0` — Sensitivity level.

### Sensitivity Level: `s0` to `s15`

- **`s0`**: The **lowest** security level, meaning the process or object is considered **unclassified** or **public**. This is typically used for general-purpose processes and resources.
- **`s1` to `s14`**: These levels represent increasing sensitivity. As the number increases, so does the restriction placed on access to or from objects with these labels. A process with a higher sensitivity level (e.g., `s5`) would not be able to access a resource with a lower sensitivity level (e.g., `s3`), unless explicitly allowed.
- **`s15`**: The **highest** security level, indicating a **top-secret** or **classified** classification. This level is used for the most sensitive data, such as military secrets or highly confidential business data.

The system's **policy** will specify which users, processes, or systems have access to certain sensitivity levels.

### MLS (Multi-Level Security) Access Rules

The sensitivity level mechanism works in conjunction with the **mandatory access control** policies set in SELinux. The rules governing the interactions between processes and data based on sensitivity levels are generally as follows:

1. **Access to Higher Levels**:
   - A process with a **higher sensitivity level** (`s5`, `s10`, etc.) **can access** files or processes with **lower sensitivity levels** (e.g., `s0`).
   - However, the reverse is **not allowed**—a process with a **lower sensitivity level** cannot access data with a higher sensitivity level.
   
2. **Discretionary Access Control (DAC)**:
   - Even though SELinux uses mandatory access controls based on security contexts and sensitivity levels, **DAC** can also be implemented in SELinux to allow user-driven file permissions.
   - The DAC model is a more flexible model compared to MLS. But if MLS is enabled, the **sensitivity levels** enforce stronger restrictions.

### How Sensitivity Levels are Applied in SELinux

1. **Files and Directories**:
   Files and directories are labeled with sensitivity levels (`s0`, `s1`, etc.). Access to these files is determined by both the **type** and **level** in the file's security context.
   - Example: A file labeled with `s10` can be read by processes labeled with `s10` or higher, but not by processes labeled with `s5` or lower.

2. **Processes**:
   SELinux assigns a sensitivity level to each process. The level defines the process's ability to interact with files, other processes, and network connections. A process with a higher sensitivity level has access to resources of lower sensitivity levels.
   
3. **Role-Based Access Control (RBAC)**:
   In addition to sensitivity levels, **RBAC** assigns roles to users and processes, which determines their ability to access certain types of resources based on their role, rather than their specific security level.

### Security Context Examples

1. **Process Security Context**:
   For a process running as a user (`user_u`), the security context might look like this:
   ```
   user_u:role_r:process_t:s0
   ```
   - **user_u**: User identifier.
   - **role_r**: Role identifier.
   - **process_t**: Process type.
   - **s0**: Sensitivity level (the process has no special classification).

2. **File Security Context**:
   A file labeled with a higher sensitivity level may look like this:
   ```
   system_u:object_r:file_t:s15
   ```
   - **system_u**: User identifier.
   - **object_r**: Role identifier (object or file).
   - **file_t**: File type.
   - **s15**: Highest sensitivity level (classified as top-secret).

### Configuring Sensitivity Levels in SELinux

Sensitivity levels are typically set by the SELinux policy on your system, and the policy may be **configured** or **modified** to specify how processes and files are labeled. Modifying sensitivity levels often requires a change in the **policy files** and reloading them to apply the changes.

### Enabling MLS in SELinux

By default, many Linux distributions with SELinux enabled do **not** use MLS, and the sensitivity level is often set to `s0`. To enable **MLS**, you would need to modify the SELinux policy, which is a more complex task that involves:

1. Modifying the `/etc/selinux/config` file.
2. Setting `SELINUXTYPE=mls` instead of `SELINUXTYPE=targeted`.
3. Rebuilding and reloading the SELinux policy.

Enabling MLS can have a significant impact on the system's security and functionality, so it is typically used only in high-security environments where data classification and confidentiality are critical.

### SELinux Modes and Sensitivity Levels

SELinux operates in different **modes** (Enforcing, Permissive, Disabled), which also impacts how sensitivity levels and access control are enforced:

- **Enforcing Mode**: SELinux policies, including sensitivity levels, are fully enforced. Access violations are denied, and logged.
- **Permissive Mode**: SELinux logs violations but does not enforce policies. This is useful for troubleshooting or testing.
- **Disabled Mode**: SELinux is completely turned off, and no access control is applied.

### Conclusion

The sensitivity level in SELinux is a fundamental part of the **MLS model**, used to label processes and files according to their sensitivity or confidentiality. It is particularly important in environments that require strict security controls, such as military or government applications. Understanding and configuring sensitivity levels allows administrators to fine-tune the security of their systems based on the classification of data and the requirements for confidentiality.

