#!/usr/bin/env bash

#rm -rf ../ansible/*.retry

ansible-playbook  -i ../ansible/inventory ../ansible/server_config.yml