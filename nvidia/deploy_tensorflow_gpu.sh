#/bin/bash
oc login https://192.168.0.19:8443 -u justin

oc project nvidia

oc delete all -l app=tensorflow -n nvidia
oc delete all -l app=tensorflow-gpu -n nvidia
oc delete serviceaccount tensorflowuser -n nvidia

oc create serviceaccount tensorflowuser -n nvidia
oc adm policy add-scc-to-user privileged -z tensorflowuser -n nvidia

oc new-app -f tensorflow_gpu.yaml

