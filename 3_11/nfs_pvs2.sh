#!/usr/bin/env bash

PV_STUB="nfspv000"
NFS_HOST="192.168.0.13"

oc login https://${NFS_HOST}:8443 -u justin


for i in {1..30}; do
	PV_NAME=$PV_STUB$i
	echo Setting up $PV_NAME

	cat <<EOF > ${PV_NAME}.yml
apiVersion: "v1"
kind: "PersistentVolume"
metadata:
  name: "${PV_NAME}"
spec:
  capacity:
    storage: "30Gi"
  accessModes:
    - "ReadWriteOnce"
    - "ReadWriteMany"
  nfs:
    path: "/exports/${PV_NAME}"
    server: "${NFS_HOST}"
  persistentVolumeReclaimPolicy: "Recycle"
EOF

	oc delete pv $PV_NAME
	rm -rf /exports/$PV_NAME
	mkdir /exports/$PV_NAME
	chmod -R 777 /exports/$PV_NAME
    chown -R nfsnobody:nfsnobody /exports/$PV_NAME
    echo /exports/$PV_NAME *\(rw,root_squash\) >> /etc/exports.d/openshift-uservols.exports
	oc create -f $PV_NAME.yml
	rm -rf $PV_NAME.yml
done


oc get pv
