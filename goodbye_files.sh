#!/bin/bash
is_wet=true
echo "in wet mode, is_wet="$is_wet

# Ask for the admin password upfront
sudo -v

# Keep-alive: update existing 'sudo' time stamp until finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

#####################
##example %sh /path-to-the-shell/goodbye_files.sh "/path-to/traverse-and/delete/files"
## takes a long time, because for each hash in the file it traverses the entire tree... EACH TIME/EACH HASH!
## 
###################
##
realpath() {
    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}
relative_path=$(realpath "$0")
relative_dir=$(dirname $relative_path)
echo $relative_dir

###################################
echo "To generate a blash-list.txt"
echo "Use:"
echo 'filepathskis="/the/file/to/delete.ext"'
echo "% md5 -q \"\$filepathskis\" >> $relative_dir/blash-list.txt"
echo
echo 

search_and_delete_file_path="$1"
cd $search_and_delete_file_path
echo "working in dir: "
pwd

while read -r blashline; do

      echo "while loop in prog: "$blashline
      #printf %s "$blashline" | find . -type f -exec md5 -r {} + | grep "$blashline" | cut -d ' ' -f2- ;
    filepath4operation=$(printf "%s" "$blashline" | find "$search_and_delete_file_path" -type f -exec md5 -r {} + | grep "$blashline" | cut -d ' ' -f2- )
	#find "$search_and_delete_file_path" -type f -exec md5 -r '{}' \;
	#find "$search_and_delete_file_path" -type f -exec md5 -r {} + | grep "$blashline" | cut -d ' ' -f2- ;
    echo $filepath4operation

    if [ -z "$filepath4operation" ]
      then
	  echo "nothing to do... next"
          #echo "\$filepath4operation is empty"
          #echo "No files with matching checksum were found. ((MD5=""$blashline""))"
      else
	if [ "$is_wet" = true ] ; then
              echo "WET"
              echo ""
              echo "################################################################################################"
              echo "# Removing file at path: ""$multiline""  ((MD5=""$blashline"")) "
              echo "################################################################################################"
              echo ""
              sudo rm -rf "$filepath4operation"
            else
              echo "DRY"
              ls -ale "$filepath4operation"
            fi
      fi
done < $relative_dir/blash-list.txt

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
