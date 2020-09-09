#!/bin/bash

echo "Start of netcheck"

var1=10
sleeptime=5  # sleep interval in seconds
#pinglocation="google.com"
locationlist="google.com ibm.com bing.com"

while [ $var1 ]
do
	for pinglocation in $locationlist
	do
		echo "---------------------------------------------" >> netup.log
		date >> netup.log
		ping -c 1 $pinglocation >> netup.log
		echo "---------------------------------------------" >> netup.log
		echo "  " >> netup.log
		sleep $sleeptime
	done
done

