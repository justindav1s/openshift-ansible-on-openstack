#!/usr/bin/env bash


nohup ansible-playbook -i hosts.3.10 \
   /usr/share/ansible/openshift-ansible/playbooks/openshift-metrics/config.yml \
   > logging.log &

sleep 5

tail -f logging.log