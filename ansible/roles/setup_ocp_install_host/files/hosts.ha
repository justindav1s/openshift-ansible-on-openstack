[OSEv3:children]
nodes
nfs
masters
etcd
lb


[OSEv3:vars]
ansible_ssh_user=root

#General Config
openshift_release=v3.7
deployment_type=openshift-enterprise
openshift_master_cluster_method=native
containerized=false
openshift_disable_check=disk_availability,docker_storage,memory_availability,docker_image_availability,package_version

#Network config
os_sdn_network_plugin_name='redhat/openshift-ovs-multitenant'

#Master config
openshift_master_cluster_public_hostname=ocp.datr.eu
openshift_master_default_subdomain=apps.ocp.datr.eu
openshift_master_cluster_hostname=master1.swlon.local

#Security config
openshift_master_identity_providers=[{'name': 'htpasswd_auth', 'login': 'true', 'challenge': 'true', 'kind': 'HTPasswdPasswordIdentityProvider', 'filename': '/etc/origin/master/htpasswd'}]
openshift_master_htpasswd_users={'justin': '$apr1$dCb5zcYj$VbbgLQOfRK0f8W3TSALDP.'}
openshift_master_named_certificates=[{"certfile": "/etc/pki/tls/certs/ocp.datr.eu.crt", "keyfile": "/etc/pki/tls/private/ocp.datr.eu.key", "cafile": "/etc/pki/tls/certs/ocp.datr.eu.issuer.crt"}]

#Registry config
openshift_hosted_registry_storage_kind=nfs
openshift_hosted_registry_storage_access_modes=['ReadWriteMany']
#openshift_hosted_registry_storage_host=infra1.swlon.local
openshift_hosted_registry_storage_nfs_directory=/exports
openshift_hosted_registry_storage_volume_name=registry
openshift_hosted_registry_storage_volume_size=10Gi
openshift_hosted_registry_selector='region=infra'
openshift_hosted_registry_replicas=1
openshift_hosted_registry_pullthrough=true
openshift_hosted_registry_acceptschema2=true
openshift_hosted_registry_enforcequota=true

#Metrics config
openshift_metrics_install_metrics=True
openshift_metrics_storage_kind=nfs
openshift_metrics_storage_access_modes=['ReadWriteOnce']
openshift_metrics_storage_nfs_directory=/exports
openshift_metrics_storage_nfs_options='*(rw,root_squash)'
openshift_metrics_storage_volume_name=metrics
openshift_metrics_storage_volume_size=10Gi
openshift_metrics_storage_labels={'storage': 'metrics'}
openshift_metrics_cassandra_nodeselector={"region":"infra"}
openshift_metrics_hawkular_nodeselector={"region":"infra"}
openshift_metrics_heapster_nodeselector={"region":"infra"}
openshift_master_metrics_public_url=https://hawkular-metrics.apps.ocp.datr.eu/hawkular/metrics

#Logging config
openshift_logging_install_logging=True
openshift_logging_storage_kind=nfs
openshift_logging_storage_access_modes=['ReadWriteOnce']
openshift_logging_storage_nfs_directory=/exports
openshift_logging_storage_nfs_options='*(rw,root_squash)'
openshift_logging_storage_volume_name=logging
openshift_logging_storage_volume_size=10Gi
openshift_logging_storage_labels={'storage': 'logging'}
openshift_logging_es_cluster_size=1
openshift_logging_es_nodeselector={"region":"infra"}
openshift_logging_kibana_nodeselector={"region":"infra"}
openshift_logging_curator_nodeselector={"region":"infra"}

#Router config
openshift_hosted_router_selector='region=infra'
openshift_hosted_router_replicas=2

#Service Catalogue config
openshift_enable_service_catalog=true
template_service_broker_install=true
ansible_service_broker_install=false
template_service_broker_selector={'region':'infra'}
openshift_template_service_broker_namespaces=['openshift']

# default project node selector
osm_default_node_selector='region=apps'

# Configure node kubelet arguments. pods-per-core is valid in OpenShift Origin 1.3 or OpenShift Container Platform 3.3 and later.
#openshift_node_kubelet_args={'pods-per-core': ['10'], 'max-pods': ['250'], 'image-gc-high-threshold': ['85'], 'image-gc-low-threshold': ['75']}

# Configure logrotate scripts
# See: https://github.com/nickhammond/ansible-logrotate
#logrotate_scripts=[{"name": "syslog", "path": "/var/log/cron\n/var/log/maillog\n/var/log/messages\n/var/log/secure\n/var/log/spooler\n", "options": ["daily", "rotate 7","size 500M", "compress", "sharedscripts", "missingok"], "scripts": {"postrotate": "/bin/kill -HUP `cat /var/run/syslogd.pid 2> /dev/null` 2> /dev/null || true"}}]


[nodes]
master1.swlon.local openshift_hostname=master1.swlon.local openshift_node_labels="{'region': 'master'}" openshift_schedulable=False
master2.swlon.local openshift_hostname=master2.swlon.local openshift_node_labels="{'region': 'master'}" openshift_schedulable=False
master3.swlon.local openshift_hostname=master3.swlon.local openshift_node_labels="{'region': 'master'}" openshift_schedulable=False
infra1.swlon.local openshift_hostname=infra1.swlon.local openshift_node_labels="{'region': 'infra'}" openshift_schedulable=True
infra2.swlon.local openshift_hostname=infra2.swlon.local openshift_node_labels="{'region': 'infra'}" openshift_schedulable=True
node1.swlon.local openshift_hostname=node1.swlon.local openshift_node_labels="{'region': 'apps'}" openshift_schedulable=True
node2.swlon.local openshift_hostname=node2.swlon.local openshift_node_labels="{'region': 'apps'}" openshift_schedulable=True

[nfs]
nfs.swlon.local openshift_hostname=nfs.swlon.local

[masters]
master1.swlon.local  openshift_hostname=master1.swlon.local
master2.swlon.local openshift_hostname=master2.swlon.local
master3.swlon.local openshift_hostname=master3.swlon.local

[etcd]
master1.swlon.local openshift_hostname=master1.swlon.local
master2.swlon.local openshift_hostname=master2.swlon.local
master3.swlon.local openshift_hostname=master3.swlon.local

[lb]
masterlb.swlon.local openshift_hostname=masterlb.swlon.local
lb1.swlon.local openshift_hostname=lb1.swlon.local