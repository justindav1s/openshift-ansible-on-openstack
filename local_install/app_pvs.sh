#/bin/bash
oc login https://ocp.datr.eu:8443 justin

PV_STUB=locpv000

mkdir /data

for i in {1..25}; do
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
