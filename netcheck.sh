#!/bin/bash

# base values
var1=10
basesleeptime=50  # sleep interval in seconds
failuresleeptime=50  # sleep interval in seconds
locationlist="google.com ibm.com bing.com www.microsoft.com"
failurepivot=5

if [ -r "netcheck.config" ]
then
	. ./netcheck.config
fi

# operating values
sleeptime=$basesleeptime
failurecount=0

while [ $var1 ]
do
	for pinglocation in $locationlist
	do
		# change recheck frequency if multiple failures in a row
		if [ $failurecount -ge $failurepivot ]
		then
			sleeptime=$failuresleeptime
		fi

		# yes, ugly writing to a temporary file - difficulty writing usable output to a variable			
		ping -c 1 $pinglocation > pingout.tmp

		# write everything to full log and copy to failure log
		datestr=`date`
		# write the date separately since it is parsing on the spaces in the date output
		printf "%s " $datestr >> full.log
		printf " - %s" $pinglocation >> full.log
		if	grep "1 packets transmitted, 1 received" pingout.tmp
		then
			printf " - success \n" >> full.log
			failurecount=0
			sleeptime=$basesleeptime
		else
			printf " - ****failure****\n" >> full.log
			printf "%s " $datestr >> failure.log
			printf " - %s\n" $pinglocation >> failure.log
			failurecount=$[$failurecount + 1]
		fi
		sleep $sleeptime
	done
done

