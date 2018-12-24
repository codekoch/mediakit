#!/bin/bash
sudo  sed -i 's/mmcblk0p2/sda2/g' /sbin/bootIntoMediakit.sh
sudo  sed -i 's/mmcblk0p2/sda2/g' /sbin/bootIntoRetropie.sh
#sudo rm /etc/ssh/ssh_host_* && sudo dpkg-reconfigure openssh-server
