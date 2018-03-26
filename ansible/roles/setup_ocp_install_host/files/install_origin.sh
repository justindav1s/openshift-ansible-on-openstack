#!/usr/bin/env bash



ansible-playbook -i /root/bin/inventory \
    /root/openshift-ansible/playbooks/prerequisites.yml

ansible-playbook -i /root/bin/inventory \
    /root/openshift-ansible/playbooks/deploy_cluster.yml