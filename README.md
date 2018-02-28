# Openstack
Assorted adventures with Openstack

Using Packstack :

https://www.rdoproject.org/install/packstack/


Make sure you have loads of room in /var as that is where cinder volumes

take note of your nic mac address and the interface name asigned by your OS.

All this was done on Centos 7

Switch off NetworkManager and use the oldstyle network services.
Switch off SELinux.

mac : 30:3c:23:5f:f3:16
interface : enp0s31f6 

vi /etc/sysconfig/network-scripts/ifcfg-enp0s31f6

TYPE=Ethernet
BOOTPROTO=dhcp
ONBOOT=yes
DEFROUTE=yes
IPV4_FAILURE_FATAL=no
IPV6INIT=yes
IPV6_AUTOCONF=yes
IPV6_DEFROUTE=yes
IPV6_FAILURE_FATAL=no
NAME=enp0s31f6
HWADDR=30:9c:23:5e:f3:16
PEERDNS=yes
IPV6_PEERDNS=yes
IPV6_PEERROUTES=yes

vi /etc/sysconfig/network

NETWORKING=yes
HOSTNAME=justin-centos7
GATEWAY=192.168.0.1

vi /etc/sysconfig/selinux
reboot

sestatus
systemctl disable firewalld
systemctl stop firewalld
systemctl disable NetworkManager
systemctl stop NetworkManager
reboot

systemctl enable network
systemctl start network

test network

systemctl enable sshd
systemctl start sshd

yum install -y centos-release-openstack-pike
yum-config-manager --enable openstack-pike
yum update -y
yum install -y openstack-packstack

packstack --allinone --provision-demo=n --os-neutron-ovs-bridge-mappings=extnet:br-ex --os-neutron-ovs-bridge-interfaces=br-ex:eth0 --os-neutron-ml2-type-drivers=vxlan,flat --cinder-volumes-size=500G

[root@localhost ~]# vi /etc/sysconfig/network-scripts/ifcfg-br-ex
DEVICE=br-ex
DEVICETYPE=ovs
TYPE=OVSBridge
BOOTPROTO=static
IPADDR=192.168.0.13
 
NETMASK=255.255.255.0
GATEWAY=192.168.0.1
DNS1=192.168.0.1
ONBOOT=yes

vi /etc/sysconfig/network-scripts/ifcfg-enp0s31f6

TYPE=Ethernet
BOOTPROTO=dhcp
ONBOOT=yes
DEFROUTE=yes
IPV4_FAILURE_FATAL=no
IPV6INIT=yes
IPV6_AUTOCONF=yes
IPV6_DEFROUTE=yes
IPV6_FAILURE_FATAL=no
NAME=enp0s31f6
HWADDR=30:9c:23:5e:f3:16
PEERDNS=yes
IPV6_PEERDNS=yes
IPV6_PEERROUTES=yes

to

DEVICE=enp0s31f6
TYPE=OVSPort
DEVICETYPE=ovs
OVS_BRIDGE=br-ex
ONBOOT=yes

Useful links : 

https://ask.openstack.org/en/question/56257/failed-to-intialize-kvm-hypervisor-permission-denied/
https://docs.openstack.org/cinder/queens/admin/blockstorage-manage-volumes.html
https://opstadmin.wordpress.com/2016/05/08/cinder-default-configuration-by-applied-by-packstack/
https://www.youtube.com/watch?v=Udtr1zJhcrw
https://youtu.be/eOlIB323c8s


fix network issues with cloud-init
cd /etc/neutron/
vi dhcp_agent.ini

set this :

enable_isolated_metadata= true

then
 
systemctl restart neutron-dhcp-agent.service

ssl console issues
https://ask.openstack.org/en/question/6192/horizon-unable-to-view-vnc-console-in-iframe-with-ssl/
