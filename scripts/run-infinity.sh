#!/bin/bash

# Author Danny
# Version GIT: 2021-05-06 20:08

# run-infinity.sh 
# sleep infinity until you kill the process

exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"