#!/usr/bin/env bash


nohup ansible-playbook -vv -i hosts.3.11.singleinstance.aws \
   /usr/share/ansible/openshift-ansible/playbooks/prerequisites.yml \
   > prereqs.log &

sleep 5

tail -f prereqs.log