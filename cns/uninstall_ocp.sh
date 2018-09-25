#!/usr/bin/env bash


ansible-playbook  -i hosts.3.10 \
    /usr/share/ansible/openshift-ansible/playbooks/adhoc/uninstall.yml