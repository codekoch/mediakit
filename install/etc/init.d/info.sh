#!/bin/sh
wlanModul1="`ip link show | grep -i 'wlan1' | awk '{print $2}' | sed 's/://g'`"
mac="`sudo /sbin/ifconfig eth0 | grep 'ether ' | awk '{ print $2}'`"
lanIP="`sudo /sbin/ifconfig eth0 | grep 'inet' | awk '{ print $2}' | head -1`"
if [ -z $wlanModul1 ]; then
wlanIP="`sudo /sbin/ifconfig wlan0 | grep 'inet' | awk '{ print $2}' | head -1`"
else
wlanIP="`sudo /sbin/ifconfig wlan1 | grep 'inet' | awk '{ print $2}' | head -1`"
fi
mac2="`echo "$mac" | sed 's/\://g'`"
wlanssid="MK-"$mac2
oldwlanssid="`cat /etc/hostapd/hostapd.conf | grep -i 'ssid' | sed 's/ssid=//g'`"
oldLanIP="`cat /home/pi/oldLanIP.txt`"
version="`cat /usr/share/plymouth/themes/pix/pix.script | grep -i 'Copyright' | awk '{ print $3}' | sed 's/.*(\"//'`"

#echo "WLANIP:"$wlanIP >>  /home/pi/start.log
#echo "LANIP:"$lanIP >>  /home/pi/start.log
#echo "OldLANIP":$oldLanIP >>  /home/pi/start.log
#echo "WLANssid:"$wlanssid >>  /home/pi/start.log
#echo "oldWLANssid:"$oldwlanssid >>  /home/pi/start.log
newscreen=1
reboot=0

if [ $wlanssid != $oldwlanssid ]; then
newscreen=1
reboot=1
#echo "reboot and newscreen..." >>  /home/pi/start.log
fi

if [ -z $oldLanIP ]; then
newscreen=1  
#echo "newscreen..." >>  /home/pi/start.log
fi

if [ $lanIP != $oldLanIP ]; then
newscreen=1  
#echo "newscreen..." >>  /home/pi/start.log
fi
if  [ -z $lanIP ]; then
newscreen=1  
#echo "newscreen..." >>  /home/pi/start.log
fi

#/sbin/stopSamba.sh
if  [ $newscreen = 1 ]; then
#echo "generating newscreen..." >>  /home/pi/start.log
#echo $lanIP > /home/pi/oldLanIP.txt
sudo  sed -i 's/ssid=.*$/ssid='$wlanssid'/g' /etc/hostapd/hostapd.conf
password="`cat /etc/hostapd/hostapd.conf | grep -i 'wpa_passphrase=' | sed 's/wpa_passphrase=//'`"
pin="`echo $password | sed 's/mediakit//'`"
myWlan="`sudo cat /etc/hostapd/hostapd.conf | grep 'ssid' | sed 's/ssid=//g' `"
#sudo  sed -i 's/ssid=.*$/ssid="'$myWlan'"/g' /etc/wpa_supplicant/wpa_supplicant.conf
pointsize=30
bigpointsize=50
yp=10
sudo convert /usr/share/rpd-wallpaper/logo.jpg -fill white -gravity NorthEast -font FreeMono -pointsize 30 -draw "text 0,10 'mediakit "$version"'" /usr/share/rpd-wallpaper/info.jpg
yp=$(($yp+$pointsize))
sudo mogrify -fill white -gravity NorthEast -font FreeMono -pointsize $pointsize -draw "text 0,"$yp" 'IP:"$lanIP"(LAN)'" /usr/share/rpd-wallpaper/info.jpg
yp=$(($yp+$pointsize))
if [ -z $wlanModul1 ]; then
sudo mogrify -fill white -gravity NorthEast -font FreeMono -pointsize $pointsize -draw "text 0,"$yp" 'IP:"$wlanIP"(WLAN INTERN)'" /usr/share/rpd-wallpaper/info.jpg
else
sudo mogrify -fill white -gravity NorthEast -font FreeMono -pointsize $pointsize -draw "text 0,"$yp" 'IP:"$wlanIP"(WLAN USB)'" /usr/share/rpd-wallpaper/info.jpg
fi
yp=$(($yp+$pointsize))
if [ -z $wlanModul1 ]; then
sudo mogrify -fill yellow -gravity NorthEast -font FreeMono -pointsize $pointsize -draw "text 0,"$yp" 'WLAN SSID:'" /usr/share/rpd-wallpaper/info.jpg
else
sudo mogrify -fill yellow -gravity NorthEast -font FreeMono -pointsize $pointsize -draw "text 0,"$yp" 'WLAN / MIRACAST SSID:" /usr/share/rpd-wallpaper/info.jpg
fi
yp=$(($yp+$pointsize))
sudo mogrify -fill yellow -gravity NorthEast -font FreeMono -pointsize $bigpointsize -draw "text 0,"$yp" '"$myWlan"'" /usr/share/rpd-wallpaper/info.jpg
yp=$(($yp+$bigpointsize))
sudo mogrify -fill yellow -gravity NorthEast -font FreeMono -pointsize $bigpointsize -draw "text 0,"$yp" 'KEY:"$password"'" /usr/share/rpd-wallpaper/info.jpg
if ! [ -z $wlanModul1 ]; then
yp=$(($yp+$bigpointsize))
sudo mogrify -fill yellow -gravity NorthEast -font FreeMono -pointsize $bigpointsize -draw "text 0,"$yp" 'PIN:"$pin"00000'" /usr/share/rpd-wallpaper/info.jpg
fi

if  [ -z $lanIP ]; then
yp=$(($yp+$bigpointsize))
sudo mogrify -fill red -gravity NorthEast -font FreeMono -pointsize $pointsize -draw "text 0,"$yp" 'No LAN Connection!'" /usr/share/rpd-wallpaper/info.jpg
fi
if  [ $reboot = 1 ]; then
zenity --width=600 --height=400 --info --text="First start after install. Reboot required..." --timeout=5 2> /dev/null  &
#yp=$(($yp+$pointsize))
#sudo mogrify -fill red -gravity NorthEast -font FreeMono -pointsize $pointsize -draw "text 0,"$yp" 'Network has changed. Please Reboot!'" /usr/share/rpd-wallpaper/info.jpg
/sbin/renewSSHKeys.sh
echo "Checking if HD or SD filesystem exists... " >>  /home/pi/start.log
if [ -e /dev/mmcblk0p2 ]
  then
    echo "SD Filesystem exists." >>  /home/pi/start.log
/sbin/setBootIntoMmc.sh
else
    echo "HD Filesystem exists." >>  /home/pi/start.log
/sbin/setBootIntoSda.sh
fi
/sbin/bootIntoMediakit.sh
fi
fi
#service guacd stop &
#service jetty9 stop &
#pcmanfm --set-wallpaper /usr/share/rpd-wallpaper/info.jpg

