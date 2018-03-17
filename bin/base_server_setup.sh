#!/usr/bin/env bash

rm -rf ../ansible/*.retry

ansible-playbook  -i ../ansible/inventory ../ansible/base_server_config.yml