#!/usr/bin/env bash

TESTPROJECT=tasks-test
PRODPROJECT=tasks-prod

oc project ${TESTPROJECT}

oc create -f ../openshift-tasks/app-template.yaml
oc create -f ../openshift-tasks/pipeline-bc.yaml

oc new-app docker-buildconfig \
    -p S2I_IMAGESTREAM=${IMAGE} \
    -p ENVIRONMENT_NAME=${ENV} \
    -p APPLICATION_TYPE=${APPLICATION_TYPE} \
    -p SOURCE_REPOSITORY_URL="https://github.com/justindav1s/simple-java-service.git" \

