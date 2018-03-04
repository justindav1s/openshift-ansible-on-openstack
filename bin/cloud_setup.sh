#!/usr/bin/env bash

rm -rf ../ansible/*.retry

ansible-playbook  -i ../ansible/inventory/hosts ../ansible/cloud.yml