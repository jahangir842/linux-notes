- https://github.com/dirk-thomas/vcstool
- https://wiki.ros.org/vcstool

### `vcstool` in ROS 2

**`vcstool`** is a command-line tool used primarily in **ROS 2** for managing multiple version control (VCS) repositories in a workspace. It provides commands to easily import, update, export, and manage source repositories, especially when you're working with multiple ROS packages that are maintained in different version control systems (VCS) like Git, Mercurial, or Subversion.

Here’s a summary of `vcstool` and its key features:

---

### **What is `vcstool`?**

- **`vcstool`** is a tool designed to handle version control for multiple repositories within a ROS 2 workspace.
- It supports various version control systems like **Git**, **Mercurial**, and **Subversion**.
- It makes it easier to manage dependencies across multiple repositories in a ROS 2 workspace by allowing bulk operations like cloning, updating, and exporting repositories.
- **`vcstool`** works in tandem with the ROS 2 workspace structure, where multiple ROS 2 packages are organized in a `src/` directory, each of which may be in a separate Git repository, for example.

---

### **Main Features and Commands of `vcstool`**

1. **Importing Repositories**:
   - You can import multiple repositories into your workspace using a `.repos` file (a YAML-based file that lists all the repositories you want to work with).
   - Example:
     ```bash
     vcs import src < my_repositories.repos
     ```
     This command will download and check out all the repositories listed in the `my_repositories.repos` file into the `src/` directory of your workspace.

2. **Updating Repositories**:
   - `vcstool` makes it easy to update all repositories to their latest versions with one simple command.
   - Example:
     ```bash
     vcs update
     ```
     This command will pull the latest changes from all repositories that are part of your workspace.

3. **Exporting Repositories**:
   - You can export the current state of all the repositories in a workspace to a `.repos` file. This file can then be shared with others to replicate the workspace setup.
   - Example:
     ```bash
     vcs export src > my_workspace.repos
     ```
     This generates a `.repos` file that includes the details of all repositories in your workspace, which can be used later for importing repositories.

4. **Listing Repositories**:
   - If you want to see the repositories currently in your workspace, you can list them with the following command:
   - Example:
     ```bash
     vcs list
     ```
     This will list all the repositories within the `src/` directory of the workspace.

5. **Removing Repositories**:
   - If you no longer need a repository in your workspace, you can remove it using:
   - Example:
     ```bash
     vcs remove <repo-name>
     ```

6. **Merging Repositories**:
   - You can use `vcstool` to merge repositories from multiple `.repos` files or workspaces.
   - Example:
     ```bash
     vcs merge src < another_workspace.repos
     ```

---

### **Why Use `vcstool` in ROS 2?**

- **Managing Multiple Repositories**: ROS 2 development often involves working with multiple packages, each potentially in a different repository. `vcstool` makes managing these repositories easier.
  
- **Workspace Synchronization**: If you are working in a team or with multiple developers, you can synchronize the workspace by exporting the repository configuration and importing it later.
  
- **Consistent Setup**: Developers can share `.repos` files to set up identical workspaces, which reduces setup time and ensures all developers are working with the same set of repositories and dependencies.
  
- **Cross-VCS Support**: ROS 2 projects may involve repositories using different version control systems (e.g., Git, Mercurial). `vcstool` abstracts away these differences and makes managing these repositories easier.

---

### **Installation of `vcstool`**

If `vcstool` is not installed on your system, you can install it using `apt` (on Ubuntu or other Debian-based distributions) or `pip`:

- **Using APT** (recommended for ROS 2 environments):
  ```bash
  sudo apt install python3-vcstool
  ```

- **Using PIP**:
  ```bash
  pip install vcstool
  ```

---

### **Example Workflow with `vcstool`**

1. **Clone multiple repositories into your workspace**:
   - First, you create a `.repos` file that lists the repositories you want to import. Then:
     ```bash
     vcs import src < my_repositories.repos
     ```

2. **Build the workspace**:
   - After importing the repositories, build your workspace with ROS 2 build tool, **`colcon`**:
     ```bash
     colcon build
     ```

3. **Update all repositories**:
   - To pull the latest changes for all repositories:
     ```bash
     vcs update
     ```

4. **Export your workspace's repositories to a `.repos` file**:
   - Once you've made changes, or to share the repository configuration with others:
     ```bash
     vcs export src > updated_workspace.repos
     ```

---

### **Conclusion**

`vcstool` is a powerful and essential utility for managing version control in ROS 2 workspaces. It simplifies tasks like importing, exporting, updating, and maintaining multiple repositories, making it easier to collaborate on complex ROS 2 projects.
