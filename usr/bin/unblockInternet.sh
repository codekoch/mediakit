#!/bin/bash
if [ $1 == "all" ] ; then
sudo iptables -F
zenity --width=400 --height=100 --info --text="Internet für alle verbundenen Geräte freigegeben!" --timeout=2 2> /dev/null  &
else
sudo iptables -I FORWARD -s $1 -j ACCEPT
zenity --width=400 --height=100 --info --text="Internet für $1 freigegeben!" --timeout=2 2> /dev/null  &
fi



