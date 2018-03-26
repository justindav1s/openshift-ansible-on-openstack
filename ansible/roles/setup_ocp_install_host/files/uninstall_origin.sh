#!/usr/bin/env bash


ansible-playbook  -i /root/bin/inventory \
    /root/ansible/openshift-ansible/playbooks/adhoc/uninstall.yml