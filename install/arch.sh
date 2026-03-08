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
bash config.sh
source /home/.bashrc

bash chmod.sh
# append sources

bash pacman.sh
source /home/.bashrc

bash network.sh
#systemctl enable --now NetworkManager #enable dongle

#pacman --noconfirm -Syu ulogd
#NETWORKDIR="$MACHINE_DIR/networking"
##TOR_LIST=$NETWORKDIR/tor_list.txt
##curl https://www.dan.me.uk/torlist/?full= > $TOR_LIST
#systemctl enable ulogd
#systemctl start ulogd
#bash $NETWORKDIR/iptables_script.sh -f $NETWORKDIR/ip_to_ban.txt -r
