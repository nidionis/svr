#!/usr/bin/bash

sudo apt-get update
sudo apt-get upgrade
sudo apt-get dist-upgrade


if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

./config_install.sh
#apt instll -y  ulogd
NETWORKDIR="$MACHINE_DIR/networking"
#systemctl enable ulogd
#systemctl start ulogd
#bash $NETWORKDIR/iptables_script.sh -f $NETWORKDIR/ip_to_ban.txt -r

bash apt_install.sh
