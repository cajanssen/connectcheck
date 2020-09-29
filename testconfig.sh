#!/bin/bash

echo "number of arguments " $#
if [ $# -eq 1 ]
then
	echo $1
else
	echo "more or less than one param"
fi

basesleeptime=10
failuresleeptime=5
failurepivot=5
locationlist="google.com bing.com"

if [ $# -eq 1 ]
then
	if [ -r $1 ]
	then
		. $1
	fi
fi

sleeptime=$basesleeptime
echo "base sleeptime" $sleeptime
sleeptime=$failuresleeptime
echo "failure sleeptime" $sleeptime
printf "location list : "
printf "%s / " $locationlist
printf " \n"

failurecount=0
echo "failurecount" $failurecount
failurecount=$[$failurecount + 1]
echo "failurecount" $failurecount

for (( failurecount = 0; failurecount <= 5; failurecount++ ))
do
	if [ $failurecount -ge $failurepivot ]
	then
		printf "threshhold reached\n"
	else
		printf "not yet\n"
	fi
done

fullfilename="netcheck-full-"`date +%F`".log"
printf "%s\n" $fullfilename
printf "test sentence\n" >> $fullfilename
