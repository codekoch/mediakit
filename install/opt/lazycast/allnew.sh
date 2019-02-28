#!/bin/bash
while :
do
        echo "PIN:"     
        sudo wpa_cli -ip2p-wlan0-0 wps_pin any 27900000
        echo ""
        ./d2.py
done
