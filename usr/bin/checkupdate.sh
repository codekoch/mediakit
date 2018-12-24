#!/bin/bash
### Settings
path="/tmp/data/FILES"
file="Mediakit.img256"
server="http://mediakit.aeg-kaarst.org/images"
###
rm $path/update.txt
license="`cat /media/mk/boot/mediakit.lic`"
localVersion="`cat /etc/init.d/info.sh | grep -i "Mediakit V" | awk '{ print $4}'`"
rm $path/version.txt
curl -u $license -o $path/version.txt -C - -O $server/version.txt
lines="`cat $path/version.txt | wc -l`"
if [ $lines != "0" ]; then
  zenity --info --title "Update Check" --text "IP or license not ok! Get a valid license for your IP-adress...\nUpdate check cancelled." --timeout 3 2> /dev/null
  exit
fi
externalVersion="`cat $path/version.txt`"
rm $path/version.txt
if [ $externalVersion != $localVersion ]; then
  update=1
  installUpdate=1
  questiontext="Update from Mediakit $localVersion to Mediakit $externalVersion possible!\nStart/Continue update?\n(You can cancel the update at every time,\nit can be continued at the next reboot)"
  zenity --question --text "$questiontext" 2> /dev/null
  case $? in 
    0) update=0
    ;; 
    1) echo "Aborting update process!"
    ;;  
  esac
  if  [ $update = 0 ]; then
    finished="no"
    hashok="no"
    (
    curl -u $license -o $path/$file -C - -O $server/$file 2>&1 
    ) | stdbuf -oL tr '\r' '\n' | sed -u 's/^ *\([0-9][0-9]*\).*\( [0-9].*$\)/\1\n#Download Speed\:\2/' | zenity --progress --title "Downloading Update $externalVersion"  --ok-label="Continue" --cancel-label="Cancel Update" --auto-close 2> /dev/null &
    (
    # get zenity process id
    PID_ZENITY=${!}
    echo "PID="$PID_ZENITY
    # get firstly created child process id, which is running all tasks
    PID_CHILD=$(pgrep -o -P $$)
    echo "PID="$PID_CHILD
    while [ "$PID_ZENITY" != "" ]
    do
      # get PID of all running tasks
      PID_TASKS=$(pgrep -d ' ' -P ${PID_CHILD})
      # check if zenity PID is still there (dialog box still open)
      PID_ZENITY=$(ps h -o pid --pid ${PID_ZENITY} | xargs)
      # sleep for 2 second
      sleep 2
    done
    )
    pid=$(ps -e | grep curl | awk '{print $1}')
    if [ "$pid" != "" ]; then
     kill -9 $pid
     zenity --info --title "Update" --text "Update download was not finished ... try again later!" 2> /dev/null
     exit
    fi
    if [ "$pid" = "" ]; then
     finished="yes"
    fi
    # Check if File allready is finished
    hash=1
    hashcheck="no"
    curl -u $license -o $path/Mediakit.hash -C - -O $server/Mediakit.hash
    hash="`cat $path/Mediakit.hash`"
    localHash="bla"
    (
    md5sum $path/$file | awk '{ print $1}' > $path/Mediakitlocal.hash 
    ) | zenity --title "Filecheck" --text "Checking downloaded File. Please Wait..."  --ok-label="Continue" --progress --pulsate --auto-close 2> /dev/null &
    (
    PID_ZENITY=${!}
    # get firstly created child process id, which is running all tasks
    PID_CHILD=$(pgrep -o -P $$)
    while [ "$PID_ZENITY" != "" ]
    do
      # get PID of all running tasks
      PID_TASKS=$(pgrep -d ' ' -P ${PID_CHILD})
      # check if zenity PID is still there (dialog box still open)
      PID_ZENITY=$(ps h -o pid --pid ${PID_ZENITY} | xargs)
      # sleep for 2 second
      sleep 2
    done
    )
    pid=$(ps -e | grep md5sum | awk '{print $1}')
    if [ "$pid" != "" ]; then
      kill -9 $pid
      zenity --info --title "Filecheck" --text "Update check was not finished ... repeat again later!" 2> /dev/null
      exit
    fi
    if [ "$pid" = "" ]; then
      hashcheck="yes"
    fi
    localHash="`cat $path/Mediakitlocal.hash`"
    if [ $hash != $localHash ]; then
      zenity --info --title "Filecheck" --text "Update download was not finished ... try again later!" 2> /dev/null 
      if [ $finished = "yes" ] && [ $hashcheck = "yes" ]; then
        echo "removing corrupted update file!"
        rm $path/$file
      fi
      exit
    fi
    if [ $hash = $localHash ]; then
      hashok="yes"
    fi
    zenity --question --text "Update ready for install! Do you want to restart to install the update?" 2> /dev/null
    case $? in
      0) installUpdate=0
      ;;
      1) echo "Aborting update install!" | exit
      ;;
    esac
    if  [ $installUpdate = 0 ]; then
      echo "Mediakit $externalVersion" > $path/update.txt
      /sbin/bootIntoUpdate.sh
    fi
  fi
  zenity --info --title "Update" --text "Update cancelled!" --timeout 3 2> /dev/$
fi

