#!/usr/bin/env bash


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
    path: "/srv/nfs/XXXX"
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
    path: "/srv/nfs/XXXX"
EOF

oc login https://loadbalancer.0c39.example.opentlc.com:8443 --insecure-skip-tls-verify=true -u justin

PV_STUB=pv

for i in {1..25}; do
	PV_NAME=$PV_STUB$i
	echo Setting up $PV_NAME
	mkdir /srv/nfs/$PV_NAME
    echo /srv/nfs/$PV_NAME *(rw,root_squash) >> /etc/exports.d/openshift-uservols.exports
    chown -R nfsnobody.nfsnobody  /srv/nfs
    chmod -R 777 /srv/nfs
	cat app-pv-5G-template.yml | sed s/XXXX/$PV_NAME/g > app-pv-5G-$PV_NAME.yml
	oc create -f app-pv-5G-$PV_NAME.yml
	rm -rf app-pv-5G-$PV_NAME.yml
done

for i in {26..50}; do
	PV_NAME=$PV_STUB$i
	echo Setting up $PV_NAME
	oc delete pv $PV_NAME
	rm -rf /srv/nfs/$PV_NAME
	mkdir /srv/nfs/$PV_NAME
    chmod -R 777 /srv/nfs/$PV_NAME
    chcon -u system_u -r object_r -t svirt_sandbox_file_t -l s0 /srv/nfs/$PV_NAME
    chcon -Rt svirt_sandbox_file_t /srv/nfs/$PV_NAME
	cat app-pv-10G-template.yml | sed s/XXXX/$PV_NAME/g > app-pv-10G-$PV_NAME.yml
	oc create -f app-pv-10G-$PV_NAME.yml
	rm -rf app-pv-10G-$PV_NAME.yml
done

oc get pv