#!/bin/bash
is_wet=true
if [ "$is_wet" = true ] ; then
	echo "in wet mode, is_wet = $is_wet"
	echo && sleep 1 && echo && sleep 1
	echo "* * * ctrl - c to abort * * *"
	echo && sleep 1 && echo && sleep 1
else
	echo "DRY RUN ENABLED: is_wet = $is_wet"
fi

#####################
##example %sh /path-to-the-shell/goodbye_files.sh "/path-to/traverse-and/delete/files"
## 
###################

# Ask for the admin password upfront
sudo -v

# Keep-alive: update existing 'sudo' time stamp until finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

######
#######
realpath() {
    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}
relative_path=$(realpath "$0")
relative_dir=$(dirname $relative_path)
#echo $relative_dir
echo

###################################
echo "To generate a blash-list.txt"
echo "Use:"
echo 'filepathskis="/the/file/to/delete.ext"'
echo "% md5 -q \"\$filepathskis\" >> $relative_dir/blash-list.txt"
echo
###################
###prepend to blash
#printf '%s\n%s\n' "$(md5 -q $filepathskis)" "$(cat $relative_dir/blash-list.txt)" > $relative_dir/blash-list.txt
echo "OR to prepend to an existing blash-list.txt:"
echo '% printf '\''%s\\n%s\\n'\'' "$(md5 -q $filepathskis)" "$(cat '"$relative_dir"'/blash-list.txt)" > '"$relative_dir"'/blash-list.txt'
#actual line generated above (+ the relative dir part)
#% printf '%s\n%s\n' "$(md5 -q $filepathskis)" "$(cat $relative_dir/blash-list.txt)" > $relative_dir/blash-list.txt
##note: escaped single qoutes inside single qoutes => ' => '\''
##note: escaped backslash => \ => \\
echo
echo "OR use shell: goodbye_files+++generate_blashlist+from+multiple+files.sh"
echo
echo


#check for empty params
if [ -z "$1" ]
	then
		echo "* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *" && echo
		echo "Safety check: requires first parameter containing directory path to operate within."
		echo
		echo "* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *" && echo && echo
		exit
fi
search_and_delete_file_path="$1"
cd $search_and_delete_file_path
echo "working in dir: "
pwd && echo

#info about blash-list txt being used
ACTIVE_BLASH_LIST="$relative_dir/blash-list.txt"
echo
echo "Using blash-list txt ƒ @ $ACTIVE_BLASH_LIST"
echo "info:"
wc $ACTIVE_BLASH_LIST
echo && sleep 1 && echo && sleep 1

################################################################
###version 2
###for each file check against all hash values in blashlist.txt ##only traverses tree once

checkFileAgainstAllHash () {
	#echo "file: $1"'
	filepath2check="$1"
	hash4filepath2check=$(md5 -q "$filepath2check")
	#echo $hash4filepath2check
	filepath4blashtxt="$2"
	#echo $filepath4blashtxt
	###########################
	###for each md5 hash, check current file path
	#echo "checking file @ $filepath2check against each line in $filepath4blashtxt"
	while read -r blashline; do
		#printf "%s" "$blashline"
		#echo "while loop in prog: "$blashline
		if [ "$hash4filepath2check" = "$blashline" ] ;
			then
				echo
				echo "* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *" && echo
				echo "MATCH FOUND ƒ $filepath2check"
				echo "$hash4filepath2check == $blashline"
				#
				if [ "$3" = true ] ; then
					echo '$is_wet = '"$3"
					echo "removing file @"
					rm -rfv "$filepath2check"
				else
					echo "DRY RUN ENABLED: moving on"
				fi
				#
				echo
				echo "* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *" && echo
		fi
		##
	done < $filepath4blashtxt
}
###END checkFileAgainstAllHash

#export for use in find call
export -f checkFileAgainstAllHash
#
find $search_and_delete_file_path -type f -exec bash -c 'checkFileAgainstAllHash "$0" '"$relative_dir/blash-list.txt"' '"$is_wet" {} \;



exit




###for each md5 hash, travse and check each file in tree (version 1) ## too many traversals => slow
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
echo
exit
