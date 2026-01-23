#!/usr/bin/bash

if [ "$#" -ne 2 ] ; then
    echo "Usage: $0 IP port"
    exit 1
fi

IP=$1
PORT=$2

nmap -Pn -sV -p "$PORT" --open "$TARGET"

nmap --script check-port --script-args checkport.port=$PORT -p $PORT $IP

exit 0

