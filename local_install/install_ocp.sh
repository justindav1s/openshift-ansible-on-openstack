#!/usr/bin/env bash


ansible-playbook -i hosts.v3.9.localhost \
   /usr/share/ansible/openshift-ansible/playbooks/prerequisites.yml

ansible-playbook -i hosts.v3.9.localhost \
   /usr/share/ansible/openshift-ansible/playbooks/deploy_cluster.yml