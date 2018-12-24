#!/bin/bash 
name="serverQR"
test=`/bin/ps -aux | grep -i $name | wc -l` 
echo $test
if [ $test == 1 ] 
then 
echo $1 " is not running"
fi 

if [ $test != 1 ]
then
echo $1 " is running"
fi

