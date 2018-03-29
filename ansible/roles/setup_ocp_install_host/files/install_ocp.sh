#!/usr/bin/env bash


ansible-playbook -i /root/bin/inventory \
   /usr/share/ansible/openshift-ansible/playbooks/prerequisites.yml

ansible-playbook -i /root/bin/inventory \
   /usr/share/ansible/openshift-ansible/playbooks/deploy_cluster.yml