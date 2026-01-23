#!/usr/bin/bash

groupadd $MACHINE
chown -R root $MACHINE_DIR
chgrp -R $MACHINE $MACHINE_DIR
chmod -R 771 $MACHINE_DIR/install
chmod -R 771 $BIN_DIR
chmod -R 751 $SBIN_DIR
find $MACHINE_DIR -type d -exec chmod 775 {} \;
chmod -R g+s $MACHINE_DIR

exit 0


