#!/bin/bash

# Author Danny
# Version GIT: 2021-05-06 20:43

# docker-entrypoint.sh 
# script who is launched at startup of the container

# Define special colors
CRED="\e[31m"
CGREEN="\e[32m"
CNORMAL="\e[0m"

# Start
echo -e "== ${CGREEN}Start entrypoint ${0}${CNORMAL} =="

# Setting proxy server
set-proxy.sh

# Adding ca-certificates
set-cacertificates.sh

# End
echo -e "== ${CGREEN}End entrypoint ${0}${CNORMAL} =="

# Execute docker CMD
exec "$@"