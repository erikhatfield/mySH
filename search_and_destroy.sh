#!/bin/sh

###################
## Work in progress
##
## bite size chunks
##

###################
## find and print the md5 sum of all files in the current directory tree. print out the checksum first, then the file path (as designated by the -r option)
#find . -type f -exec md5 -r {} +

###################
## find and print md5 checksums and filepaths of files with matching md5 checksum only (using grep)
#find . -type f -exec md5 -r {} + | grep "eg1anmd5h4sh5tr5amp13101lolw00t" 


###################
## Work in progress
## 
## w00ttles here works with a pre-compiled list of file hashes of known deleteable files in my vast digital archivials. 
## for every line in blash-list txt, treat as string and search the dir tree of parametered dir path for files with md5 hash string that matches

while read -r line; do

      #printf %s "$line" | find . -type f -exec md5 -r {} + | grep "$line" | cut -d ' ' -f2- ;
      filepath4operation=$(printf "%s" "$line" | find . -type f -exec md5 -r {} + | grep "$line" | cut -d ' ' -f2- )

      echo "removing file at path: "$filepath4operation
#DRY
#      ls -l "$filepath4operation"
#WET
     rm -rf "$filepath4operation"

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
