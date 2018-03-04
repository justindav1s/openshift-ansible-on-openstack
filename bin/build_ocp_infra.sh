#!/usr/bin/env bash

rm -rf ../ansible/*.retry

nohup ansible-playbook  -i ../ansible/inventory ../ansible/servers_from_snapshots.yml  > servers_from_snapshots.log 2>&1 &

sleep 5

tail -f servers_from_snapshots.log