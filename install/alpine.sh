#!/usr/bin/bash

#if [[ "$EUID" -ne "0" ]]; then
#   echo "This script must be run as root"
#   exit 1
#fi

# append sources
H=$(find / -type d -name home | head -1)
source $H/.bashrc
bash	tree_cpy.sh $MACHINE_DIR/usr
bash config.sh
bash python.sh

bash chmod.sh
# append sources

bash apk.sh

bash network.sh
#systemctl enable --now NetworkManager #enable dongle

#pacman --noconfirm -Syu ulogd
#NETWORKDIR="$MACHINE_DIR/networking"
##TOR_LIST=$NETWORKDIR/tor_list.txt
##curl https://www.dan.me.uk/torlist/?full= > $TOR_LIST
#systemctl enable ulogd
#systemctl start ulogd
#bash $NETWORKDIR/iptables_script.sh -f $NETWORKDIR/ip_to_ban.txt -r
