#!/usr/bin/env bash

NFS_HOST=infra1.swlon.local
NFS_ROOT=/exports

cat << EOF > app-pv-template.yml
apiVersion: "v1"
kind: "PersistentVolume"
metadata:
  name: "XXXX"
spec:
  capacity:
    storage: "30Gi"
  accessModes:
    - "ReadWriteOnce"
    - "ReadWriteMany"
  persistentVolumeReclaimPolicy: Recycle
  nfs:
    path: "$NFS_ROOT/XXXX"
    server: $NFS_HOST
EOF


oc login https://ocp.datr.eu:8443 --insecure-skip-tls-verify=true -u justin

PV_STUB=pv


for i in {1..25}; do
	PV_NAME=$PV_STUB$i
	echo Setting up $PV_NAME
	ssh root@$NFS_HOST "mkdir $NFS_ROOT/$PV_NAME"
    ssh root@$NFS_HOST "echo $NFS_ROOT/$PV_NAME *\(rw,root_squash\) >> /etc/exports.d/openshift-uservols.exports"
	cat app-pv-template.yml | sed s/XXXX/$PV_NAME/g > app-pv-$PV_NAME.yml
	oc create -f app-pv-5G-$PV_NAME.yml
	rm -rf app-pv-5G-$PV_NAME.yml
done


ssh root@$NFS_HOST "chown -R nfsnobody.nfsnobody $NFS_ROOT"
ssh root@$NFS_HOST "chmod -R 777 $NFS_ROOT"
ssh root@$NFS_HOST "systemctl restart nfs-server.service"

oc get pv