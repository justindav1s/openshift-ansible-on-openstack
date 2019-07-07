#!/usr/bin/env bash


ansible-playbook -v -i hosts.3.11.aio \
   /usr/share/ansible/openshift-ansible/playbooks/deploy_cluster.yml \
   -e openshift_logging_install_logging=False \
   -e openshift_metrics_install_metrics=False
