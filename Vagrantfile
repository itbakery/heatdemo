# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

$script = <<SCRIPT
sudo apt-get -q -y update
sudo apt-get install -qqy git lvm2
sudo apt-get install -q -y python-pip
sudo pip install -q netaddr
sudo apt-get install python-pip
sudo pip install --upgrade pip
sudo pip install -U os-testr
sudo apt-get install ebtables
sudo apt-get install bridge-utils
pvcreate /dev/vdb
vgcreate stack-volumes /dev/vdb
vgs

SCRIPT


Vagrant.configure("2") do |config|
  config.vm.box = "wholebits/ubuntu17.04-64"

  config.vm.network "private_network", ip: "172.16.0.2", netmask: "255.255.255.0"
  config.vm.provision :shell, :inline => $script

  config.vm.provider "libvirt" do |vb|
     vb.cpus = 4
     vb.memory = "12288"
     vb.nested = true
     vb.storage :file, :size => '20G'
  end
end
