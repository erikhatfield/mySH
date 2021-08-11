#!/bin/bash

# Ask for the admin password upfront
sudo -v
# Keep-alive: update existing 'sudo' time stamp until finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

#who am i | awk '{print $1}' #works with sudo
who_i_is=$(who am i | awk '{print $1}')
home_path="$HOME"
echo "who='$who_i_is', and home_path='$home_path'" && sleep 1

###################
## Find all files in /the/path/provided/ that contain the 'somestring' in their filenames.
## Copy them to the /second/path/temp4now
## If they have duplicate file names, do not overwrite (default unix behaviour?)
##
## Run Instructions: 2 arguements passed in to script as such:
## arguement $1: "*search.string"; note: include any *wildcards* in string
## arguement $2: file/path/to/start/search/

# if no arguements provided, use defaults
# defaults:  SEARCH_STRING = "*.blend"; SEARCH_FILEPATH = current dir ".";
SEARCH_STRING="${1:-*.blend}"
SEARCH_FILEPATH="${2:-.}"  # If arguement $2 not provided, set it to the current dir "."

###################
#### Early Dev Test
##echo 'in the current directory "." find and print all filepaths that are of type f (file) and have a filename that ends with ".blend"' && sleep 1
##find . -name "*.blend" -type f  -print

###################
echo 'in the directory '$SEARCH_FILEPATH' find and print all filepaths that are of type f (file) and have a filename with the pattern "'$SEARCH_STRING'"' && sleep 1 && echo '' && echo 'in progress...'
find "$SEARCH_FILEPATH" -name "$SEARCH_STRING" -type f  -print
echo '' && echo '' && sleep 1
###################

###################
## create a temp dir on the Desktop, using today's date
date_temp_dir=$home_path'/Desktop/temp'$(date +"%m%d%y")
mkdir $date_temp_dir

## save output to file named with the current hour hh and minutes mm
date_temp_time=$(date +"%H%M")
date_temp_file=$date_temp_dir'/cpthese_'$date_temp_time'.txt'

find "$SEARCH_FILEPATH" -name "$SEARCH_STRING" -type f  -print >> $date_temp_file
echo '' && echo '' && sleep 1
###################
############################################################################
###################
############################################################################
###################
############################################################################
###################
############################################################################
###################

#create dir for cp'd files
date_temp_destination_dir=$date_temp_dir'/cp_'$date_temp_time'/'
mkdir $date_temp_destination_dir

while read -r eachline; do

  cp -a "$eachline" "$date_temp_destination_dir"

done < $date_temp_file
