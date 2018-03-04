#!/usr/bin/env bash

rm -rf ../ansible/*.retry

ansible-playbook  -i ../ansible/inventory ../ansible/servers_from_snapshots.yml