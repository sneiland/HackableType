#!/bin/bash

echo "Initializing provisioning log file"

# Create fresh log file

if [ ! -d /vagrant/vagrantscripts/log ]; then
  mkdir -p /vagrant/vagrantscripts/log;
fi

echo "Starting VM provisioning at $(date) " >> /vagrant/vagrantscripts/log/install.log

echo " " 