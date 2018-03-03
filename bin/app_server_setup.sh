#!/usr/bin/env bash

rm -rf ../ansible/*.retry

ansible-playbook  -i inventory ../ansible/server_config.yml