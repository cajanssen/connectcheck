#!/bin/bash

# base values
var1=10
basesleeptime=50  # sleep interval in seconds
failuresleeptime=50  # sleep interval in seconds
locationlist="google.com ibm.com bing.com www.microsoft.com"
failurepivot=5

#if [ -r "netcheck.config" ]
#then
#	. ./netcheck.config
#fi

# if need more than one parameter in the future, will need to change
#    the check and parameter ordering or identification
# right now config file is only parameter
if [ $# -eq 1 ]
then
	if [ -r $1 ]
	then
		. $1
	fi
fi

# operating values
sleeptime=$basesleeptime
failurecount=0
fullfilename="netcheck-full-"`date +%F`".log"
failfilename="netcheck-full-"`date +%F`".log"

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
		printf "%s " $datestr >> $fullfilename
		printf " - %s" $pinglocation >> $fullfilename
		if	grep "1 packets transmitted, 1 received" pingout.tmp >> /dev/null
		then
			printf " - success \n" >> $fullfilename
			failurecount=0
			sleeptime=$basesleeptime
		else
			printf " - ****failure****\n" >> $fullfilename
			printf "%s " $datestr >> $failfilename
			printf " - %s\n" $pinglocation >> $failfilename
			failurecount=$[$failurecount + 1]
		fi
		sleep $sleeptime
	done
done

