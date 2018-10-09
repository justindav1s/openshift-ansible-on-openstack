#!/usr/bin/env bash


nohup ansible-playbook -i hosts.3.10 \
   /usr/share/ansible/openshift-ansible/playbooks/openshift-logging/config.yml \
   openshift_logging_install_logging=False \
   > logging.log &

sleep 5

tail -f logging.log