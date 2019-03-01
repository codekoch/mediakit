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
#zenity --info --text="Urzustand des Systems wird hergestellt ..." --timeout=10 2> /dev/null  &
/sbin/restoreMkProfile.sh
#/sbin/useNormalNetworkSettings.sh
#sudo service smbd stop
#sudo service nmbd stop
#/sbin/blockAtStartup.sh 
#/etc/init.d/info.sh
# Wait for ip 
# Wait for ip 
#while [ -z $ipset ]; do
#ipset="`sudo ifconfig | grep -i 'inet 1.1.1.1'`"
#done
#sudo service dhcpcd restart
#while [ -z $ipset ]; do
#ipset="`sudo ifconfig | grep -i 'inet 1.1.1.1'`"
#done
#sudo service dnsmasq restart
#sudo service hostapd restart

#sudo /sbin/iptables -F
#sudo /sbin/iptables -X
#sudo /sbin/iptables -t nat -F
#sudo sysctl -w net.ipv4.ip_forward=1
#sudo sysctl -w net.ipv6.conf.all.forwarding=1
#sudo iptables -t nat -A  POSTROUTING -o eth0 -j MASQUERADE
# Wait for ip 
while [ -z $ipset ]; do
ipset="`sudo ifconfig | grep -i 'inet 1.1.1.1' | awk '{print $2}'` "
done
/etc/init.d/info.sh
# Loopback zulassen
#/sbin/iptables -A INPUT -i lo -j ACCEPT
#/sbin/iptables -A OUTPUT -o lo -j ACCEPT

# NAT und Masquerading aktivieren
#/sbin/iptables -A FORWARD -o eth0 -i wlan0 -m conntrack --ctstate NEW -j ACCEPT
#/sbin/iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
#/sbin/iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

#sudo iptables -t nat -A  POSTROUTING -o eth0 -j MASQUERADE
