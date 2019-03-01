#!/bin/sh
while [ -z $ipset ]; do
ipset="`sudo ifconfig | grep -i 'inet 192.168.173.1'`"
done
mv /home/mk/.kodi /home/mk/.kodi_old
mv /home/mk/.kodi_old /home/mk/.kodi
chmod -R 777 /home/mk/.kodi
cd /opt/lazycast
./start.sh &
zenity --info --text="GO!" --timeout=8 2> /dev/null  &
