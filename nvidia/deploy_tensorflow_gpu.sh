#/bin/bash
oc login https://192.168.0.19:8443 -u justin

oc project nvidia


oc new-app -f tensorflow_gpu.yaml

