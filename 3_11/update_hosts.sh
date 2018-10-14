#!/usr/bin/env bash
cat <<EOF > /etc/hosts
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
192.168.0.72   311-master1.novalocal
192.168.0.68   311-infra1.novalocal
192.168.0.66   311-app1.novalocal
192.168.0.75   311-app2.novalocal
192.168.0.65   311-gpu1.novalocal
EOF