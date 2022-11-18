#!/bin/sh

#######################################################
# perform operation on the file passed in as param $1 #
echo && echo "operating on $1"
# macos operation (stat -> show file permissions as simple number i.e. 777)
stat -f %A $1
echo && echo "###############" && echo

