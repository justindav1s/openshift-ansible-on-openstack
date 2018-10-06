#/bin/bash
oc login https://192.168.0.19:8443 -u justin

PROJECT=tensorflow

oc project $PROJECT

oc delete all -l app=tensorflow
oc delete all -l app=tensorflow-gpu
oc delete serviceaccount tensorflowuser
oc create serviceaccount tensorflowuser
oc adm policy add-scc-to-user privileged -z tensorflowuser

oc new-app -f tensorflow_gpu.yaml
oc new-app -f tensorflow.yaml
