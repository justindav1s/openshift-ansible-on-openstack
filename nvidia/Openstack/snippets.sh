#!/usr/bin/env bash

cat <<EOF > /etc/hosts
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
192.168.0.91 311-master1.novalocal
192.168.0.75 311-app1.novalocal
192.168.0.77 311-app2.novalocal
192.168.0.73 311-gpu1.novalocal
192.168.0.76 311-infra1.novalocal
EOF

cat <<EOF > ~/.ssh/config
Host 192.168.0.*
   StrictHostKeyChecking no
   UserKnownHostsFile=/dev/null

Host *.novalocal
   StrictHostKeyChecking no
   UserKnownHostsFile=/dev/null
EOF

chmod 600 ~/.ssh/config



cat <<EOF > /etc/sysctl.d/99-elasticsearch.conf
vm.max_map_count = 262144
EOF

