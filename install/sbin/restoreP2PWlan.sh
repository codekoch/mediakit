#!/bin/sh
# setting up p2p-wlan
pcmanfm --set-wallpaper="/usr/share/rpd-wallpaper/loading.jpg"
sudo service dnsmasq stop
sudo service hostapd stop
mac="`sudo /sbin/ifconfig eth0 | grep 'ether ' | awk '{ print $2}'`"
mac2="`echo "$mac" | sed 's/\://g'`"
wlanssid="MK-"$mac2
#pin="`cat /etc/init.d/info.sh | grep -i "pin=" | sed 's/pin="//g' | sed 's/"//g'`"
sudo  sed -i "s/device_name=.*$/device_name=$wlanssid/g" /etc/wpa_supplicant/wpa_supplicant.conf
ain="$(sudo wpa_cli interface)"
echo "${ain}"
if [ `echo "${ain}" | grep -c "p2p-wl"` -gt 0 ] 
then
        echo "already on"

else
        echo "ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev" > /etc/wpa_supplicant/wpa_supplicant.conf
        echo "update_config=1" >> /etc/wpa_supplicant/wpa_supplicant.conf
        echo "" > /var/lib/misc/dnsmasq.leases
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
#sudo  sed -i 's/interface p2p-wlan0.*$/interface '$p2pinterface'/g' /etc/dhcpcd.conf
sudo  sed -i 's/interface=p2p-wlan0.*$/interface='$p2pinterface'/g' /etc/dnsmasq.conf
#sudo  sed -i 's/sudo wpa_cli -ip2p-wlan0.*$/sudo wpa_cli -i'$p2pinterface' wps_pin any '$pin'00000/g' /opt/lazycast/alln$
sudo ifconfig $p2pinterface 192.168.173.1
wlanModul1="`ip link show | grep -i 'wlan1' | awk '{print $2}' | sed 's/://g'`"

if ! [ -z $wlanModul1 ]; then
sudo /sbin/iptables -F
sudo /sbin/iptables -X
sudo /sbin/iptables -t nat -F
sudo sysctl -w net.ipv4.ip_forward=1
sudo sysctl -w net.ipv6.conf.all.forwarding=1
sudo iptables -t nat -A  POSTROUTING -o eth0 -j MASQUERADE
sudo service dnsmasq start
sudo service hostapd start
pcmanfm --set-wallpaper="/usr/share/rpd-wallpaper/info.jpg"
fi
