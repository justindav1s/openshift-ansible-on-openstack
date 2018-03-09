#!/usr/bin/env bash

NFS_HOST=nfs.swlon.local
NFS_ROOT=/exports

cat << EOF > app-pv-5G-template.yml
apiVersion: "v1"
kind: "PersistentVolume"
metadata:
  name: "XXXX"
spec:
  capacity:
    storage: "5Gi"
  accessModes:
    - "ReadWriteOnce"
  persistentVolumeReclaimPolicy: Recycle
  hostPath:
    path: "$NFS_ROOT/XXXX"
EOF

cat << EOF > app-pv-10G-template.yml
apiVersion: "v1"
kind: "PersistentVolume"
metadata:
  name: "XXXX"
spec:
  capacity:
    storage: "10Gi"
  accessModes:
    - "ReadWriteMany"
  persistentVolumeReclaimPolicy: Retain
  hostPath:
    path: "$NFS_ROOT/XXXX"
EOF

oc login https://ocp.datr.eu:8443 --insecure-skip-tls-verify=true -u justin

PV_STUB=pv


for i in {1..25}; do
	PV_NAME=$PV_STUB$i
	echo Setting up $PV_NAME
	ssh root@$NFS_HOST "mkdir $NFS_ROOT/$PV_NAME"
    ssh root@$NFS_HOST "echo $NFS_ROOT/$PV_NAME *(rw,root_squash) >> /etc/exports.d/openshift-uservols.exports"
	cat app-pv-5G-template.yml | sed s/XXXX/$PV_NAME/g > app-pv-5G-$PV_NAME.yml
	oc create -f app-pv-5G-$PV_NAME.yml
	rm -rf app-pv-5G-$PV_NAME.yml
done

for i in {26..50}; do
	PV_NAME=$PV_STUB$i
	echo Setting up $PV_NAME
	ssh root@$NFS_HOST "mkdir $NFS_ROOT/$PV_NAME"
    ssh root@$NFS_HOST "echo $NFS_ROOT/$PV_NAME *(rw,root_squash) >> /etc/exports.d/openshift-uservols.exports"
	cat app-pv-10G-template.yml | sed s/XXXX/$PV_NAME/g > app-pv-10G-$PV_NAME.yml
	oc create -f app-pv-10G-$PV_NAME.yml
	rm -rf app-pv-10G-$PV_NAME.yml
done

chown -R nfsnobody.nfsnobody  $NFS_ROOT
chmod -R 777 $NFS_ROOT

oc get pv