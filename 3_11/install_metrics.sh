#!/usr/bin/env bash


ansible-playbook -i hosts.3.11.singleinstance \
   /usr/share/ansible/openshift-ansible/playbooks/openshift-metrics/config.yml \
   -e openshift_metrics_install_metrics=True