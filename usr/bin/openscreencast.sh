#!/bin/bash
##zenity --info --text="Starting Screencast ..." --timeout=6 2> /dev/null  &

##ip=`cat /var/log/auth.log | grep -i "ssh2" | awk END'{print $11}'`
##echo $ip
##adress=$ip":8888/browserfs.html"
##echo "openening "$adress
##chromium-browser $adress --start-fullscreen &
python /usr/bin/screencast.py 
