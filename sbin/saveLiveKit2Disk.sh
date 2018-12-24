#!/bin/bash
# script by Olaf Koch 7.11.2018

if [[ ${EUID} -ne 0 ]]; then
  echo "this script must be executed with elevated privileges"
  exit 1
fi

# get root device and partition
sourcepath=`blkid -o list | grep -i "/run/initramfs/memory/data" | awk '{print $1}' `
devicepart=`blkid -o list | grep -i "/run/initramfs/memory/data" | awk '{print $1}' | sed 's/\/dev\///'`
device=`echo ${devicepart%?}`

# get other disks
mapfile -t info < <( lsblk )



i=1
for entry in "${info[@]}"
do
    if [[ `echo "$entry" | awk '{ print $6}'` == "disk" ]]; then
      if [[ `echo "$entry" | awk '{ print $1}'` == "$device" ]];then    
       echo -e "\033[43m SOURCE \e[0m" $entry
      else
       echo -e "\033[43m $i \e[0m" $entry
       devices[$i]=`echo "$entry" | awk '{ print $1}'`
       i=`expr $i + 1` 
     fi
    else
      echo $entry
    fi
done
 
tput setaf 11
echo "Please select the disknumber of the destination device: (All data on this device will be destroyed!)"
tput sgr0
read destination
destinationpath="/dev/${devices[$destination]}"
tput setaf 11
echo "Copy mediakit from ${sourcepath%?} to $destinationpath..."
echo "${sourcepath} (mediakit data partition) is mounted on /run/initramfs/memory/data"
echo "(Enter to continue/STRG-C to abort)"
tput sgr0
read
if ! [[ -e /a ]]; then
 mkdir /a
fi
#umount /a
#mount ${sourcepath} /a
#echo "${sourcepath} is now mounted on /a"
/sbin/createBootDevice.sh $destinationpath
#umount /a
#mount ${sourcepath} /run/initramfs/memory/data
