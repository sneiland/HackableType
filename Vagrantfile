# -*- mode: ruby -*-
# vi: set ft=ruby :

vm_ipaddress = "192.168.56.100"
vm_hostname = "hackabletype.vagranthost"
vm_name = "Lucee-CFML"

Vagrant.configure("2") do |config|
	# Every Vagrant development environment requires a box. You can search for boxes at https://vagrantcloud.com/search.
	config.vm.box = "ubuntu/bionic64"
	
	# Create a forwarded port mapping which allows access to a specific port
	# within the machine from a port on the host machine and only allow access
	# via 127.0.0.1 to disable public access
	#config.vm.network "forwarded_port", guest: 8888, host: 8080, host_ip: "127.0.0.1"
	config.vm.network :forwarded_port, guest: 3306, host: 8306, host_ip: "127.0.0.1"
	
	# Create a private network, which allows host-only access to the machine using a specific IP.
	config.vm.network "private_network", ip: vm_ipaddress
	  
	# Use NFS for shared folders for better performance
	# config.vm.synced_folder '.', '/vagrant', nfs: true
	
	# Create a public network, which generally matched to bridged network.
	# Bridged networks make the machine appear as another physical device on your network.
	# config.vm.network "public_network"

	# VirtualBox Provider Specific Configuration:
		config.vm.provider "virtualbox" do |vb|
		# Display the VirtualBox GUI when booting the machine
		# vb.gui = true
		
		# Customize the amount of memory on the VM:
		vb.memory = "2048"
		
		# Customize the number of virtual cpu's
		vb.cpus = 2
		
		# Enable/Disable ioapic, default is "on"
		# vb.customize ["modifyvm", :id, "--ioapic", "on"]
	end
	
	# Init log file
	config.vm.provision :shell, :path => "vagrantscripts/setuplogfile.sh", :privileged => true
  
	# Upgrade OS
	config.vm.provision :shell, inline: <<-SHELL
		export DEBIAN_FRONTEND=noninteractive
		sudo apt-get autoremove
		sudo apt-get update
		sudo apt-get upgrade -y >> /vagrant/vagrantscripts/log/install.log
	SHELL
  
	# Additional guest host aliases that to be configured on the parent machines hosts file
	# hostaliases = ["site1.local"]
	hostaliases = []
  
	if Vagrant.has_plugin?("vagrant-hostsupdater")
		# set vm hostname
		config.vm.hostname = vm_hostname
		config.hostsupdater.aliases = hostaliases
	end
  
	# Install utilities
	config.vm.provision :shell, :path => "vagrantscripts/install_utilities.sh", :privileged => true
  
	# Install/configure openjdk
	config.vm.provision :shell, :path => "vagrantscripts/install_openjdk.sh", :privileged => true
  
	# Install/configure apache2
	config.vm.provision :shell, :path => "vagrantscripts/install_apache.sh", :privileged => true, :args => [
		vm_hostname
	]
  
	# Install/configure lucee
	config.vm.provision :shell, :path => "vagrantscripts/install_lucee.sh", :privileged => true
	
	# Install/configure mariadb
	config.vm.provision :shell, :path => "vagrantscripts/install_mariadb.sh", :privileged => true, run: "always"
	
	# Cleanup and run services
	config.vm.provision :shell, :path => "vagrantscripts/install_finish.sh", :privileged => true, :args => [
		vm_name, vm_hostname, vm_ipaddress
	]
	
	# Since I can't get lucee to start on reload any other way this hack will suffice for now
	config.vm.provision :shell, run: "always", inline: <<-SHELL
	    sudo /opt/lucee/lucee_ctl restart
	SHELL
end
