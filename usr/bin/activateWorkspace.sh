#!/bin/bash
cd /home/mk/Öffentlich
thunar /home/mk/Öffentlich &
sleep 1
#node-file-manager -p 3000 -d /home/tp/Public/Workspace &

name="node"
test=`/bin/ps -aux | grep -i $name | wc -l`
if [ $test == 1 ]
then
/usr/bin/startWorkspace.sh &
fi

if [ $test != 1 ]
then
/usr/bin/stopMkServer.sh
/usr/bin/startWorkspace.sh &
fi

name="serverQRCode.png"
test=`/bin/ps -aux | grep -i $name | wc -l`
if [[ $test == 1 ]] || [[ $test == 0 ]]
then

zenity --info --text "Workspace /home/mk/Öffentlich aktiviert.\nSchließen Sie das Fenster mit dem QR-Code, um den Server zu deaktivieren" 2> /dev/null & 
feh /opt/serverQRCode.png 
/usr/bin/stopMkServer.sh
fi

