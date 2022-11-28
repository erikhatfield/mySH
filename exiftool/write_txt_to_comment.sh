#!/bin/bash

################################################################
# for all lines in included (as param) text file, build string #
# write string to exiftool comment tag
#
# e.g.: ./write_txt_to_comment.sh /path/to/textfile.txt /path/to/imagefile.png

textfilepath="$1"
imagefilepath="$2"
buildMeUpString=""

# read line from $textfilepath
while read line
do
    # $line variable contains current line read from the file
    echo "$line"
    buildMeUpString=$buildMeUpString"$line"", "
done < $textfilepath

# add time stamp
buildMeUpString=$buildMeUpString"UserTimeAtWrite=$(date +'%m%d%y@%H%M')"

echo "$buildMeUpString"

#######################
#######################
# EXIFTOOL (requires) #

#write comment tag w exiftool
exiftool -overwrite_original_in_place -Comment="$buildMeUpString" "$imagefilepath"

#read exiftool (test)
exiftool "$imagefilepath"

#######################
#######################



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
