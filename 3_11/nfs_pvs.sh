#!/usr/bin/env bash


oc login https://localhost:8443 -u justin

PV_STUB="nfspv000"
NFS_HOST="192.168.0.76"


for i in {1..20}; do
	PV_NAME=$PV_STUB$i
	echo Setting up $PV_NAME

	cat <<EOF > ${PV_NAME}.yml
apiVersion: "v1"
kind: "PersistentVolume"
metadata:
  name: "${PV_NAME}"
spec:
  capacity:
    storage: "10Gi"
  accessModes:
    - "ReadWriteOnce"
    - "ReadWriteMany"
  nfs:
    path: "/exports/${PV_NAME}"
    server: "${NFS_HOST}"
  persistentVolumeReclaimPolicy: "Recycle"
EOF

	oc delete pv $PV_NAME
	ssh root@${NFS_HOST} "rm -rf /exports/$PV_NAME"
	ssh root@${NFS_HOST} "mkdir /exports/$PV_NAME"
	ssh root@${NFS_HOST} "chmod -R 777 /exports/$PV_NAME"
    ssh root@${NFS_HOST} "chown -R nfsnobody:nfsnobody /exports/$PV_NAME"
    ssh root@$NFS_HOST "echo /exports/$PV_NAME *\(rw,root_squash\) >> /etc/exports.d/openshift-uservols.exports"
	oc create -f $PV_NAME.yml
	rm -rf $PV_NAME.yml
done


#PV for Nexus
PV_NAME=nexus-pv
echo Setting up $PV_NAME
oc delete pv $PV_NAME
ssh root@${NFS_HOST} "rm -rf /exports/$PV_NAME"
ssh root@${NFS_HOST} "mkdir /exports/$PV_NAME"
ssh root@${NFS_HOST} "chmod -R 777 /exports/$PV_NAME"
ssh root@$NFS_HOST "echo /exports/$PV_NAME *\(rw,root_squash\) >> /etc/exports.d/openshift-uservols.exports"

cat <<EOF > ${PV_NAME}.yml
apiVersion: "v1"
kind: "PersistentVolume"
metadata:
  name: "${PV_NAME}"
spec:
  capacity:
    storage: "20Gi"
  accessModes:
    - "ReadWriteOnce"
    - "ReadWriteMany"
  nfs:
    path: "/exports/${PV_NAME}"
    server: "${NFS_HOST}"
  persistentVolumeReclaimPolicy: "Recycle"
EOF

oc create -f $PV_NAME.yml
rm -rf $PV_NAME.yml

ssh root@$NFS_HOST "systemctl restart nfs-server.service"

oc get pv