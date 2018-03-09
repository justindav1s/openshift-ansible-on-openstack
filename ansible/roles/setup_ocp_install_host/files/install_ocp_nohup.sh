#!/usr/bin/env bash


nohup ansible-playbook -i /root/bin/inventory \
    /usr/share/ansible/openshift-ansible/playbooks/byo/config.yml > install.log 2>&1 &

sleep 5

tail -f install.log