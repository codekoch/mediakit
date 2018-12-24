#!/bin/bash
sudo  sed -i 's/sda2/mmcblk0p2/g' /sbin/bootIntoMediakit.sh
sudo  sed -i 's/sda2/mmcblk0p2/g' /sbin/bootIntoRetropie.sh
#sudo rm /etc/ssh/ssh_host_* && sudo dpkg-reconfigure openssh-server
