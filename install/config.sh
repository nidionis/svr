#!/usr/bin/bash

#bash tree_cpy.sh ../usr

SKEL=/etc/skel
mkdir $SKEL

FILE=".vimrc"
echo "source /home/$FILE" > $SUDO_HOME/$FILE
cat $SUDO_HOME/$FILE > $SKEL/$FILE

FILE=".profile"
echo "source /home/$FILE" > $SUDO_HOME/$FILE
cat $SUDO_HOME/$FILE > $SKEL/$FILE


FILE=".bashrc"
echo "source /home/$FILE" > $SUDO_HOME/$FILE
cat $SUDO_HOME/$FILE > $SKEL/$FILE


groupadd svr
usermod -aG svr $SUDO_USER
