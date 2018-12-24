#!/bin/bash
thunar /home/mk/Öffentlich &
sleep 1
cd /home/mk/Öffentlich

name="node"
test=`/bin/ps -aux | grep -i $name | wc -l`
if [ $test == 1 ]
then
/usr/bin/startFileBrowser.sh &
fi

if [ $test != 1 ]
then
/usr/bin/stopMkServer.sh
/usr/bin/startFileBrowser.sh &
fi


name="serverQRCode.png"
test=`/bin/ps -aux | grep -i $name | wc -l`
if [[ $test == 1 ]] || [[ $test == 0 ]]
then
zenity --info --text "Filebrowser für /home/mk/Öffentlich aktiviert.\nSchließen Sie das Fenster mit dem QR-Code, um den Server zu deaktivieren" 2> /dev/null & 
feh /opt/serverQRCode.png 
/usr/bin/stopMkServer.sh
fi
