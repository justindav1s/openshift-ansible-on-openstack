#/bin/bash
oc login https://ocp.datr.eu:8443 -u justin

ENV=`hostname`
HOST_ROOT=/kube_volumes

PV_STUB=${ENV}-pv000

sudo mkdir $HOST_ROOT

for i in {1..20}; do
	PV_NAME=$PV_STUB$i
	echo Setting up $PV_NAME
	oc delete pv $PV_NAME
	sudo rm -rf $HOST_ROOT/$PV_NAME
	sudo mkdir $HOST_ROOT/$PV_NAME
	cat pv-template.yml | sed s/XXXX/$PV_NAME/g > tmp-$PV_NAME.yml
	oc create -f tmp-$PV_NAME.yml
	rm -rf tmp-$PV_NAME.yml
done

sudo chmod -R 777 $HOST_ROOT
sudo chcon -u system_u -r object_r -t svirt_sandbox_file_t -l s0 $HOST_ROOT
sudo chcon -Rt svirt_sandbox_file_t $HOST_ROOT

oc get pv
