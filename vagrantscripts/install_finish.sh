#!/bin/bash

echo "================= START INSTALL-FINAL.SH $(date +"%r") ================="
echo " "

#echo "... Restarting Lucee ..."
#sudo service lucee_ctl restart >> /vagrant/vagrantscripts/log/install.log

echo "... Restarting Apache..."
sudo service apache2 restart >> /vagrant/vagrantscripts/log/install.log


# cleanup
# sudo rm /root/*.run &>> /vagrant/vagrantscripts/log/install.log

echo " "
echo "================= END INSTALL-FINAL.SH $(date +"%r") ================="
echo " "
echo " "
echo "$1"
echo " "
echo "========================================================================"
echo " "
echo "http://$2 ($3)"
echo " "
echo "Lucee Server/Web Context Administrators"
echo " "
echo "http://$2:8888/lucee/admin/server.cfm"
echo "http://$2:8888/lucee/admin/web.cfm"
echo " "
echo " "
echo "Password (for each admin): password"
echo "========================================================================"

echo "Install finished at $(date) " >> /vagrant/vagrantscripts/log/install.log