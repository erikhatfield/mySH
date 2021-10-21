#!/bin/sh

###############################################################################
# IF statements                                                               #
###############################################################################

string_variable="Y"
if [ $string_variable == "Y" ]; then
			echo "If Statement: String comparision"
else
			echo ""
fi

int_variable=14
if (( $int_variable <= 14 )); then
			echo "If Statement: Integer comparision"
else
			echo ""
fi

#exit
