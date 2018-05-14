#/bin/bash
oc login https://192.168.0.20:8443 -u justin

oc project nvidia

oc create serviceaccount -n nvidia privilegeduser
oc adm policy add-scc-to-user privileged -n nvidia -z privilegeduser

oc create -f caffe2_2.yaml

