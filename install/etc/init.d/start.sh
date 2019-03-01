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
while [ -z $ipset ]; do
ipset="`sudo ifconfig | grep -i 'inet 1.1.1.1' | awk '{print $2}'` "
done
/etc/init.d/info.sh
