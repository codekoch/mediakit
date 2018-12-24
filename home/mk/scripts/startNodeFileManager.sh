#!/bin/bash
IP=`/sbin/ifconfig | grep -i "inet " | awk '{print $2}' | head -1`
qrencode -s 15 -o serverQRCode.png "http://$IP:8080"
mogrify -fill black -gravity NorthWest -font FreeMono -pointsize 30 -draw "text 0,0 'http://"$IP":8080'" serverQRCode.png
thunar /home/mk/Öffentlich &
sleep 1
feh serverQRCode.png &
node-file-manager -p 8080 -d ~/Öffentlich
