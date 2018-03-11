#!/usr/bin/env bash

TESTPROJECT=tasks-test
PRODPROJECT=tasks-prod

oc delete project $TESTPROJECT
oc new-project $TESTPROJECT 2> /dev/null
while [ $? \> 0 ]; do
    sleep 1
    printf "."
    oc new-project $TESTPROJECT 2> /dev/null
done

oc delete project $PRODPROJECT
oc new-project $PRODPROJECT 2> /dev/null
while [ $? \> 0 ]; do
    sleep 1
    printf "."
    oc new-project $PRODPROJECT 2> /dev/null
done

oc policy add-role-to-group system:image-puller system:serviceaccounts:${PRODPROJECT} -n ${TESTPROJECT}

rm -rf ../openshift-tasks

git clone https://github.com/OpenShiftDemos/openshift-tasks.git ../openshift-tasks

oc project ${TESTPROJECT}

oc new-app jenkins-persistent

sleep 5

oc policy add-role-to-user edit system:serviceaccount:${TESTPROJECT}:jenkins -n ${TESTPROJECT}

