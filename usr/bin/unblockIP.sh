#!/bin/bash
sudo iptables -D INPUT -s $1 -j DROP
sudo iptables -D INPUT -s $1 -p tcp --dport 22 -j ACCEPT
sudo iptables -D INPUT -s $1 -p tcp --dport 3000 -j ACCEPT
sudo iptables -D INPUT -s $1 -p tcp --dport 5900 -j ACCEPT
sudo iptables -D INPUT -s $1 -p tcp --dport 5901 -j ACCEPT

if [ -e /tmp/freeips.txt ]; then
echo "append "$1" to /tmp/freeips.txt"
readarray freeips < /tmp/freeips.txt
if `echo ${freeips[@]} | grep -q $1` ; then
   echo $1 "allready in /tmp/freeips.txt"

else
    echo $1 >> /tmp/freeips.txt
fi
else
echo "create new /tmp/freeips.txt.."
echo $1 > /tmp/freeips.txt
fi
