#!/bin/sh
#while [ -z $ipset ]; do
#ipset="`sudo ifconfig | grep -i 'inet 192.168.173.1' | awk '{print $2}'`"
#done
mv /home/mk/.kodi /home/mk/.kodi_old
mv /home/mk/.kodi_old /home/mk/.kodi
chmod -R 777 /home/mk/.kodi
wlanModul1="`ip link show | grep -i 'wlan1' | awk '{print $2}' | sed 's/://g'`"
if ! [ -z $wlanModul1 ]; then
cd /opt/lazycast
./allnew.sh &
fi
zenity --info --text="GO!" --timeout=8 2> /dev/null  &
