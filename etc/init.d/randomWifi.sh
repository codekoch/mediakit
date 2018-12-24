#!/bin/sh
### BEGIN INIT INFO
# Provides:          Für welches Programm ist das Script?
# Required-Start:    
# Required-Stop:     
# Default-Start:     2 3
# Default-Stop:      
# Short-Description: Kurze Beschreibung
# Description:       Längere Beschreibung
### END INIT INFO
n1="`shuf -i0-9 -n1`"
n2="`shuf -i0-9 -n1`"
n3="`shuf -i0-9 -n1`"
#n4="`shuf -i0-9 -n1`"
sudo  sed -i 's/wpa_passphrase=.*$/wpa_passphrase=mediakit'$n1$n2$n3'/g' /etc/hostapd/hostapd.conf

