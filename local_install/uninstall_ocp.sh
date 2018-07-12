#!/usr/bin/env bash


ansible-playbook  -i hosts \
    /usr/share/ansible/openshift-ansible/playbooks/adhoc/uninstall.yml