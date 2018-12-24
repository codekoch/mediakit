#!/bin/bash
ip=`cat /var/log/auth.log | grep -i "ssh2" | awk END'{print $11}'`
echo $ip
adress=$ip":8080/browserfs.html"
echo "openening "$adress
chromium-browser $adress --start-fullscreen &
