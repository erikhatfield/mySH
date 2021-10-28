#!/bin/sh

#########################
## basic instructions: ##
## run both of these lines on the command line from within the containment directory.
#% chmod u+x basics_first.sh
#% sh ./basics_first.sh "the data passed into this shell script."

FIRST_ARGUMENT="${1?parameter missing - include an arguement when running this shell.}"
echo "The programming definition of an 'argument' is $FIRST_ARGUMENT!"
echo
echo
############################
## Basic variable syntax: ##
BASIC_STRING_VARIABLE_WITH_LONG_DESCRIPTOR_TITLE="Defining dot SH string variable syntax cannot include white space outside of quotes."
BASIC_STRING_VARIABLE_WITH_LONG_DESCRIPTOR_TITLE=$BASIC_STRING_VARIABLE_WITH_LONG_DESCRIPTOR_TITLE" The string must include quotes if white space is present in string."
echo "Echoing basic string variable on next line:"
echo $BASIC_STRING_VARIABLE_WITH_LONG_DESCRIPTOR_TITLE
echo
BASIC_STR="Basic string"
echo "$BASIC_STR variables can be referenced from within/outside quotes, and inside secondary quotes, e.g. '$BASIC_STR'"
echo
