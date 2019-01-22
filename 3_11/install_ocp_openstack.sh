#!/usr/bin/env bash

#unset OS_SERVICE_TOKEN
#export OS_USERNAME=admin
#export OS_PASSWORD='0ac534048f04404c'
#export OS_AUTH_URL=http://192.168.0.13:5000/v3
#export PS1='[\u@\h \W(keystone_admin)]\$ '
#export OS_PROJECT_NAME=admin
#export OS_USER_DOMAIN_NAME=Default
#export OS_PROJECT_DOMAIN_NAME=Default
#export OS_IDENTITY_API_VERSION=3

nohup ansible-playbook -i hosts.3.11.openstack \
   /usr/share/ansible/openshift-ansible/playbooks/deploy_cluster.yml \
   -e openshift_logging_install_logging=False \
   -e openshift_metrics_install_metrics=False \
   > install.log &

sleep 5

tail -f install.log
