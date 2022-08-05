#!/bin/bash

echo "================= START INSTALL-MARIADB.SH $(date +"%r") ================="
echo " "

MARIADB_VERSION="10.5"
MARIADB_USERNAME="webuser"
MARIADB_PASSWORD="password"

export DEBIAN_FRONTEND=noninteractive

dpkg -s mariadb-server &> /dev/null  
if [ $? -ne 0 ]; then
	echo "Adding mariadb mirror to ubuntu source list"
	sudo apt-get install -y software-properties-common
	sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
	sudo sh -c "echo 'deb [arch=amd64,arm64,ppc64el] https://ftp.osuosl.org/pub/mariadb/repo/'$MARIADB_VERSION'/ubuntu '$(lsb_release -cs)' main' > /etc/apt/sources.list.d/MariaDB.list"
	
	echo "Installing MariaDB..."
	sudo apt-get update
	sudo debconf-set-selections <<< 'mariadb-server-'$MARIADB_VERSION' mysql-server/root_password password '$MARIADB_PASSWORD
	sudo debconf-set-selections <<< 'mariadb-server-'$MARIADB_VERSION' mysql-server/root_password_again password '$MARIADB_PASSWORD
	sudo apt-get install -y mariadb-server mariadb-client
	echo "Done"
	
	# Setup custom my.cnf
	sudo cp -p /vagrant/vagrantscripts/config/mariadb/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
		
	echo "Configuring MariaDB..."
	# sudo mysql -e "UPDATE mysql.user SET Password = PASSWORD('\$MARIADB_PASSWORD') WHERE User = 'root'"
	sudo mysql -e "GRANT ALL ON *.* TO '""$MARIADB_USERNAME""' IDENTIFIED BY '""$MARIADB_PASSWORD""'"
	
	# Make our changes take effect
	sudo mysql -e "FLUSH PRIVILEGES"
	
	sudo systemctl restart mariadb
else
	echo "MariaDB already installed, skipping..."
fi
	
echo "Drop pre-existing databases"
sudo mysql -u $MARIADB_USERNAME -p$MARIADB_PASSWORD -e "DROP DATABASE IF EXISTS hackabletype"

echo "Create required databases"
sudo mysql -u $MARIADB_USERNAME -p$MARIADB_PASSWORD -e "CREATE DATABASE hackabletype CHARACTER SET = 'utf8mb4' COLLATE = 'utf8mb4_general_ci';"

echo " "
echo "================= FINISH INSTALL-MARIADB.SH $(date +"%r") ================="
echo " "