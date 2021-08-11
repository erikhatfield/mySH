#!/bin/bash

###################
## Find all files in /the/path/provided/ that contain the 'somestring' in their filenames.
## Copy them to the /second/path/provided/
## If they have duplicate file names, do not overwrite (default unix behaviour?)
##

###################
echo 'in the current directory "." find and print all filepaths that are of type f (file) and have a filename that ends with ".blend"' && sleep 1
find . -name "*.blend" -type f  -print


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


