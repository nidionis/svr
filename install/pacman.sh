#!/usr/bin/bash

#if [ "$UEID" -ne "0" ] ; then
#	echo "This script must be run as root"
#fi

pacman --noconfirm -Sy git
pacman --noconfirm -Sy makepkg
pacman --noconfirm -Sy nftables
pacman --noconfirm -Sy bc
pacman --noconfirm -Sy ctags
pacman --noconfirm -Sy firefox
pacman --noconfirm -Sy unzip
pacman --noconfirm -Su vlc
pacman --noconfirm -Sy tcpdump
pacman --noconfirm -Sy moreutils
pacman --noconfirm -Sy net-tools
pacman --noconfirm -Sy make
pacman --noconfirm -Sy whois
pacman --noconfirm -Sy nmap
pacman --noconfirm -Sy man-db
pacman --noconfirm -Sy openvpn
pacman --noconfirm -Sy bitwarden
pacman --noconfirm -Sy wireguard-tools
pacman --noconfirm -Sy proton-vpn-gtk-app
pacman --noconfirm -Sy systemd-resolvconf
pacman --noconfirm -Sy cronie
pacman --noconfirm -Sy docker
pacman --noconfirm -Sy makepkg
pacman --noconfirm -Sy tree
pacman --noconfirm -Sy vim
pacman --noconfirm -Sy iwctl
pacman --noconfirm -Sy pciutils
pacman --noconfirm -Sy git-filter-repo
pacman --noconfirm -Sy xorg-setxkbmap
pacman --noconfirm -Sy xorg-xhost
pacman --noconfirm -Sy bind
mandb #rend possible la commande apropos

##git clone https://github.com/Exafunction/codeium.vim ~/.vim/pack/Exafunction/start/codeium.vim
#sudo -i -u $SUDO_USER bash << EOF
#
#git config --global user.email "contact@presko.info"
#git config --global user.name "prsko_$HOST"
#EOF

#su $SUDO_USER
#git clone https://aur.archlinux.org/yay.git
#cd yay/
#makepkg -si
#cd ..
#rm -rf yay
