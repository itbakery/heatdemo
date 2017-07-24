#!/bin/bash -x

sudo ufw disable
sudo apt-get -q -y update
sudo apt-get install -qqy git
sudo apt-get install -q -y python-pip
# sudo pip install -q netaddr
git clone https://github.com/openstack-dev/devstack.git
cd devstack

# When creating the stack deployment for the first time,
# you are going to see prompts for multiple passwords.
# Your results will be stored in the localrc file.
# If you wish to bypass this, and provide the passwords up front,
# add in the following lines with your own password to the localrc file

cat > local.conf << EOF
[[local|localrc]]
ADMIN_PASSWORD=secret
DATABASE_PASSWORD=secret
RABBIT_PASSWORD=secret
SERVICE_PASSWORD=secret
COMPRESS_OFFLINE=False
COMPRESS_ENABLED=False

HOST_IP=172.16.0.2
HOST_IP=172.16.0.2 
SERVICE_HOST=172.16.0.2
MYSQL_HOST=172.16.0.2 
RABBIT_HOST=172.16.0.2 
Q_HOST=172.16.0.2
GLANCE_HOST=172.16.0.2 
G_HOST=172.16.0.2 
GLANCE_HOSTPORT=172.16.0.2:9292 
HOST_IP_IFACE=eth1 
FLAT_INTERFACE=br100 
PUBLIC_INTERFACE=eth1 
FLOATING_RANGE=172.16.0.224/24

enable_service heat h-eng h-api h-api-cfn h-api-cw
enable_plugin heat https://git.openstack.org/openstack/heat

CEILOMETER_BACKEND=mongodb
enable_plugin ceilometer https://git.openstack.org/openstack/ceilometer
enable_plugin aodh https://git.openstack.org/openstack/aodh
CEILOMETER_NOTIFICATION_TOPICS=notifications,profiler

IMAGE_URLS+=",https://download.fedoraproject.org/pub/fedora/linux/releases/26/CloudImages/x86_64/images/Fedora-Cloud-Base-26-1.5.x86_64.qcow2" 
VOLUME_GROUP="stack-volumes"

VORBOSE=True 
LOGFILE=stacklog.txt 
EOF

./stack.sh

