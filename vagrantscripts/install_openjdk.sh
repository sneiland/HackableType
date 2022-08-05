#!/bin/bash

echo "================= START INSTALL-OPENJDK.SH $(date +"%r") ================="
echo " "

# Check if we have this JDK installed
if [ ! -d "/usr/lib/jvm/java-11-openjdk-amd64/" ]; then
	echo "Installing JDK"
	apt install -y openjdk-11-jre-headless
	apt install -y openjdk-11-jdk
	echo "JDK Installed"
else
	echo "JDK is already installed, skipping"
fi

# Move in environment
#sudo cp -f /vagrant/vagrantscripts/config/environment /etc/environment

echo " "
echo "================= FINISH INSTALL-OPENJDK.SH $(date +"%r") ================="
echo " "