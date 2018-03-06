#!/usr/bin/env bash

. ~/.bash_profile


ansible-playbook -i ../ansible/inventory ../ansible/get_facts.yml
