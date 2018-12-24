#!/bin/bash
/opt/draw/bin/run.sh &
feh /opt/draw/collabDrawQR.png &
sleep 4
google-chrome-stable http://mk:3000/d/mk
/sbin/stopMkServer.sh

