#!/usr/bin/env bash

ssh root@master1.swlon.local "systemctl restart atomic-openshift-master-api atomic-openshift-master-controllers"
sleep 5
ssh root@master2.swlon.local "systemctl restart atomic-openshift-master-api atomic-openshift-master-controllers"
sleep 5
ssh root@master3.swlon.local "systemctl restart atomic-openshift-master-api atomic-openshift-master-controllers"

