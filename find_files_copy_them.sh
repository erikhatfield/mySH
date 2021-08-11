#!/bin/bash

###################
## Find all files in /the/path/provided/ that contain the 'somestring' in their filenames.
## Copy them to the /second/path/provided/
## If they have duplicate file names, do not overwrite (default unix behaviour?)
##

###################
## in the current directory "." find and print all filepaths that are of type f (file) and have a filename that ends with '.blend'
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

while read -r blashline; do

      #printf %s "$blashline" | find . -type f -exec md5 -r {} + | grep "$blashline" | cut -d ' ' -f2- ;
      filepath4operation=$(printf "%s" "$blashline" | find . -type f -exec md5 -r {} + | grep "$blashline" | cut -d ' ' -f2- )

      if [ -z "$filepath4operation" ]
      then
          #echo "\$filepath4operation is empty"
          echo "No files with matching checksum were found. ((MD5=""$blashline""))"
      else
          # Nested while loop handles multiple file paths
          #
          # Printf '%s\n' "$var" is necessary because printf '%s' "$var" on a
          # variable that doesn't end with a newline then the while loop will
          # completely miss the last line of the variable.
          while IFS= read -r multiline
          do

            if [ "$is_wet" = true ] ; then
              #WET
              echo ""
              echo "################################################################################################"
              echo "# Removing file at path: ""$multiline""  ((MD5=""$blashline"")) "
              echo "################################################################################################"
              echo ""
              rm -rf "$multiline"
            else
              #DRY
              ls -l "$multiline"
            fi

          done < <(printf '%s\n' "$filepath4operation")

      fi

done < ~/Desktop/blash-list.txt


## To generate a blash-list.txt
## Use:
#% md5 -q "/file/path/string.ok" >> ~/Desktop/blash-list.txt
## or:
#% ./for_each_arguement.sh "filepath1/here.ok" "filepath/2/with a space /lol.fine"
## or:
#% ./for_each_arguement.sh and drag and drop files onto terminal and run




#OTHER WAYS to understand... (linux)
#dry#find ./ -type f -exec md5 {} + | awk '$1 == "eg1anmd5h4sh5tr5amp13101lolw00t" {printf "%s\0", substr($0, 35)}' | xargs -0 -n1
#wet#find ./ -type f -exec md5 {} + | awk '$1 == "eg1anmd5h4sh5tr5amp13101lolw00t" {printf "%s\0", substr($0, 35)}' | xargs -r0 rm -rf
#awk '{printf "%s%s", NR-1 ? "|" : "", $1}' blash-list.txt will reformat this into a single line of pipe | separated hashes.
#Use this variant of the original command to match hashes using regex rather than an exact string match:
#find . -type f -exec md5 {} + | awk '$1 ~ "^('$(awk '{printf "%s%s", NR-1 ? "|" : "", $1}' hashes.txt)')$" {printf "%s\0", substr($0, 35)}' | xargs -r0 -n1
