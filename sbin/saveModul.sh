#!/bin/bash
/usr/bin/savechanges /run/initramfs/memory/data/mediakit/modules/$1 
echo "Modul $1 saved to /mediakit/modules/"
read -rsn1 -p"<Drücken Sie eine Taste, um das Fenster zu schließen>"
exit


