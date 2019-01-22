#!/usr/bin/env bash


ansible-playbook -i hosts.3.11 \
	/usr/share/ansible/openshift-ansible/playbooks/redeploy-certificates.yml
