#/bin/bash
oc login https://ocp.datr.eu:8443 -u justin

PV_STUB=infra-pv000

sudo mkdir /data

for i in {1..10}; do
	PV_NAME=$PV_STUB$i
	echo Setting up $PV_NAME
	oc delete pv $PV_NAME
	sudo rm -rf /data/$PV_NAME
	sudo mkdir /data/$PV_NAME
	cat app-pv-template.yml | sed s/XXXX/$PV_NAME/g > app-$PV_NAME.yml
	oc create -f app-$PV_NAME.yml
	rm -rf app-$PV_NAME.yml
done

sudo chmod -R 777 /data
sudo chcon -u system_u -r object_r -t svirt_sandbox_file_t -l s0 /data
sudo chcon -Rt svirt_sandbox_file_t /data

oc get pv
