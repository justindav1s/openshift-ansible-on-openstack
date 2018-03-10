#!/usr/bin/env bash


ssh root@master1.swlon.datr.eu "oc login -u system:admin; sleep 1; oc adm policy add-cluster-role-to-user cluster-admin justin"