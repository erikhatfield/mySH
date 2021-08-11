#!/bin/bash

###################
## Find all files in /the/path/provided/ that contain the 'somestring' in their filenames.
## Copy them to the /second/path/temp4now
## If they have duplicate file names, do not overwrite (default unix behaviour?)
## 
## Run Instructions: 2 arguements passed in to script as such:
## arguement $1: file/path/to/start/search/
## arguement $2: "*search.string" with any *wildcards* included

###################
echo 'in the current directory "." find and print all filepaths that are of type f (file) and have a filename that ends with ".blend"' && sleep 1
find . -name "*.blend" -type f  -print

## create a temp dir on the Desktop, using today's date
date_temp_dir=$(date +"%m%d%y")
mkdir "~/Desktop/temp"$date_temp_dir

## save output to file named with the current hour hh and minutes mm
date_temp_file=$(date +"%H%M")
find . -name "*.blend" -type f  -print >> "~/Desktop/temp"$date_temp_dir"cpthese_"$date_temp_file".txt"

###################
############################################################################
###################
############################################################################
###################
############################################################################
###################
############################################################################
###################
############################################################################
###################
############################################################################
## code dumped from l box needs work

while read -r eachline; do

      #printf %s "$blashline" | find . -type f -exec md5 -r {} + | grep "$blashline" | cut -d ' ' -f2- ;
      #filepath4operation=$(printf "%s" "$eachline" | find . -type f -exec md5 -r {} + | grep "$eachline" | cut -d ' ' -f2- )

      filepath4operation = $eachline
      echo $filepath4operation
      
      if [ -z "$filepath4operation" ]
      then
          echo "\$filepath4operation is empty"
      else
            

      fi

done < ~/Desktop/tempfilelawlz.txt


