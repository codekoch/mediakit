#!/bin/bash
# script by Olaf Koch 7.11.2018

if [[ ${EUID} -ne 0 ]]; then
  echo "this script must be executed with elevated privileges"
  exit 1
fi

devicepart=`blkid -o list | grep -i "/run/initramfs/memory/data" | awk '{print $1}' `
device=`echo ${devicepart%?}`


echo -e "Your System is on device  \033[41m "$device"\e[0m"
echo -e "the partition is  \033[41m"$devicepart"\e[0m"
mapfile -t info < <( blkid -o list )

mkdir /b

for entry in "${info[@]}"
do
    if [[ `echo "$entry" | awk '{ print $1}'` =~ "/dev/" ]]; then
      updatepart=`echo "$entry" | awk '{ print $1}'`
      filesystem=`echo "$entry" | awk '{ print $2}'`
      if ! [[ $filesystem == "(not" ]]; then
       if ! [[ $updatepart == $devicepart ]]; then
        echo -e "search on $updatepart" 
        umount /b
        mount $updatepart /b
        if [[ -e /b/mediakit/ ]]; then
         echo -e "Updating with data from \033[43m"$updatepart" \e[0m" 
         rm -f /run/initramfs/memory/data/mediakit/*          
         rm -f /run/initramfs/memory/data/mediakit/modules/*
         cp -R /b/mediakit/ /run/initramfs/memory/data/
         if [[ -e /b/vmlinuz ]]; then
          cp /b/vmlinuz /run/initramfs/memory/data/ 
          cp /b/initrfs.img /run/initramfs/memory/data/
          cp /b/vmlinuz /run/initramfs/memory/data/mediakit/boot/ 
          cp /b/initrfs.img /run/initramfs/memory/data/mediakit/boot/
         else
          cp /b/mediakit/boot/vmlinuz /run/initramfs/memory/data/
          cp /b/mediakit/boot/initrfs.img /run/initramfs/memory/data/
          cp /b/mediakit/boot/vmlinuz /run/initramfs/memory/data/mediakit/boot/         
          cp /b/mediakit/boot/initrfs.img /run/initramfs/memory/data/mediakit/boot/
          
         fi
         echo "Update completed!"
         echo "remove update device and press any return to restart..."
         read
         shutdown -r now
         exit
        fi
       fi
      fi
    fi
done

