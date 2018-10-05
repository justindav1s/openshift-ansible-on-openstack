Setup PCI-passthrough for NVIDIA device

https://www.server-world.info/en/note?os=CentOS_7&p=kvm&f=10

Openstack config changes

https://gist.github.com/claudiok/890ab6dfe76fa45b30081e58038a9215

set metadata in your IMAGE :
img_hide_hypervisor_id='true'

Guest setup

subscription-manager register --username=?? --password=??
subscription-manager attach --pool=<poolid>
subscription-manager repos --disable=rhel-7-server-htb-rpms
subscription-manager repos --enable=rhel-7-server-optional-rpms
subscription-manager repos --enable=rhel-7-server-extras-rpms
sudo rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum update -y
yum -y groupinstall "Development Tools"
yum install -y pciutils dkms kernel-devel

Install the driver

./NVIDIA-Linux-x86_64-390.87.run 

Allow it to manage nouveau removal for you, as that works
 