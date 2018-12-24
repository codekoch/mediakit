#!/bin/bash
echo "Bitte warten, der Netzwerk Reset dauert einige Zeit ..."
echo "(Bei nicht angeschlossenen LAN-Kabel sehr lange!)"
#ip addr flush eth0
#ip addr flush wlan0
systemctl restart networking
#ifup eth0
ifup wlan0
systemctl restart hostapd.service
/sbin/info.sh

