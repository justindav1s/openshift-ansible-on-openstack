#!/usr/bin/env bash


echo "Updating Router"
ansible-playbook -i /root/bin/inventory \
    /usr/share/ansible/openshift-ansible/playbooks/common/openshift-cluster/redeploy-certificates/router.yml


echo "Updating Registry"
ansible-playbook -i /root/bin/inventory \
    /usr/share/ansible/openshift-ansible/playbooks/common/openshift-cluster/redeploy-certificates/registry.yml