#!/bin/bash
#echo '# /etc/auto.usb' > /etc/auto.usb
#echo '# mountpoint_key options location_device # man 5 autofs' >> /etc/auto.usb
usbLinks=($(ls /dev/disk/by-id | grep -i 'usb' | grep -i 'part'))
for usbLink in "${usbLinks[@]}"
do
	#echo $usbLink
        usbDevice="`readlink -e /dev/disk/by-id/$usbLink`"
        #echo $usbDevice
        #echo $usbLink    -fstype=auto :$usbDevice >> /etc/auto.usb
        usbLinkDir=`echo "$usbLink" | sed 's/://g'`
        sudo mkdir /media/USB-Storage/$usbLinkDir
        sudo chmod 777 /media/USB-Storage/$usbLinkDir
        sudo mount $usbDevice /media/USB-Storage/$usbLinkDir
done
#sudo /etc/init.d/autofs restart
pcmanfm /media/USB-Storage/

