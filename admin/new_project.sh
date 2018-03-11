#!/usr/bin/env bash

USER=client1
PROJECT=${USER}-project

oc login https://master1.swlon.local:8443 -u justin

oc process -f pinned-project-request-template.yaml \
    -p PROJECT_NAME=${PROJECT} \
    -p PROJECT_ADMIN_USER=${USER} \
    -p PROJECT_REQUESTING_USER=${USER} \
    -p NODE_SELECTOR="${USER}=true" | oc create -f -