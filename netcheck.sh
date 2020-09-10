#!/bin/bash

echo "Start of netcheck"

var1=10
sleeptime=5  # sleep interval in seconds
#pinglocation="google.com"
locationlist="google.com ibm.com bing.com www.microsoft.com miamioh.edu"

while [ $var1 ]
do
	for pinglocation in $locationlist
	do
#		echo "---------------------------------------------" >> netup.log
#		date >> netup.log
#		ping -c 1 $pinglocation >> netup.log
#		echo "---------------------------------------------" >> netup.log
#		echo "  " >> netup.log
		ping -c 1 $pinglocation > pingout.tmp
		date
# write everything to full log and copy to failure log
		datestr=`date`
		# write the date separately since it is parsing on the spaces in the date output
		printf "%s " $datestr >> full.log
		printf " - %s" $pinglocation >> full.log
		if	grep "1 packets transmitted, 1 received" pingout.tmp
		then
			printf " - success \n" >> full.log
		else
			printf " - ****failure****\n" >> full.log
			printf "%s " $datestr >> failure.log
			printf " - %s\n" $pinglocation >> failure.log
		fi
		sleep $sleeptime
	done
done

