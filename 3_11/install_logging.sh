#!/usr/bin/env bash


nohup ansible-playbook -i hosts.3.11 \
   /usr/share/ansible/openshift-ansible/playbooks/openshift-logging/config.yml \
   > logging.log &

sleep 5

tail -f logging.log