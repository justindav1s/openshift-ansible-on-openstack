#!/usr/bin/env bash

rm -rf ../ansible/*.retry

ansible-playbook  -i ../ansible/inventory ../ansible/build_ocp_infra.yml