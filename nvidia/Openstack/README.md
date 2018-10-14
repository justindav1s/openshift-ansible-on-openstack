Setup PCI-passthrough for NVIDIA device

https://www.server-world.info/en/note?os=CentOS_7&p=kvm&f=10

Openstack config changes

https://gist.github.com/claudiok/890ab6dfe76fa45b30081e58038a9215

set metadata in your IMAGE :

img_hide_hypervisor_id = 'yes'

set metadata on FLAVOUR

pci_passthrough:alias = 'gtx1050:1'

```
[root@openstack ~]# diff /etc/nova/nova.conf.pre_nvidia /etc/nova/nova.conf
6c6,7
< 
---
> pci_alias = { "vendor_id":"10de", "product_id":"1c82", "device_type":"type-PCI", "name":"gtx1050" }
> pci_passthrough_whitelist = { "vendor_id": "10de", "product_id": "1c82" }
4913c4914
< enabled_filters=RetryFilter,AvailabilityZoneFilter,RamFilter,DiskFilter,ComputeFilter,ComputeCapabilitiesFilter,ImagePropertiesFilter,ServerGroupAntiAffinityFilter,ServerGroupAffinityFilter,CoreFilter
---
> enabled_filters=RetryFilter,AvailabilityZoneFilter,RamFilter,DiskFilter,ComputeFilter,ComputeCapabilitiesFilter,ImagePropertiesFilter,ServerGroupAntiAffinityFilter,ServerGroupAffinityFilter,CoreFilter,PciPassthroughFilter
```

Guest setup
```
subscription-manager register --username=?? --password=??
subscription-manager attach --pool=<poolid>
subscription-manager repos --disable=rhel-7-server-htb-rpms
subscription-manager repos --enable=rhel-7-server-optional-rpms
subscription-manager repos --enable=rhel-7-server-extras-rpms
sudo rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum update -y
yum -y groupinstall "Development Tools"
yum install -y pciutils dkms kernel-devel


cat <<EOF > /usr/lib/modprobe.d/nvidia-installer-disable-nouveau.conf
blacklist nouveau
options nouveau modeset=0
EOF

cat <<EOF > /etc/modprobe.d/nvidia-installer-disable-nouveau.conf
blacklist nouveau
options nouveau modeset=0
EOF

mv /boot/initramfs-$(uname -r).img /boot/initramfs-$(uname -r)-nouveau.img

dracut /boot/initramfs-$(uname -r).img $(uname -r)

reboot
```

Install the driver

./NVIDIA-Linux-x86_64-390.87.run 

Install Cuda

wget https://developer.nvidia.com/compute/cuda/10.0/Prod/local_installers/cuda_10.0.130_410.48_linux

Don't install the NVIDIA driver, you've already done that. Cuda will complain, ignore it.

Install OCP

Follow this for details of docker and device plugin config

https://blog.openshift.com/how-to-use-gpus-with-deviceplugin-in-openshift-3-10/
 
