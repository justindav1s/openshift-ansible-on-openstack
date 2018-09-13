#!/usr/bin/env bash


ansible-playbook  -i hosts.rhte.cns.jd \
    /usr/share/ansible/openshift-ansible/playbooks/adhoc/uninstall.yml