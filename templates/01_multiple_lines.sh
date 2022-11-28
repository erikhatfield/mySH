#!/bin/bash

################################################################
# for all lines in included (as param) text file, perform SEND #
#
# e.g.: 01_multiple_lines.sh /path/to/textfile.txt

filepath="$1"

# read line from $filepath
while read line
do
    # $line variable contains current line read from the file
    # display $line text on the screen or do something with it.

    echo "$line"
    ./02_operate_on_line.sh "$line"
done < $filepath


# The IFS (Internal Field Separator) is a special shell variable used for splitting words and line based on its value. The default value is .
##while IFS= read -r line
##do
##    # $line variable contains current line read from the file
##    # display $line text on the screen or do something with it.
##
##    ./02_operate_on_line.sh "$line"
##done < $filepath



###################
# known limitations
#
# text file handling hasnt been tested for special characters (or even qoutes lol)
#
# must cd into dir of this sh to use './'
################################################################
