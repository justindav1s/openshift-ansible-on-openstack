#!/usr/bin/env bash


cat << EOF > app-pv-template.yml
apiVersion: "v1"
kind: "PersistentVolume"
metadata:
  name: "XXXX"
spec:
  capacity:
    storage: "10Gi"
  accessModes:
    - "ReadWriteOnce"
    - "ReadWriteMany"
  persistentVolumeReclaimPolicy: Recycle
  hostPath:
    path: "/data/XXXX"
EOF

oc login --insecure-skip-tls-verify=true -u justin

PV_STUB=locpv000

mkdir /data

for i in 1 3 4 5 6 7 8 9; do
	PV_NAME=$PV_STUB$i
	echo Setting up $PV_NAME
	oc delete pv $PV_NAME
	rm -rf /data/$PV_NAME
	mkdir /data/$PV_NAME
	cat app-pv-template.yml | sed s/XXXX/$PV_NAME/g > app-$PV_NAME.yml
	oc create -f app-$PV_NAME.yml
	rm -rf app-$PV_NAME.yml
done

chmod -R 777 /data
chcon -u system_u -r object_r -t svirt_sandbox_file_t -l s0 /data
chcon -Rt svirt_sandbox_file_t /data

oc get pv