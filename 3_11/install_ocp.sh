#!/usr/bin/env bash


nohup ansible-playbook -i hosts.3.11.singleinstance.aws \
   /usr/share/ansible/openshift-ansible/playbooks/deploy_cluster.yml \
   -e openshift_logging_install_logging=False \
   -e openshift_metrics_install_metrics=True \
   > install.log &

sleep 5

tail -f install.log
