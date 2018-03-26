#!/usr/bin/env bash

NFS_HOST=infra1.swlon.local
NFS_ROOT=/exports

oc login https://ocp.datr.eu:8443 --insecure-skip-tls-verify=true -u justin

PV_STUB=pv

for i in {1..25}; do
	PV_NAME=$PV_STUB$i
	oc delete pv $PV_NAME
	ssh root@$NFS_HOST "rm -rf $NFS_ROOT/$PV_NAME"
	ssh root@$NFS_HOST "truncate -s 0 /etc/exports.d/openshift-uservols.exports"
	ssh root@$NFS_HOST "systemctl restart nfs-server.service"
done

oc get pv