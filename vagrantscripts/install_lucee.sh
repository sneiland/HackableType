#!/bin/bash

echo "================= START INSTALL-LUCEE.SH $(date +"%r") ================="
echo " "

LUCEE_VERSION="5.3.8.201"
LUCEE_INSTALLER="lucee-$LUCEE_VERSION-linux-x64-installer.run"

if [ ! -d "/opt/lucee" ]; then

	# Create artifacts folder for downloads
	if [ ! -d /vagrant/vagrantscripts/artifacts ]; then
		echo "... Creating artifacts folder for downloads ..."
		mkdir -p /vagrant/vagrantscripts/artifacts;
	fi

	# Download lucee if we don't already have it locally
	if [ ! -f "/vagrant/vagrantscripts/artifacts/$LUCEE_INSTALLER" ]; then
		echo "... Downloading the Lucee installer, standby ..."
		wget -O /vagrant/vagrantscripts/artifacts/$LUCEE_INSTALLER -a /vagrant/vagrantscripts/install.log https://cdn.lucee.org/$LUCEE_INSTALLER 
	fi
	
	# Copy the lucee installer
	echo "... Copying Lucee installer ..."
	sudo cp /vagrant/vagrantscripts/artifacts/$LUCEE_INSTALLER /root
	
	echo "... Installing Lucee ..."
	sudo chmod +x /root/$LUCEE_INSTALLER
	sudo /root/$LUCEE_INSTALLER --mode unattended --optionfile /vagrant/vagrantscripts/config/lucee/lucee-options.txt >> /vagrant/vagrantscripts/log/install.log
	
	# Set lucee service to start on boot
	# sudo cp /opt/lucee/lucee_ctl /etc/init.d/
	# sudo update-rc.d lucee_ctl start
	# systemctl enable lucee_ctl.service
	
else
	echo "Lucee installed already, skipping"
fi

echo "... Configuring Lucee ..."

# Set environment
sudo cp /vagrant/vagrantscripts/config/lucee/setenv.sh /opt/lucee/tomcat/bin

# Fix For Windows line breaks
sudo dos2unix /opt/lucee/tomcat/bin/setenv.sh >> /vagrant/vagrantscripts/log/install.log

# Setup lucee tomcat server file
sudo cp /vagrant/vagrantscripts/config/lucee/server.xml /opt/lucee/tomcat/conf/server.xml

# Setup Lucee 'Server' Context Configuration
sudo cp -p /vagrant/vagrantscripts/config/lucee/lucee-server.xml /opt/lucee/tomcat/lucee-server/context/lucee-server.xml

# Setup Lucee 'Web' Context Configuration
if [ ! -d "/vagrant/src/web/WEB-INF/lucee/" ]; then
	sudo mkdir -p /vagrant/src/web/WEB-INF/lucee
fi
sudo cp -p /vagrant/vagrantscripts/config/lucee/lucee-web.xml.cfm /vagrant/src/web/WEB-INF/lucee/lucee-web.xml.cfm

echo " "
echo "================= FINISH INSTALL-LUCEE.SH $(date +"%r") ================="
echo " "