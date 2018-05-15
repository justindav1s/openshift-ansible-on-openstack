#/bin/bash
oc login https://192.168.0.19:8443 -u justin

oc new-project nvidia
oc project nvidia

oc create serviceaccount nvidia-deviceplugin

oc create -f nvidia-deviceplugin-scc.yaml


oc get scc | grep nvidia

sleep 10

oc label node 192.168.0.19 openshift.com/gpu-accelerator=true

oc create -f nvidia-device-plugin.yml

sleep 10

oc get pods
