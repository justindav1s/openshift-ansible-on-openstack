#!/usr/bin/env bash


oc login https://master1.swlon.local:8443 -u justin

oc process -f user-template.yaml -v USERNAME=client1 | oc create -f -
