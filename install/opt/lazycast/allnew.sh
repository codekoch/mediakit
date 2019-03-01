#!/bin/bash
p2pinterface="p2p-wlan0-0"
while :
do
        echo "PIN:"     
        sudo wpa_cli -i$p2pinterface wps_pin any 27900000
        echo ""
        ./d2.py
done
