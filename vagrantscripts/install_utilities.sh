#!/bin/bash

echo "================= START INSTALL-UTILITIES.SH $(date +"%r") ================="
echo " "

# install some common utilities
if [ ! -f /var/log/utils_installed ]; then
	echo "... Install dos2unix ..."
	sudo apt-get install dos2unix &>> /vagrant/vagrantscripts/log/install.log
	
	touch /var/log/utils_installed
fi

echo " "
echo "================= END INSTALL-UTILITIES.SH $(date +"%r") ================="
echo " "