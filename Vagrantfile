# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	# Base box
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.vm.hostname = "scala"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP. Forward the Scala and MongoDB ports.
  config.vm.network "private_network", ip: "192.168.33.11"
  config.vm.network :forwarded_port, guest: 9000, host: 9000
  config.vm.network :forwarded_port, guest: 27017, host: 27017

  # The provisioner, to get Git, MongoDB, Java, Scala, Activator and Samba
  config.vm.provision "shell", path: "provision.sh"
end
