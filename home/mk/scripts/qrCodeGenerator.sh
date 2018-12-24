#!/bin/bash
text=$(zenity --entry --text "Bitte geben Sie den Text ein, der in einen QR-Code umgewandelt werden soll:" --title "QR-Code Generator")
echo $text
qrencode -s 20 -o tmp.png "$text"
#mogrify -fill black -gravity NorthWest -font FreeMono -pointsize 30 -draw "text 11,0 '"$text"'" tmp.png
sleep 1
feh tmp.png 
rm tmp.png
