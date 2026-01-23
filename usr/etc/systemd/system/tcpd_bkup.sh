#!/usr/bin/bash
#run from crontab

. /home/.bashrc

. refresh_time

STATUS=ronron
if [ -f $NET_STATUS ] ; then
	STATUS=$(cat $NET_STATUS)
fi

DIR=$LOG_CONN_DIR/$STATUS
mkdir -p $DIR
grepip $LOG_CONN > $DIR/${DATE}_${TIME}.conn
mv -f $LOG_CONN $LOG_CONN_DIR/prev.log
systemctl restart tcpd

exit 0


