#!/bin/sh
echo "install and configure everything..."
sudo update-rc.d -f randomWifi remove
echo "copying every script to the right place..."
sudo cp -R ./install/* /
echo "done! A restart is necessary!"
echo "sudo shutdown -r now" 
