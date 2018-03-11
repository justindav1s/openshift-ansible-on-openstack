#!/usr/bin/env bash

git pull

oc delete user client1

oc login https://master1.swlon.local:8443 -u justin

oc process -f user-template.yaml -p USERNAME=client1 | oc create -f -
oc process -f role-binding-template.yaml -v USERNAME=client1 | oc create --namespace=client1_project -f -