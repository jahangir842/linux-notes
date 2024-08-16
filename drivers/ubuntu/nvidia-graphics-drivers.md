https://ubuntu.com/server/docs/nvidia-drivers-installation#nvidia-drivers-releases

**check the drivers**

```
ubuntu-drivers list
```

### NVIDIA drivers releases 
NVIDIA package two types of NVIDIA drivers:

    **Unified Driver Architecture (UDA) drivers** - which are recommended for the generic desktop use, and which you can also find on the NVIDIA website.

    **Enterprise Ready Drivers (ERD)** - which are recommended on servers and for computing tasks. Their packages can be recognised by the -server suffix. You can read more about these drivers in the NVIDIA documentation.


### Check driver versions

To check the version of your currently running driver:
```
cat /proc/driver/nvidia/version
```

### Check Configuration

cat /lib/modprobe.d/nvidia-graphics-drivers.conf

The output will be like this:
```
blacklist nouveau
blacklist lbm-nouveau
alias nouveau off
alias lbm-nouveau off
```




