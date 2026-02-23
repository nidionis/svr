#!/usr/bin/bash

groupadd $MACHINE
usermod -aG svr $SUDO_USER
chmod -R g+s $MACHINE_DIR
chown -R root $MACHINE_DIR
chgrp -R $MACHINE $MACHINE_DIR
chmod -R 771 $MACHINE_DIR/install
chmod -R 771 $BIN_DIR
chmod -R 661 $MACHINE_DIR/.git
find $MACHINE_DIR -type d -exec chmod 775 {} \;
chown root:root /etc/pam.d/*

exit 0


