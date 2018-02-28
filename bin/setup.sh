#!/usr/bin/env bash


ansible-playbook -i ../ansible/inventory/hosts ../ansible/setup_project.yaml
ansible-playbook -i ../ansible/inventory/hosts ../ansible/setup_network.yaml