#!/bin/sh
### BEGIN INIT INFO
# Provides:          Für welches Programm ist das Script?
# Required-Start:    
# Required-Stop:     
# Default-Start:     
# Default-Stop:      
# Short-Description: Kurze Beschreibung
# Description:       Längere Beschreibung
### END INIT INFO
#/sbin/restoreMkProfile.sh
#/sbin/mirrorDisplays.sh
version="V2.27"
#zenity --info --width=150 --height=10 --text="Mediakit $version x86" --timeout=6 2> /dev/null  &
#sudo service smbd stop
#sudo service nmbd stop
#sudo /sbin/ifconfig >  /home/pi/start.log 
#rm /usr/share/applications/chromium.desktop


mac="`/sbin/ifconfig eth0 | grep 'ether ' | awk '{ print $2}'`"
lanIP="`/sbin/ifconfig eth0 | grep 'inet' | awk '{ print $2}' | head -1`"

wlanIP="`/sbin/ifconfig wlan0 | grep 'inet' | awk '{ print $2}' | head -1`"
mac2="`echo "$mac" | sed 's/\://g'`"
wlanssid="MK-"$mac2
oldwlanssid="`cat /etc/hostapd/hostapd.conf | grep -i 'ssid' | sed 's/ssid=//g'`"
oldLanIP="`cat /home/mk/oldLanIP.txt`"

echo "WLANIP:"$wlanIP >>  /home/mk/start.log
echo "LANIP:"$lanIP >>  /home/mk/start.log
echo "OldLANIP":$oldLanIP >>  /home/mk/start.log
echo "WLANssid:"$wlanssid >>  /home/mk/start.log
echo "oldWLANssid:"$oldwlanssid >>  /home/mk/start.log
newscreen=1
reboot=0

if [ $wlanssid != $oldwlanssid ]; then

newscreen=1
reboot=1
echo "reboot and newscreen..." >>  /home/mk/start.log
fi

if [ -z $oldLanIP ]; then
newscreen=1  
echo "newscreen..." >>  /home/mk/start.log
fi

if [ $lanIP != $oldLanIP ]; then
newscreen=1  
echo "newscreen..." >>  /home/mk/start.log
fi
if  [ -z $lanIP ]; then
newscreen=1  
echo "newscreen..." >>  /home/mk/start.log
fi

if  [ -z $wlanIP ]; then
wlanIP='noDevice'
fi
#/sbin/stopSamba.sh
if  [ $newscreen = 1 ]; then
 echo "generating newscreen..." >>  /home/mk/start.log
 echo $lanIP > /home/mk/oldLanIP.txt
 sed -i 's/ssid=.*$/ssid='$wlanssid'/g' /etc/hostapd/hostapd.conf
 password="`cat /etc/hostapd/hostapd.conf | grep -i 'wpa_passphrase=' | sed 's/wpa_passphrase=//'`"
 myWlan="`sudo cat /etc/hostapd/hostapd.conf | grep 'ssid' | sed 's/ssid=//g' `"
 pointsize=30
 bigpointsize=50
 yp=40
 convert /home/mk/Bilder/mediakit/logo.jpg -fill white -gravity NorthEast -font FreeMono -pointsize 30 -draw "text 0,"$yp" 'mediakit $version (x86)'" /home/mk/Bilder/mediakit/info.jpg
 yp=$(($yp+$pointsize))
 mogrify -fill white -gravity NorthEast -font FreeMono -pointsize $pointsize -draw "text 0,"$yp" 'IP:"$lanIP"(LAN)'" /home/mk/Bilder/mediakit/info.jpg
 yp=$(($yp+$pointsize))
 mogrify -fill white -gravity NorthEast -font FreeMono -pointsize $pointsize -draw "text 0,"$yp" 'IP:"$wlanIP"(WLAN)'" /home/mk/Bilder/mediakit/info.jpg
 yp=$(($yp+$pointsize))
 mogrify -fill yellow -gravity NorthEast -font FreeMono -pointsize $bigpointsize -draw "text 0,"$yp" '"$myWlan"'" /home/mk/Bilder/mediakit/info.jpg
 yp=$(($yp+$bigpointsize))
 mogrify -fill yellow -gravity NorthEast -font FreeMono -pointsize $bigpointsize -draw "text 0,"$yp" '"$password"'" /home/mk/Bilder/mediakit/info.jpg
  if  [ -z $lanIP ]; then
  yp=$(($yp+$bigpointsize))
  mogrify -fill red -gravity NorthEast -font FreeMono -pointsize $pointsize -draw "text 0,"$yp" 'No LAN Connection!'" /home/mk/Bilder/mediakit/info.jpg
 fi
 if  [ $reboot = 1 ]; then
   #zenity --width=600 --height=200 --info --text="Neue Hardware erkannt.\n Passen Sie das System an (Auflösung etc.) und speichern Sie Ihre Veränderungen in einem neuen mediakit Modul\n/mediakit/modules/02_maschinename.sb \n(siehe http://mediakit.education/x86_root.php)" 2> /dev/null 
   #yp=$(($yp+$bigpointsize))
   #mogrify -fill red -gravity NorthEast -font FreeMono -pointsize 25 -draw "text 0,"$yp" 'Neue MAC Adresse erkannt. Restart oder Netzwerkreset erforderlich!'" /home/mk/Bilder/mediakit/info.jpg

   systemctl restart networking.service
   ifup wlan0
   systemctl restart hostapd.service
 fi
fi
sleep 3
/usr/bin/blockAtStartup.sh
