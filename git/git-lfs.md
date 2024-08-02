### Git Large File Storage (LFS)

Download the Git LFS installer from the [official website](https://git-lfs.com/).

Download the Git LFS installer from the [official website](https://git-lfs.github.com/).

#### Introduction to Git LFS
Git Large File Storage (LFS) is an extension to Git that improves the handling of large files, such as multimedia files, large datasets, and other binary files that are not well-suited for Git’s versioning and storage mechanisms. Git LFS replaces large files in your repository with text pointers inside Git while storing the large file contents on a remote server.

#### Benefits of Using Git LFS
1. **Optimized Repository Size:** By storing large files outside of the Git repository, the repository size is significantly reduced, leading to faster cloning and fetching operations.
2. **Efficient Storage:** Only the versions of large files that are required are downloaded, saving bandwidth and storage.
3. **Compatibility:** Works with existing Git commands and workflows, making it easy to integrate into current projects.

#### Installing Git LFS
To use Git LFS, you need to install it on your system. The installation process differs based on the operating system you are using.

**For Ubuntu:**
1. Open a terminal.
2. Add the Git LFS package repository:
    ```bash
    curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
    ```
3. Install Git LFS:
    ```bash
    sudo apt-get install git-lfs
    ```

**For other Linux distributions:**
1. For Fedora:
    ```bash
    sudo dnf install git-lfs
    ```

**For macOS:**
1. Using Homebrew:
    ```bash
    brew install git-lfs
    ```

**For Windows:**
1. Download the Git LFS installer from the [official website](https://git-lfs.github.com/).
2. Run the installer and follow the on-screen instructions.

#### Configuring Git LFS
After installing Git LFS, you need to enable it in your Git repository:

1. Initialize Git LFS in your repository:
    ```bash
    git lfs install
    ```

2. Track specific file types with Git LFS. For example, to track all `.psd` files:
    ```bash
    git lfs track "*.psd"
    ```

3. Verify tracking settings:
    ```bash
    cat .gitattributes
    ```

#### Using Git LFS
Once configured, using Git LFS is straightforward and integrates with standard Git commands:

1. **Adding Files:**
    Add files as usual using `git add`:
    ```bash
    git add <large-file>
    ```

2. **Committing Files:**
    Commit the changes:
    ```bash
    git commit -m "Add large file"
    ```

3. **Pushing Changes:**
    Push the changes to the remote repository:
    ```bash
    git push origin main
    ```

4. **Cloning a Repository:**
    When you clone a repository that uses Git LFS, the large files are automatically managed by Git LFS:
    ```bash
    git clone <repository-url>
    ```

#### Managing Git LFS
1. **List Tracked Files:**
    To list all files being tracked by Git LFS in your repository:
    ```bash
    git lfs ls-files
    ```

2. **Fetching LFS Objects:**
    To fetch LFS objects for all checked out files:
    ```bash
    git lfs fetch
    ```

3. **Pulling LFS Objects:**
    To pull LFS objects down:
    ```bash
    git lfs pull
    ```

4. **Pruning Unused LFS Objects:**
    To remove LFS files that are no longer referenced:
    ```bash
    git lfs prune
    ```

#### Example Workflow
Here's an example workflow using Git LFS:

1. **Initialize Git LFS:**
    ```bash
    git lfs install
    ```

2. **Track File Types:**
    ```bash
    git lfs track "*.psd"
    ```

3. **Add and Commit Large Files:**
    ```bash
    git add largefile.psd
    git commit -m "Add large Photoshop file"
    ```

4. **Push to Remote Repository:**
    ```bash
    git push origin main
    ```

5. **Clone Repository:**
    ```bash
    git clone <repository-url>
    ```

By using Git LFS, you can efficiently manage large files in your Git repositories, ensuring that your repository remains performant and manageable.
