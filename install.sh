#!/bin/sh
echo "install and configure everything..."
sudo rm /etc/rc3.d/S01randomWifi.sh
sudo update-rc.d -f randomWifi remove
sudo update-rc.d -f restoreTpProfile.sh remove
echo "copying every script to the right place..."
sudo cp -R ./install/* /
echo "done! A restart is necessary!"
echo "sudo shutdown -r now" 
