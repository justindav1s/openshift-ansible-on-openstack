#!/usr/bin/env bash

rm -rf ../ansible/*.retry

ansible-playbook  -vvvv -i ../ansible/inventory ../ansible/create_key_pair.yml