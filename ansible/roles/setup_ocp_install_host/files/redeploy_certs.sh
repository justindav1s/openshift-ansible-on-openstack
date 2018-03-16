#!/usr/bin/env bash


echo "Updating Router"
ansible-playbook -i /root/bin/inventory \
    /usr/share/ansible/openshift-ansible/playbooks/byo/openshift-cluster/redeploy-router-certificates.yml


echo "Updating Registry"
ansible-playbook -i /root/bin/inventory \
    /usr/share/ansible/openshift-ansible/playbooks/byo/openshift-cluster/redeploy-registry-certificates.yml