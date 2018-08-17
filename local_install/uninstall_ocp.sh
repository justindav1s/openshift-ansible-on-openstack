#!/usr/bin/env bash


ansible-playbook  -i hosts.minimal1 \
    /usr/share/ansible/openshift-ansible/playbooks/adhoc/uninstall.yml