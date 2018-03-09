#!/usr/bin/env bash


ansible-playbook  -i /root/bin/inventory \
    /usr/share/ansible/openshift-ansible/playbooks/adhoc/uninstall.yml