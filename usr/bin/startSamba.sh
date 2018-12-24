#!/bin/sh
if [ -e /media/mk/berryboot/data/FILES ]
  then
echo "sharing /media/mk/berryboot/data/FILES"
else
echo "creating /media/mk/berryboot/data/FILES"
sudo mkdir /media/mk/berryboot/data/FILES
sudo chmod 777 /media/mk/berryboot/data/FILES 
echo "sharing /media/mk/berryboot/data/FILES"
fi
zenity --info --text="Starting Samba" --timeout=5 2> /dev/null  &
sudo service smbd restart
sudo service nmbd restart
