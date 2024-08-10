
## The `mirrorlist.centos.org` no longer resolves. 

Certainly! Here's an explanation of the process and the changes made:

### **Issue**
The repository URL `mirrorlist.centos.org` is no longer resolving, meaning the system can't find or access the CentOS mirrors for updating and installing packages.

### **Solution Steps**

1. **Update Repository URLs**
   The repositories are updated to point to `vault.centos.org` instead of `mirror.centos.org`, and the protocol is switched from HTTP to HTTPS for better security. This is done using the `sed` command to edit all `.repo` files in the `/etc/yum.repos.d/` directory.

   - **Replace the base URL**:
     ```bash
     sed -i s/mirror.centos.org/vault.centos.org/g /etc/yum.repos.d/*.repo
     ```
     This command updates the repository URL from `mirror.centos.org` to `vault.centos.org` in all `.repo` files.

   - **Switch from HTTP to HTTPS**:
     ```bash
     sed -i s/^#.*baseurl=http/baseurl=https/g /etc/yum.repos.d/*.repo
     ```
     This command ensures that the `baseurl` lines in the repository files use HTTPS instead of HTTP.

   - **Comment out mirrorlist lines**:
     ```bash
     sed -i s/^mirrorlist=http/#mirrorlist=https/g /etc/yum.repos.d/*.repo
     ```
     This command comments out any `mirrorlist` lines that use HTTP, ensuring that only HTTPS URLs are used.

2. **Error Encountered**
   After updating the repository URLs, running `yum upgrade -y` produced the following error:

   ```
   failure: repodata/repomd.xml from base: [Errno 256] No more mirrors to try.
   http://vault.centos.org/centos/7/os/x86_64/repodata/repomd.xml: [Errno 14] HTTPS Error 301 - Moved Permanently
   ```

   This error indicates that the URL used for the repository has been redirected or moved permanently (HTTP Error 301). The system was trying to access a resource via an outdated URL that is no longer valid.

3. **Temporary Workaround**
   To bypass SSL certificate verification issues (which might be causing the redirect error), the following line was added to `/etc/yum.conf`:

   ```bash
   echo "sslverify=false" >> /etc/yum.conf
   ```

   This line disables SSL certificate verification, allowing `yum` to proceed with connections even if there are issues with SSL certificates or HTTPS connections.

### **Summary**
The problem was addressed by updating repository URLs to use HTTPS and pointing to `vault.centos.org`. An additional adjustment was made to disable SSL verification to handle issues with HTTPS redirection. This ensures that the package manager can continue to update and install software despite changes in repository URLs and SSL issues.
