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
echo $relative_dir
echo

###################
###################
for filepath in "$@" 
##for filepath in $@
do
	echo
	filepathMD5HASH=$(md5 -q "$filepath")
	echo "adding $filepath md5 hash ($filepathMD5HASH) to $relative_dir/blash-list.txt"
	echo $filepathMD5HASH >> "$relative_dir/blash-list.txt"
	#
	if [ "$is_wet" = true ] ; then
		echo '$is_wet = '"$is_wet"
		echo "removing file @"
		sudo rm -rfv "$filepath"
	else
		echo "DRY RUN ENABLED: moving on"
	fi
	#
	echo
done
###################
###################
echo

exit
