#!/bin/sh

###############################################################################
# IF statements                                                               #
###############################################################################

# Comparing string variables specific IF statement syntax/brackets
string_variable="Y"
if [ $string_variable == "Y" ]; then
			echo "If Statement: String comparision"
else
			echo ""
fi
# IF statements with integer operations require different syntax/brackets  than string comparisions
int_variable=14
if (( $int_variable <= 14 )); then
			echo "If Statement: Integer comparision"
else
			echo ""
fi

#exit
