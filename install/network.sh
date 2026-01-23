#!/usr/bin/bash

cat $MACHINE_DIR/usr/etc/resolv.conf > /etc/resolv.conf
cat $MACHINE_DIR/usr/etc/systemd/resolved.conf > /etc/systemd/resolved.conf
bash $NETWORK_DIR/nft_setup.sh
