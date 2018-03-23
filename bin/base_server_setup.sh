#!/usr/bin/env bash

rm -rf ../ansible/*.retry

ansible-playbook  -vv -i ../ansible/inventory ../ansible/build_base_server.yml
sleep 60
ansible-playbook  -vv -i ../ansible/inventory ../ansible/base_server_config.yml