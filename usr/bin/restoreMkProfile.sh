#!/bin/sh
if [ -e /dev/mmcblk0p2 ]
  then
    echo "SD Filesystem exists." >>  /home/pi/start.log
    sudo mount /dev/mmcblk0p2 /tmp
    sudo mount /dev/mmcblk0p1 /media/mk/boot
    sudo /sbin/checkupdate.sh
    sudo rm -R /tmp/data/Mediakit.img256/home/mk/* #Remove the mk folder.
    sudo rm -R /tmp/data/Mediakit.img256/home/mk/.* #Remove the mk folder.
    sudo umount /dev/mmcblk0p2
    sudo umount /dev/mmcblk0p1
else
    echo "HD Filesystem exists." >>  /home/pi/start.log
    sudo mount /dev/sda2 /tmp
    sudo mount /dev/sda1 /media/mk/boot
    sudo /sbin/checkupdate.sh
    sudo rm -R /tmp/data/Mediakit.img256/home/mk/* #Remove the mk folder.
    sudo rm -R /tmp/data/Mediakit.img256/home/mk/.* #Remove the mk folder.
    sudo umount /dev/sda2
    sudo umount /dev/sda1
fi

