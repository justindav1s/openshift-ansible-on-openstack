#!/usr/bin/env bash

ansible-playbook -i ../ansible/inventory ../ansible/get_addresses.yml

cat /tmp/myhosts
