#!/usr/bin/env bash

rm -rf ../ansible/*.retry

nohup ansible-playbook  -i ../ansible/inventory ../ansible/base_server_config.yml  > base_server_config.log 2>&1 &

sleep 5

tail -f base_server_config.log