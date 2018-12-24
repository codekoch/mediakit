#!/bin/bash
zenity --info --text="Unblocking Mediakit Device..." --timeout=4 2> /dev/null  &
ip=`cat /var/log/auth.log | grep -i "ssh2" | awk END'{print $11}'`
/sbin/unblockIP.sh $ip
