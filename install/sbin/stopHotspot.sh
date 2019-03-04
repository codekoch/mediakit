#!/bin/sh
sudo service hostapd stop
sudo cp /etc/dhcpcd.conf.normal /etc/dhcpcd.conf
sudo service dhcpcd restart

