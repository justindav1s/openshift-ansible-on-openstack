#!/usr/bin/env bash

NFS_HOST=nfs.swlon.local
NFS_ROOT=/exports

oc login https://ocp.datr.eu:8443 --insecure-skip-tls-verify=true -u justin

PV_STUB=pv

for i in {1..50}; do
	PV_NAME=$PV_STUB$i
	oc delete pv $PV_NAME
	ssh root@$NFS_HOST "rm -rf $NFS_ROOT/$PV_NAME"
done

oc get pv