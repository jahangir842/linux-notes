---
### Lock Kubernetes Versions:


## Method 1: Through Repo

1. **Add Kubernetes Repository**
  This overwrites any existing configuration in /etc/yum.repos.d/kubernetes.repo

  ```bash
  cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
  [kubernetes]
  name=Kubernetes
  baseurl=https://pkgs.k8s.io/core:/stable:/v1.32/rpm/
  enabled=1
  gpgcheck=1
  gpgkey=https://pkgs.k8s.io/core:/stable:/v1.32/rpm/repodata/repomd.xml.key
  exclude=kubelet kubeadm kubectl cri-tools kubernetes-cni
  EOF
  ```

**Note:** The last line in repositoy prevents updates to the listed packages when running dnf update, ensuring that the installed Kubernetes version remains unchanged.

2. **Install Kubernetes Components**

   ```bash
   sudo yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
   sudo systemctl enable --now kubelet
   ```
**Note:** `--disableexcludes=kubernetes` Temporarily overrides the exclude setting in kubernetes.repo, allowing the installation of these packages. 

---
 
## Method 2: Through dnf commands 

To prevent Kubernetes from updating on AlmaLinux:  

1. **Lock Kubernetes version:**  
   ```bash
   sudo dnf install -y dnf-plugins-core
   sudo dnf versionlock add kubelet kubeadm kubectl containerd.io
   ```

2. **Exclude from updates (Alternative):**  
   Add this to `/etc/dnf/dnf.conf`:  
   ```
   exclude=kubelet kubeadm kubectl
   ```

3. **Verify lock:**  
   ```bash
   sudo dnf versionlock list
   ```

Now, `dnf update` won’t update Kubernetes. ✅
