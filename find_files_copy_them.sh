#!/bin/bash

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
SEARCH_STRING="${1:=*.blend}"
SEARCH_FILEPATH="${2:=.}"  # If arguement $1 not provided, set it to the current dir "."

###################
#### Early Dev Test
##echo 'in the current directory "." find and print all filepaths that are of type f (file) and have a filename that ends with ".blend"' && sleep 1
##find . -name "*.blend" -type f  -print

###################
echo 'in the directory '$SEARCH_FILEPATH' find and print all filepaths that are of type f (file) and have a filename with the pattern "'$SEARCH_STRING'"' && sleep 1
find $SEARCH_FILEPATH -name "$SEARCH_STRING" -type f  -print
echo '' && echo '' && sleep 1
###################

###################
## create a temp dir on the Desktop, using today's date
date_temp_dir=$(date +"%m%d%y")
mkdir "~/Desktop/temp"$date_temp_dir

## save output to file named with the current hour hh and minutes mm
date_temp_file=$(date +"%H%M")
find $SEARCH_FILEPATH -name "$SEARCH_STRING" -type f  -print >> "~/Desktop/temp"$date_temp_dir"/cpthese_"$date_temp_file".txt"

###################
############################################################################
###################
############################################################################
###################
############################################################################
###################
############################################################################
###################

while read -r eachline; do

      #printf %s "$blashline" | find . -type f -exec md5 -r {} + | grep "$blashline" | cut -d ' ' -f2- ;
      #filepath4operation=$(printf "%s" "$eachline" | find . -type f -exec md5 -r {} + | grep "$eachline" | cut -d ' ' -f2- )

      filepath4operation = $eachline
      
      if [ -z "$filepath4operation" ]
      then
          echo "\$filepath4operation is empty"
      else
          
            echo $filepath4operation

      fi

done < "~/Desktop/temp"$date_temp_dir"/cpthese_"$date_temp_file".txt"


