#!/usr/bin/env bash


ansible-playbook -v -i hosts.3.11.singleinstance \
   /usr/share/ansible/openshift-ansible/playbooks/prerequisites.yml
