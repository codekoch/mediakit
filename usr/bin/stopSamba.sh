#!/bin/sh
zenity --info --text="Stoping Samba" --timeout=4 2> /dev/null  &
sudo service smbd stop
sudo service nmbd stop
