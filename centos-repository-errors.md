
## The `mirrorlist.centos.org` no longer resolves. 

To address this, I followed @mlazarov's advice to update the repository files, but instead of using HTTP, I switched to HTTPS:

```bash
sed -i s/mirror.centos.org/vault.centos.org/g /etc/yum.repos.d/*.repo
sed -i s/^#.*baseurl=http/baseurl=https/g /etc/yum.repos.d/*.repo
sed -i s/^mirrorlist=http/#mirrorlist=https/g /etc/yum.repos.d/*.repo
```

After making these changes, running `yum upgrade -y` resulted in the following error:

```
failure: repodata/repomd.xml from base: [Errno 256] No more mirrors to try.
http://vault.centos.org/centos/7/os/x86_64/repodata/repomd.xml: [Errno 14] HTTPS Error 301 - Moved Permanently
```

To resolve this, I added the following line to `/etc/yum.conf`:

```bash
echo "sslverify=false" >> /etc/yum.conf
```

--- 

This version clarifies the steps taken and the error encountered.
