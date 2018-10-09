#!/usr/bin/env bash


nohup ansible-playbook -i hosts.3.10 \
   /usr/share/ansible/openshift-ansible/playbooks/openshift-metrics/config.yml \
   -e openshift_metrics_install_metrics=True \
   > metrics.log &

sleep 5

tail -f metrics.log