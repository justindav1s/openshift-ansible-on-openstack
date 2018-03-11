#!/usr/bin/env bash

USER=client1
PROJECT=${USER}-project

oc login https://master1.swlon.local:8443 -u justin

oc delete user ${USER}
oc delete identity htpasswd_auth:${USER}
oc delete project ${PROJECT}
oc process -f pinned-project-request-template.yaml \
    -p PROJECT_NAME=${PROJECT} \
    -p PROJECT_ADMIN_USER=${USER} \
    -p PROJECT_REQUESTING_USER=${USER} \
    -p NODE_SELECTOR="${USER}=true" | oc create -f - 2> /dev/null

while [ $? \> 0 ]; do
    sleep 1
    printf "."
    oc process -f pinned-project-request-template.yaml \
    -p PROJECT_NAME=${PROJECT} \
    -p PROJECT_ADMIN_USER=${USER} \
    -p PROJECT_REQUESTING_USER=${USER} \
    -p NODE_SELECTOR="${USER}=true" | oc create -f - 2> /dev/null
done

oc process -f user-template.yaml -p USERNAME=${USER} | oc create -f -

oc process -f pinned-project-request-template.yaml \
    -p PROJECT_NAME=${PROJECT} \
    -p PROJECT_ADMIN_USER=${USER} \
    -p PROJECT_REQUESTING_USER=${USER} \
    -p NODE_SELECTOR="${USER}=true" | oc create -f -

oc process -f role-binding-template.yaml -v USERNAME=${USER} | oc create --namespace=${PROJECT} -f -