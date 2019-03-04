#!/bin/sh
sudo cp /etc/dhcpcd.conf.intern /etc/dhcpcd.conf
sudo service dhcpcd restart
sudo service dnsmasq restart
sudo service hostapd restart

