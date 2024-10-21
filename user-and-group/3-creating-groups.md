### Managing Local Group Accounts

#### Objectives
By the end of this section, you should be able to:
- Create local groups.
- Modify local group properties.
- Delete local groups.
- Change group memberships for users.

---

### Managing Local Groups
Groups in Linux allow the organization of users to collectively manage permissions for files and other system resources. Before adding users to a group, the group must first be created.

---

### Creating Groups from the Command Line
1. **Basic Group Creation**:
   - Use the `groupadd` command to create a new group. By default, the system assigns the next available GID from the range specified in `/etc/login.defs`.
   ```bash
   sudo groupadd group_name
   ```

2. **Specify Group ID (GID)**:
   - Use the `-g` option to manually set a GID when creating a group.
   ```bash
   sudo groupadd -g 10000 group01
   ```

3. **System Group Creation**:
   - Use the `-r` option to create a system group with a GID from the system GID range. This is typically used for internal processes.
   ```bash
   sudo groupadd -r group02
   ```

---

### Modifying Existing Groups from the Command Line

1. **Rename a Group**:
   - Use the `groupmod -n` option to change the name of an existing group.
   ```bash
   sudo groupmod -n new_group_name old_group_name
   ```

2. **Change Group ID (GID)**:
   - Use the `-g` option to change the GID of an existing group.
   ```bash
   sudo groupmod -g 20000 group_name
   ```

---

### Deleting Groups from the Command Line

- Use `groupdel` to delete an existing group. The group cannot be deleted if it is the primary group of any user.
  ```bash
  sudo groupdel group_name
  ```

**Note**: Before deleting a group, ensure that no files on the system remain owned by that group. Files owned by deleted groups can cause security issues.

---

### Changing Group Membership from the Command Line

1. **Change User's Primary Group**:
   - Use `usermod -g` to change the primary group of a user.
   ```bash
   sudo usermod -g group_name username
   ```

2. **Add User to Supplementary Groups**:
   - Use `usermod -aG` to add a user to a supplementary group. The `-a` option ensures the user is added without losing membership in other groups.
   ```bash
   sudo usermod -aG group_name username
   ```

**Example**:
```bash
# Check current group membership
id user03

# Add user to 'group01'
sudo usermod -aG group01 user03

# Verify updated group membership
id user03
```

**Important**: If the `-a` option is not used, the user will be removed from any existing supplementary groups not mentioned in the `-G` option.
