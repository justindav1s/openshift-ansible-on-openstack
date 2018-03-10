#!/usr/bin/env bash

./teardown.sh
./cloud_setup.sh
./build_ocp_infra.sh
./sync_keys.sh
./docker_config.sh
get_addresses.sh
