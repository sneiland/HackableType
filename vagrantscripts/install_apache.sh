#!/bin/bash


echo "================= START INSTALL_APACHE.SH $(date +"%r") ================="
echo " "

##############################################################################################
## Apache Installation
##############################################################################################

export DEBIAN_FRONTEND=noninteractive

if [ ! -d "/etc/apache2" ]; then
	sudo apt-get install -y apache2 >> /vagrant/vagrantscripts/log/install.log
fi

echo "... Configuring Apache ..."

# Enable proxy_ajp mod
sudo a2enmod proxy_ajp

# Copy the configuration files into the apache directory
sudo cp -p /vagrant/vagrantscripts/config/apache/000-default.conf /etc/apache2/sites-available/000-default.conf
sudo cp -p /vagrant/vagrantscripts/config/apache/dir.conf /etc/apache2/mods-available/dir.conf
sudo cp -p /vagrant/vagrantscripts/config/apache/apache2.conf /etc/apache2/apache2.conf

# enable required module
sudo a2enmod alias
sudo a2enmod rewrite
sudo a2enmod proxy
sudo a2enmod proxy_ajp
sudo a2enmod headers

# Restart apache2 with the new config
sudo service apache2 restart >> /vagrant/vagrantscripts/log/install.log

# Set apache to start on boot
sudo update-rc.d apache2 enable

echo " "
echo "================= FINISH INSTALL-INSTALL_APACHE.SH $(date +"%r") ================="
echo " "