#!/bin/sh
mv /home/mk/.kodi /home/mk/.kodi_old
mv /home/mk/.kodi_old /home/mk/.kodi
chmod -R 777 /home/mk/.kodi
cd /opt/lazycast
./start.sh &
zenity --info --text="ready to connect!" --timeout=8 2> /dev/null  &
