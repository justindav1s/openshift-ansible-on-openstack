#!/usr/bin/env bash

USER=client1

oc login https://master1.swlon.local:8443 -u justin

oc process -f user-template.yaml \
    -p USERNAME=${USER} \
    -p LEVEL=standard | oc create -f -
