#!/bin/bash
#/usr/bin/pinta /opt/serverQRCode.jpg &
cp /opt/mkServer/imageTemplates.js /opt/mkServer/templates.js
cp /opt/mkServer/imageConfig.js /opt/mkServer/config.js
name="node"
test=`/bin/ps -aux | grep -i $name | wc -l`
if [ $test == 1 ]
then
/sbin/startnode.sh /opt/mkServer/index.js &
fi

if [ $test != 1 ]
then
stopMkServer.sh
/sbin/startnode.sh /opt/mkServer/index.js &
fi

name="pinta"
test=`/bin/ps -aux | grep -i $name | wc -l`
if [ $test == 1 ]
then
/usr/bin/pinta /opt/serverQRCode.jpg &
sleep 3
fi


#/usr/bin/kolourpaint /opt/serverQRCode.jpg &
zenity --info --text "Image Upload for /home/mk/Pictures activated. Press Button to deactivate." --ok-label="Deactivate Image Upload" 2> /dev/null 
stopMkServer.sh
