#!/usr/bin/bash

#if [ "$UEID" -ne "0" ] ; then
#	echo "This script must be run as root"
#fi

pacman --noconfirm -S git
pacman --noconfirm -S mtr
pacman --noconfirm -S traceroute
pacman --noconfirm -S makepkg
pacman --noconfirm -S nftables
pacman --noconfirm -S bc
pacman --noconfirm -S ctags
pacman --noconfirm -S firefox
pacman --noconfirm -S unzip
pacman --noconfirm -S vlc
pacman --noconfirm -S tcpdump
pacman --noconfirm -S moreutils
pacman --noconfirm -S net-tools
pacman --noconfirm -S make
pacman --noconfirm -S whois
pacman --noconfirm -S nmap
pacman --noconfirm -S man-db
pacman --noconfirm -S openvpn
pacman --noconfirm -S wireguard-tools
pacman --noconfirm -S proton-vpn-gtk-app
pacman --noconfirm -S systemd-resolvconf
pacman --noconfirm -S cronie
pacman --noconfirm -S docker
pacman --noconfirm -S makepkg
pacman --noconfirm -S tree
pacman --noconfirm -S vim
pacman --noconfirm -S iwctl
pacman --noconfirm -S pciutils
pacman --noconfirm -S git-filter-repo
pacman --noconfirm -S xorg-setxkbmap
pacman --noconfirm -S xorg-xhost
pacman --noconfirm -S qemu-full
mandb #rend possible la commande apropos
