#!/bin/bash

basesleeptime=10
failuresleeptime=5
failurepivot=5
locationlist="google.com bing.com"

if [ -r "netcheck.config" ]
then
	. ./netcheck.config
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
