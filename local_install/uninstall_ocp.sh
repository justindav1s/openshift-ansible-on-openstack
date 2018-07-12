#!/usr/bin/env bash


ansible-playbook  -i hosts.rhel7 \
    /usr/share/ansible/openshift-ansible/playbooks/adhoc/uninstall.yml