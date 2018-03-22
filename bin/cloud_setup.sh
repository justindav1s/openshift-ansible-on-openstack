#!/usr/bin/env bash

rm -rf ../ansible/*.retry

ansible-playbook  -vvvv -i ../ansible/inventory/hosts ../ansible/cloud.yml
