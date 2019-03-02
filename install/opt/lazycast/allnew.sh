#!/bin/bash
pin="NNN"
cd /opt/lazycast
while :
do      
        ipset="`sudo ifconfig | grep -i 'inet 192.168.173.1' | awk '{print $2}'`"
        if [ -z $ipset ]; then
        sudo /sbin/restoreP2PWlan.sh
        fi
        p2pinterface="`sudo ifconfig | grep -i 'p2p-wlan' | awk '{print $1}' | sed 's/://g'`"
        echo "PIN:"     
        sudo wpa_cli -i$p2pinterface wps_pin any $pin
#        sudo wpa_cli -i$p2pinterface 
        echo ""
#        zenity --info --text="WirelessDisplay:$pin" --timeout=8 2> /dev/null  &
        output="`amixer cget numid=3 | grep -i ': values=' | awk '{print$2}' | sed 's/values=//g'`"
        if [ $output = "2"]; then
          output = "0"
        fi
        sudo  sed -i 's/sound_output_select =.*$/sound_output_select = '$output'/g' ./d2.py
        ./d2.py
done
