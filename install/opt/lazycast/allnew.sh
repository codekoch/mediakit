#!/bin/bash
pin="NNN"
while :
do      
        ipset="`sudo ifconfig | grep -i 'inet 192.168.173.1' | awk '{print $2}'`"
        if [ -z $ipset ]; then
        sudo /sbin/restoreP2PWlan.sh
        fi
        p2pinterface="`sudo ifconfig | grep -i 'p2p-wlan' | awk '{print $1}' | sed 's/://g'`"
        echo "PIN:"     
        sudo wpa_cli -i$p2pinterface wps_pin any $pin
        echo ""
        zenity --info --text="WirelessDisplay:$pin" --timeout=8 2> /dev/null  &
        ./d2.py
done
