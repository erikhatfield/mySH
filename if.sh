#!/bin/sh

###############################################################################
# IF statements                                                               #
###############################################################################

##################################################################
# Comparing string variables specific IF statement syntax/brackets
string_variable="Y"
if [ $string_variable == "Y" ]; then
	echo "If Statement: String comparision"
else
	echo ""
fi

##############################
# Checking for an empty string
iamemptyorami=""
if [ ! -z "$iamemptyorami" ]; then
	echo "Guess I'm not empty"
else
	echo "Empty string is empty"
fi;

###################################################################################################
# IF statements with integer operations require different syntax/brackets  than string comparisions
int_variable=14
if (( $int_variable <= 14 )); then
	echo "If Statement: Integer comparision"
else
	echo ""
fi

###############
# check whereis
whereistimbuckii=$(whereis timbuckii)
if [ "$whereistimbuckii" = "timbuckii:" ]; then 
    echo "Sir, Tim Buck who sir?"
else
    echo $whereistimbuckii  
fi;

################################
# check for presence of a string
ifEmptyNoMatch=$(cat ~/.zshrc | grep "alias art=") ###careful here, could be multiples
if [ ! -z "$ifEmptyNoMatch" ]; then
	echo "Oh thank God, †, we have art!"
else
	echo "Install alias art here"
fi;

#####
#exit
exit
