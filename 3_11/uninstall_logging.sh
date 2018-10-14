#!/usr/bin/env bash


nohup ansible-playbook -i hosts.3.11 \
   /usr/share/ansible/openshift-ansible/playbooks/openshift-logging/config.yml \
   -e openshift_logging_install_logging=False \
   > logging.log &

sleep 5

tail -f logging.log