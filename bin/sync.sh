#!/usr/bin/env bash

rm -rf ../ansible/*.retry

ansible-playbook  -i ./openstack.py ../ansible/sync.yml