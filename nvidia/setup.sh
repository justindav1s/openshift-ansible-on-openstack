#/bin/bash
oc login https://ocp.datr.eu:8443 -u justin

oc new-project nvidia
oc project nvidia

oc create serviceaccount nvidia-deviceplugin

oc create -f nvidia-deviceplugin-scc.yaml


oc get scc | grep nvidia

sleep 10

oc label node gpu-node1.novalocal openshift.com/gpu-accelerator=true

oc create -f nvidia-device-plugin.yml

sleep 10

oc get pods
