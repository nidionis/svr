#!/usr/bin/bash

USR_DIR=${1:-"no_dir"}
[[ $USR_DIR == "no_dir" ]] && \
	echo "usage $0 usr_dir" && \
	exit 1

USR_DIR=$(realpath $USR_DIR)

#uses ssymbolic link otherwise crossdevice troubles
cp -s -p -r -f -t / $USR_DIR/.
