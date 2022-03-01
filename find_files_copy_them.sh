#!/bin/bash

# Ask for the admin password upfront
sudo -v
# Keep-alive: update existing 'sudo' time stamp until finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# OpSys related iden vars to ensure proper everyday username even when executing from sudo ish root
# macOS:
# who am i | awk '{print $1}' #works with sudo
who_i_is=$(who am i | awk '{print $1}')
home_path="$HOME"
echo "who='$who_i_is', and home_path='$home_path'" && sleep 1

###############################################################################################
###############################################################################################
## Find all files in /the/path/provided/ that contain the 'somestring' in their filenames.
## Copy them to the /second/path/temp4now
## If they have duplicate file names, do not overwrite (default unix behaviour?)
##
## Run Instructions: 2 arguements passed in to script as such:
## arguement $1: "*search.string"; note: include any *wildcards* in string
## arguement $2: file/path/to/start/search/

# if no arguements provided, use defaults
# defaults:  SEARCH_STRING = "*.blend"; SEARCH_PATH = current dir ".";
SEARCH_STRING="${1:-*.blend}"
SEARCH_PATH="${2:-.}"  # If arguement $2 not provided, set it to the current dir "."
###############################################################################################
###############################################################################################


####################
#### Early Dev Test
####echo 'in the current directory "." find and print all filepaths that are of type f (file) and have a filename that ends with ".blend"' && sleep 1
####find . -name "*.blend" -type f  -print

########################
##### Test Results Only
#####
#####echo 'in the directory '$SEARCH_PATH' find and print all filepaths that are of type f (file) and have a filename with the pattern "'$SEARCH_STRING'"' && sleep 1 && echo '' && echo 'in progress...'
#####find "$SEARCH_PATH" -name "$SEARCH_STRING" -type f  -print
#####echo '' && echo '' && sleep 1
########################


################
##################
###################

#############################
## Make arraignments for disk usage (temporary)
## create a temp dir on the Desktop, using today's date
date_temp_dir=$home_path'/Desktop/TEMPYMCTEMPSTERFACE/temp'$(date +"%m%d%y")
mkdir -p $date_temp_dir

## Save the current hour hh and minutes mm and ss
date_temp_time=$(date +"%H%M%S")

## Make dir for cp'd files
date_temp_destination_dir=$date_temp_dir'/cp_'$date_temp_time'/'
mkdir $date_temp_destination_dir

## Create a string variable with the filepath for writing list of files to copy
date_temp_file=$date_temp_dir'/cp_'$date_temp_time'/copy_op_files_'$date_temp_time'.txt'

## Using date_temp_file, make list file
touch $date_temp_file

## Inform User of state of script
echo "#################################################################################"
echo "Building list of files to copy and storing in file @"$date_temp_file

## Save each matching file path to list file:
find "$SEARCH_PATH" -name "$SEARCH_STRING" -type f  -print >> $date_temp_file

##############################
### Using file of filepaths (one per line)
### Conduct file reading operation, line by line, counting lines in var i
i=0
while read -r eachline; do
###### Inform User of state of script (inside while loop)
  echo "###############################################################################"
  echo "Copying["$i"] "$eachline" --> to --> "$date_temp_destination_dir
  #### Copy filepath file to current temp dir
  cp -a "$eachline" "$date_temp_destination_dir"
  #### Increment i = i + 1
  i=$(( i + 1 ))
######
done < $date_temp_file
### End while;do loop

## Inform User of state of script
echo "#################################################################################"
echo "find files, copy them- now complete, sir"
#Sir, it overwrites duplicates, sir!
#keep count of its to prevent overwriting duplicate file names?
#i=0
