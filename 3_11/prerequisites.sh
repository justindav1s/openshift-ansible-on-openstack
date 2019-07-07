#!/usr/bin/env bash


ansible-playbook -v -i hosts.3.11.aio \
   /usr/share/ansible/openshift-ansible/playbooks/prerequisites.yml
