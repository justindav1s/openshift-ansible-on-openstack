#!/usr/bin/env bash

. ~/.bash_profile


ansible-playbook -i ../ansible/inventory ../ansible/test.yml
