#!/usr/bin/env bash

rm -rf ../ansible/*.retry

ansible-playbook -vv -i ../ansible/inventory/hosts ../ansible/cloud.yml

