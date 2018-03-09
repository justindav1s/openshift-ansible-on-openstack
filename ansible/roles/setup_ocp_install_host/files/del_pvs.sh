#!/usr/bin/env bash

oc login https://loadbalancer.0c39.example.opentlc.com:8443 --insecure-skip-tls-verify=true -u justin

PV_STUB=pv

for i in {1..50}; do
	PV_NAME=$PV_STUB$i
	oc delete pv $PV_NAME
	rm -rf /srv/nfs/$PV_NAME
done

oc get pv