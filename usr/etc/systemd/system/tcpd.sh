#!/usr/bin/bash

. /etc/env

mkdir -p $LOG_CONN_DIR
tcpdump -n -l > $LOG_CONN

exit 0


