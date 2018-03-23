#!/usr/bin/env bash


ansible-playbook -i /root/bin/inventory \
    /usr/share/ansible/openshift-ansible/playbooks/byo/openshift-cluster/openshift-prometheus.ymll