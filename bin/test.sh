#!/usr/bin/env bash

. ~/.bash_profile


ansible-playbook -i ../ansible/inventory/hosts ../ansible/teardown_servers.yaml
ansible-playbook -i ../ansible/inventory/hosts ../ansible/setup_servers.yaml
