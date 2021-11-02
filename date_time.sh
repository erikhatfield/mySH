#!/bin/sh

########
# Date #
########
# Record initial time stamp (in seconds since 010170 - January 1st, 1970 @0000)
initialTimeStamp=$(date +"%s")
echo $initialTimeStamp
echo
sleep 1
#Today's date and time mmddyy@hhmm
echo "Today's date and @time is "$(date +"%m%d%y @%H%M")
echo
sleep 1
# Save a progressed time stamp and compare (subtraction operation)
progressingTimeStamp=$(date +"%s")
echo $(( progressingTimeStamp - initialTimeStamp ))" seconds have elapsed since initial time stamp"
echo

