#!/usr/bin/bash

#bash tree_cpy.sh ../usr

SKEL=/etc/skel

mkdir $SKEL

FILE=".vimrc"
echo "source /home/$FILE" > $HOME/$FILE
cat $HOME/$FILE > $SKEL/$FILE

FILE=".profile"
echo "source /home/$FILE" > $HOME/$FILE
cat $HOME/$FILE > $SKEL/$FILE


FILE=".bashrc"
echo "source /home/$FILE" > $HOME/$FILE
cat $HOME/$FILE > $SKEL/$FILE

source /home/.bashrc
git config --global user.email "$EMAIL"
git config --global user.name "$HOST"

