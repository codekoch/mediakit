#!/bin/bash
thunar /home/mk/Öffentlich &
sleep 1
cp /opt/mkServer/fileTemplates.js /opt/mkServer/templates.js
cp /opt/mkServer/fileConfig.js /opt/mkServer/config.js
name="node"
test=`/bin/ps -aux | grep -i $name | wc -l`
if [ $test == 1 ]
then
/usr/bin/startnode.sh /opt/mkServer/index.js &
fi

if [ $test != 1 ]
then
/usr/bin/stopMkServer.sh
/usr/bin/startnode.sh /opt/mkServer/index.js &
fi

name="serverQRCode.png"
test=`/bin/ps -aux | grep -i $name | wc -l`
if [[ $test == 1 ]] || [[ $test == 0 ]]
then
zenity --info --text "File Upload für /home/mk/Öffentlich aktiviert.\nSchließen Sie das Fenster mit dem QR-Code, um den Server zu deaktivieren" 2> /dev/null & 
feh /opt/serverQRCode.png 
/usr/bin/stopMkServer.sh
fi
