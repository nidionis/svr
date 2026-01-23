#!/usr/bin/bash

if [[ "$EUID" -ne "0" ]]; then
   echo "This script must be run as root"
   exit 1
fi

if [ $# -ne 1 ] ; then
	echo usage $0 MACHINE_DIR
	exit 0
fi
MACHINE_DIR=${1:-"svr"}

bash	tree_cpy.sh $MACHINE_DIR/usr
# append sources
bash config.sh
source /home/.bashrc
bash python.sh
source /home/.bashrc

bash chmod.sh

bash pacman.sh

bash network.sh
