#!/usr/bin/env bash


nohup ansible-playbook -i hosts.3.10 \
   /usr/share/ansible/openshift-ansible/playbooks/deploy_cluster.yml \
   > install.log &

sleep 5

tail -f install.log