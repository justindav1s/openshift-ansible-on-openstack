#!/usr/bin/env bash


nohup ansible-playbook -i hosts.3.11 \
   /usr/share/ansible/openshift-ansible/playbooks/openshift-metering/config.yml \
   -e openshift_monitoring_deploy=True \
   > metering.log &

sleep 5

tail -f metering.log
