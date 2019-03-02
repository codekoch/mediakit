##!/bin/sh
### BEGIN INIT INFO
# Provides:          Für welches Programm ist das Script?
# Required-Start:    
# Required-Stop:     
# Default-Start:     
# Default-Stop:      
# Short-Description: Kurze Beschreibung
# Description:       Längere Beschreibung
### END INIT INFO
/sbin/restoreMkProfile.sh
#sudo service smbd stop
#sudo service nmbd stop
#/sbin/blockAtStartup.sh 

/etc/init.d/randomWifi.sh
## check if we have two wlan interfaces
sudo  sed -i "s/device_name=.*$/device_name=$wlanssid/g" /etc/wpa_supplicant/wpa_supplicant.conf

if ! [ -z $wlanModul1 ]; then
while [ -z $ipset ]; do
ipset="`sudo ifconfig | grep -i 'inet 1.1.1.1' | awk '{print $2}'` "
done
fi
/etc/init.d/info.sh
