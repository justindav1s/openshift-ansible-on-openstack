#!/usr/bin/env bash

USER=client1

oc login https://master1.swlon.local:8443 -u justin

oc delete user ${USER}
oc delete identity htpasswd_auth:${USER}
