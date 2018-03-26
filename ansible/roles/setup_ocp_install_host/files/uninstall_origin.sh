#!/usr/bin/env bash


ansible-playbook  -i /root/bin/inventory \
    /root/openshift-ansible/playbooks/adhoc/uninstall.yml