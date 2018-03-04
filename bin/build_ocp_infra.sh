#!/usr/bin/env bash

rm -rf ../ansible/*.retry

nohup ansible-playbook  -i ../ansible/inventory ../ansible/build_ocp_infra.yml  > build_ocp_infra.log 2>&1 &

sleep 5

tail -f build_ocp_infra.log