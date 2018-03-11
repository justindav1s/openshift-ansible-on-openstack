# Openstack
## Assorted adventures with Openstack

### Using Packstack :

https://www.rdoproject.org/install/packstack/

Make sure you have loads of room in /var as that is where cinder volumes

take note of your nic mac address and the interface name asigned by your OS.

All this was done on Centos 7

Switch off NetworkManager and use the oldstyle network services.

Switch off SELinux.

mac : 30:3c:23:5f:f3:16

interface : enp0s31f6 

vi /etc/sysconfig/network-scripts/ifcfg-enp0s31f6
```
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
```

vi /etc/sysconfig/network

```
NETWORKING=yes
HOSTNAME=justin-centos7
GATEWAY=192.168.0.1
```


vi /etc/sysconfig/selinux

set : 

SELINUX=disabled

reboot

```
sestatus

systemctl enable sshd
systemctl start sshd
systemctl disable firewalld
systemctl stop firewalld
systemctl disable NetworkManager
systemctl stop NetworkManager
systemctl enable network
systemctl start network
```

reboot

test network


```
yum install -y centos-release-openstack-pike
yum-config-manager --enable openstack-pike
yum update -y
yum install -y openstack-packstack
```

run packstack with these settings for the network bridge to your own network, and a larger area for Cinder

If you want to setup SSL/TLS on the Horizon web console :

``` 
packstack --allinone \
    --provision-demo=n \
    --os-neutron-ovs-bridge-mappings=extnet:br-ex \
    --os-neutron-ovs-bridge-interfaces=br-ex:eth0 \
    --os-neutron-ml2-type-drivers=vxlan,flat \
    --cinder-volumes-size=1000G \
    --os-horizon-ssl=y
```

If you fo this you'll need to add your certs to : /etc/httpd/conf.d/15-horizon_ssl_vhost.conf

and if not : 

```
packstack --allinone \
    --provision-demo=n \
    --os-neutron-ovs-bridge-mappings=extnet:br-ex \
    --os-neutron-ovs-bridge-interfaces=br-ex:eth0 \
    --os-neutron-ml2-type-drivers=vxlan,flat \
    --cinder-volumes-size=1000G
```

Configure network bride that will integrate with you wider LAN

```
vi /etc/sysconfig/network-scripts/ifcfg-br-ex

add : 

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

delete : 

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

replace with :

DEVICE=enp0s31f6
TYPE=OVSPort
DEVICETYPE=ovs
OVS_BRIDGE=br-ex
ONBOOT=yes
```

If you are running on centos7 you need to make this change to allow VMs to be created :

```
vi /etc/neutron/dhcp_agent.ini

change :

enable_isolated_metadata=False

to 

enable_isolated_metadata=true

```


Install shade on the Openstack server, and also on your laptop. Ansible requires shade in both places.
```
wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py 
pip install shade
```

**Now REBOOT !**


#### Useful links : 

https://ask.openstack.org/en/question/56257/failed-to-intialize-kvm-hypervisor-permission-denied/

https://docs.openstack.org/cinder/queens/admin/blockstorage-manage-volumes.html

https://opstadmin.wordpress.com/2016/05/08/cinder-default-configuration-by-applied-by-packstack/

https://www.youtube.com/watch?v=Udtr1zJhcrw

https://youtu.be/eOlIB323c8s

ssl console issues
https://ask.openstack.org/en/question/6192/horizon-unable-to-view-vnc-console-in-iframe-with-ssl/


## Openstack with Ansible

This is a bit complicated, you can't just point ansible and your openstack setup and expect it to work. 

You need to configure the server(s) that host open stack.

Firstly shade needs to be deployed.

https://docs.openstack.org/shade/latest/

Shade seen to act as a bridge between ansible and open stack. 

In order for shade to work it need to know how and what to authenticate with, to do that, this is used : 

https://pypi.python.org/pypi/os-client-config

If you run your playbooks as root you need to provide the follwing file in root's $HOME :

/root/.config/openstack/clouds.yaml

Heres an example of what the file needs to contain :

```
clouds:
  default:
    auth:
      auth_url: https://<identity.example.com>:5000/v3
      password: <password>
      project_name: admin
      username: admin
      user_domain_name: default
      project_domain_name: default
    region_name: RegionOne
  openshift_cloud:
    auth:
      auth_url: https://<identity.example.com>:5000/v3
      password: <password>
      project_name: openshift
      username: openshift
      user_domain_name: default
      project_domain_name: default
    region_name: RegionOne    
ansible:
  use_hostnames: True
  expand_hostvars: False
  fail_on_errors: True    
```

This defines a cloud called "default", the name "default" is arbitrary, it's simply a tag to group credentials and be used in playbooks.
The data in this file is used by shade/os-client-config to authenticate with your Openstack setup. There are other ways to provide this data.
You can define an "auth" section in each of your ansible tasks, like so :


```
- hosts: openstack-server
  vars:
      auth_dict:
        password: <password>
        auth_url: http://<identity host>:5000/v3
        username: admin
        project_name: admin
        user_domain_name: default
        project_domain_name: default
  remote_user: justin
  become: yes
  become_method: sudo
  tasks:
  - os_project:
      auth: "{{ auth_dict }}"
      state: present
      name: demoproject
```

Also apparently Ansible also respects the Environmental variable that are defined here : 

https://wiki.openstack.org/wiki/OpenStackClient/Authentication.

If you choose the clouds.yaml method, which I prefer as your credentials are secure on the server behind ssh, then the above playbook reduces to : 

```asciidoc
- hosts: openstack-server
  remote_user: justin
  become: yes
  become_method: sudo
  tasks:
  - os_project:
      cloud: default
      state: present
      name: demoproject
```

Where "cloud: default" simply references the "default" cloud defined in clouds.yaml above. But your cloud could be called anything ....

After you've done all this, the os_* modules mostly work as documented, with the exception of things performed in identity domain, managing users and projects.

So this works :

```
- hosts: openstack-server
  remote_user: justin
  become: yes
  become_method: sudo
  tasks:
  - name: create project
    os_project:
      cloud: default
      endpoint_type: admin
      state: present
      name: openshift
```      

This does not : 

```
- hosts: openstack-server
  remote_user: justin
  become: yes
  become_method: sudo
  tasks:
  - name: create project
    os_project:
      cloud: default
      state: present
      name: openshift
```
  
For these kinds of activity "endpoint_type: admin" must be included. This is however NOT required when creating servers eg :

```
- hosts: openstack-server
  vars:
  remote_user: justin
  become: yes
  become_method: sudo
  tasks:
  - name: Create a new instance and attaches to a network
    os_server:
      state: present
      cloud: default
      name: vm1
      image: "RHEL 7.4"
      key_name: kp1
      timeout: 200
      flavor: "m1.small"
      security_groups: default
      nics:
        - net-name: "admin-internal"
```   

Now lets setup some infrastructure on which to deploy Openshift ......... (see the ansible folder)  


## Ansible run list.

There are a bunch of scripts in the bin directory, run them in this order :


- cloud_setup.sh  
    - this sets up users, projects, immges, flavours and the network in openstack
- base_server_setup.sh 
    - this updates an configures  a RHEL instance so that it is ready to have OCP installed, and thsnapshots it. Tis is opional on ly do it the first time through these instructions, then save the image for later use. 
- build_ocp_infra.sh 
    - this uses the snapshot image from above to build out as many servers as are required
- sync_keys.sh
    - syncs ssh keys and config across all servers
- docker_config.sh
    - install, setups and configures docker storage  
- get_addresses.sh
    - gets addresses of all servers in our openstack cloud and generates a hosts file for dnsmasq
    - copy the hosts output to ansible/roles/dnsmasq/files/etc/dnsmasq.hosts, then run setup_dnsmasq.sh
- setup_dnsmasq.sh
    - makes sure that dnsmasq in installed started/enabled and copies dnsmasq.hosts to /etc/dnsmasq.hosts on the opstack server, that serves as or DNS
- setup_bastion.sh
    copies Openshifts hosts file and some help fulscripts to the bastion's /root/bin directory
    
     
Then do the Openshift install from /root/bin/install_ocp.sh on the Bastion

### Setting up Openshift Admin

From the root user on the openshift-master :

- oc login -u system:admin
- oc adm policy add-cluster-role-to-user cluster-admin justin

#### Openshift Uninstall
ansible-playbook -i inventory /usr/share/ansible/openshift-ansible/playbooks/adhoc/uninstall.yml

#### DNS setup:

A DNS server is required somewhere on the network. This repo roles an playbooks to distribute zone files to the server.


## Openshift-tasks CICD work flow

See : https://github.com/justindav1s/openshift-tasks

1. run setup.sh script, this sets up project, jenkins with persistent storage, policy
2. in Jenkins create a new item of type "Pipeline"
    - inside specify "pipline from scm"
    - add openshift-tasks repo
    - specify script path as "jenkinsfile1"
3. run build.sh script, 
    - this loads the openshift-tasks template
    - and instanciates with with values that act as hooks used by the jenkins workflow
    - sets up autoscaling
4. go back to Jenkins job, press the "build now button",
    - this should trigger a local build and unit test
    - followed by an openshift s2i build
    - deployment of that build 
  

## Dedicated Node setup

1. setup AdmissionControl plugin :

```
admissionConfig:
  pluginConfig:
    ProjectRequestLimit:
      configuration:
        apiVersion: v1
        kind: ProjectRequestLimitConfig
        limits:
        - selector:
            level: admin 
        - maxProjects: 1
    BuildDefaults:
      configuration:
        apiVersion: v1  .............

```

    - restart master :
        - systemctl restart atomic-openshift-master-api atomic-openshift-master-controllers

2. disable project self-provisioning

```
oadm policy remove-cluster-role-from-group self-provisioner system:authenticated system:authenticated:oauth
```

2. create users, client1 and client2 on all masters
    - as root htpasswd /etc/origin/master/htpasswd client1
    - as root htpasswd /etc/origin/master/htpasswd client2
        

    
## Quick ansible one liners

#### All the facts about a host
ansible -i ../ansible/inventory infra1.swlon.datr.eu -u cloud-user -m setup

#### Reboot all hosts
ansible -i ../ansible/inventory all -m command -a "reboot"

#### Ping all hosts
ansible -i ../ansible/inventory all -m ping       
 



