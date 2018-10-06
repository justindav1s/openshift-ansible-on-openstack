#!/usr/bin/env bash


oc login -u system:admin

sleep 1

oc adm policy add-cluster-role-to-user cluster-admin justin