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
sudo  sed -i 's/wpa_passphrase=.*$/wpa_passphrase=mediakit'$n1$n2$n3'/g' /etc/hostapd/hostapd.conf.usb
sudo  sed -i 's/wpa_passphrase=.*$/wpa_passphrase=mediakit'$n1$n2$n3'/g' /etc/hostapd/hostapd.conf.intern
sudo  sed -i 's/pin=.*$/pin="'$n1$n2$n3'"/g' /etc/init.d/info.sh
sudo  sed -i 's/pin=.*$/pin="'$n1$n2$n3'"/g' /etc/init.d/info.sh

# set ssid from eth0 mac adress
mac="`sudo /sbin/ifconfig eth0 | grep 'ether ' | awk '{ print $2}'`"
mac2="`echo "$mac" | sed 's/\://g'`"
wlanssid="MK-"$mac2
sudo  sed -i 's/ssid=.*$/ssid='$wlanssid'/g' /etc/hostapd/hostapd.conf
sudo  sed -i 's/wlanssid=.*$/wlanssid="'$wlanssid'"/g' /etc/init.d/info.sh

# check if we have two wlan devices
wlanModul1="`ip link show | grep -i 'wlan1' | awk '{print $2}' | sed 's/://g'`"

if [ -z $wlanModul1 ]; then
### only 1 detected --> use internal wlan device
wlanModul="wlan0"
# setting up p2p-wlan
mac="`sudo /sbin/ifconfig eth0 | grep 'ether ' | awk '{ print $2}'`"
mac2="`echo "$mac" | sed 's/\://g'`"
wlanssid="MK-"$mac2
sudo  sed -i "s/device_name=.*$/device_name=$wlanssid/g" /etc/wpa_supplicant/wpa_supplicant.conf


ain="$(sudo wpa_cli interface)"
echo "${ain}"
if [ `echo "${ain}" | grep -c "p2p-wl"` -gt 0 ] 
then
        echo "already on"

else
        sudo wpa_cli p2p_find type=progessive
        sudo wpa_cli set device_name $wlanssid
        sudo wpa_cli set device_type 7-0050F204-1
        sudo wpa_cli set p2p_go_ht40 1
        sudo wpa_cli wfd_subelem_set 0 00060151022a012c
        sudo wpa_cli wfd_subelem_set 1 0006000000000000
        sudo wpa_cli wfd_subelem_set 6 000700000000000000
        perentry="$(wpa_cli list_networks | grep "\[DISABLED\]\[P2P-PERSISTENT\]" | tail -1)"
        echo "${perentry}"
        if [ `echo "${perentry}" | grep -c "P2P-PERSISTENT"`  -gt 0 ] 
        then
                networkid=${perentry%%D*}
                perstr="=${networkid}"
        else
                perstr=""
        fi
        echo "${perstr}"
        while [ `echo "${ain}" | grep -c "p2p-wl"`  -lt 1 ] 
        do
                while [ `echo "${ain}" | grep -c "p2p-wl"`  -lt 1 ]
                do
                        sudo wpa_cli p2p_group_add persistent$perstr freq=5
                        sleep 2
                        ain="$(sudo wpa_cli interface)"
                        echo "$ain"
                done
                sleep 5
                ain="$(sudo wpa_cli interface)"
                echo "$ain"
        done

 fi
p2pinterface=$(echo "${ain}" | grep "p2p-wl" | grep -v "interface")
sudo  sed -i 's/interface p2p-wlan0.*$/interface '$p2pinterface'/g' /etc/dhcpcd.conf.intern
sudo  sed -i 's/interface=p2p-wlan0.*$/interface='$p2pinterface'/g' /etc/dnsmasq.conf.intern
sudo  sed -i 's/sudo wpa_cli -ip2p-wlan0.*$/sudo wpa_cli -i'$p2pinterface' wps_pin any '$n1$n2$n3'00000/g' /opt/lazycast/allnew.sh
sudo ifconfig $p2pinterface 192.168.173.1        
sudo ifconfig wlan0 192.168.173.1
sudo  sed -i 's/wpa_passphrase=.*$/wpa_passphrase=mediakit'$n1$n2$n3'/g' /etc/hostapd/hostapd.conf.intern
sudo cp /etc/hostapd/hostapd.conf.intern /etc/hostapd/hostapd.conf
#sudo cp /etc/network/interfaces.intern /etc/network/interfaces
sudo cp /etc/dnsmasq.conf.intern /etc/dnsmasq.conf
#sudo cp /etc/dhcpcd.conf.intern /etc/dhcpcd.conf
#sudo cp /etc/sysctl.conf.intern /etc/sysctl.conf
#sudo  sed -i 's/denyinterfaces.*$/denyinterfaces wlan0/g' /etc/dhcpcd.conf
else
# setting up p2p-wlan
mac="`sudo /sbin/ifconfig eth0 | grep 'ether ' | awk '{ print $2}'`"
mac2="`echo "$mac" | sed 's/\://g'`"
wlanssid="MK-"$mac2
sudo  sed -i "s/device_name=.*$/device_name=$wlanssid/g" /etc/wpa_supplicant/wpa_supplicant.conf


ain="$(sudo wpa_cli interface)"
echo "${ain}"
if [ `echo "${ain}" | grep -c "p2p-wl"` -gt 0 ] 
then
        echo "already on"

else
        sudo wpa_cli p2p_find type=progessive
        sudo wpa_cli set device_name $wlanssid
        sudo wpa_cli set device_type 7-0050F204-1
        sudo wpa_cli set p2p_go_ht40 1
        sudo wpa_cli wfd_subelem_set 0 00060151022a012c
        sudo wpa_cli wfd_subelem_set 1 0006000000000000
        sudo wpa_cli wfd_subelem_set 6 000700000000000000
        perentry="$(wpa_cli list_networks | grep "\[DISABLED\]\[P2P-PERSISTENT\]" | tail -1)"
        echo "${perentry}"
        if [ `echo "${perentry}" | grep -c "P2P-PERSISTENT"`  -gt 0 ] 
        then
                networkid=${perentry%%D*}
                perstr="=${networkid}"
        else
                perstr=""
        fi
        echo "${perstr}"
        while [ `echo "${ain}" | grep -c "p2p-wl"`  -lt 1 ] 
        do
                while [ `echo "${ain}" | grep -c "p2p-wl"`  -lt 1 ]
                do
                        sudo wpa_cli p2p_group_add persistent$perstr freq=5
                        sleep 2
                        ain="$(sudo wpa_cli interface)"
                        echo "$ain"
                done
                sleep 5
                ain="$(sudo wpa_cli interface)"
                echo "$ain"
        done

fi

p2pinterface=$(echo "${ain}" | grep "p2p-wl" | grep -v "interface")

sudo  sed -i 's/interface p2p-wlan0.*$/interface '$p2pinterface'/g' /etc/dhcpcd.conf.usb
sudo  sed -i 's/interface=p2p-wlan0.*$/interface='$p2pinterface'/g' /etc/dnsmasq.conf.usb
sudo  sed -i 's/sudo wpa_cli -ip2p-wlan0.*$/sudo wpa_cli -i'$p2pinterface' wps_pin any '$n1$n2$n3'00000/g' /opt/lazycast/allnew.sh
sudo ifconfig $p2pinterface 192.168.173.1
sudo ifconfig wlan1 1.1.1.1
sudo cp /etc/hostapd/hostapd.conf.usb /etc/hostapd/hostapd.conf
#sudo cp /etc/network/interfaces.usb /etc/network/interfaces
sudo cp /etc/dnsmasq.conf.usb /etc/dnsmasq.conf
#sudo cp /etc/dhcpcd.conf.usb /etc/dhcpcd.conf
#sudo cp /etc/sysctl.conf.usb /etc/sysctl.conf
fi
sudo /sbin/iptables -F
sudo /sbin/iptables -X
sudo /sbin/iptables -t nat -F
sudo sysctl -w net.ipv4.ip_forward=1
sudo sysctl -w net.ipv6.conf.all.forwarding=1
sudo iptables -t nat -A  POSTROUTING -o eth0 -j MASQUERADE
sudo server dnsmasq restart
sudo server hostapd restart

zenity --info --text="GO!" --timeout=8 2> /dev/null  &
