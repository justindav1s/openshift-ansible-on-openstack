#!/usr/bin/env bash


ansible-playbook -i ../ansible/inventory/hosts ../ansible/teardown_network.yaml
ansible-playbook -i ../ansible/inventory/hosts ../ansible/teardown_project.yaml
