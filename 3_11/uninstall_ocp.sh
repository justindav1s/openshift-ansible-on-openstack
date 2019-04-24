#!/usr/bin/env bash


ansible-playbook  -i hosts.3.11.aio \
    /usr/share/ansible/openshift-ansible/playbooks/adhoc/uninstall.yml
