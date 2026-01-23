#!/usr/bin/bash

sudo apt-get update
sudo apt-get upgrade
sudo apt-get dist-upgrade

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

MACHINE_DIR=/svr

bash	tree_cpy.sh $MACHINE_DIR/usr
bash config.sh
source /home/.bashrc
bash python.sh
source /home/.bashrc

bash chmod.sh

bash apt.sh

bash network.sh
