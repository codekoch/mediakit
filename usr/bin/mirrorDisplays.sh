#!/bin/bash
displays=($(xrandr --query | grep -i " connected" | awk '{ print $1}'))
prim=`xrandr --query | grep -i " primary" | awk '{ print $1}' | sed 's/+.*//'`
max=`xrandr --query | grep -i " primary" | awk '{ print $4}' | sed 's/+.*//'`
for display in "${displays[@]}"
do
	if ! [ $display = $prim ]; then
		xrandr --output $display --same-as $prim
	fi
done

