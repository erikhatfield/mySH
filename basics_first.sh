#!/bin/sh

###################
## instructions: ##
## run both of these lines on the command line from within the containing directory.
#% chmod u+x basics_first.sh 
#% ./basics_first.sh "the data passed into this shell script."

FIRST_ARGUMENT="$1"
echo "The programming definition of an 'argument' is $FIRST_ARGUMENT!"

