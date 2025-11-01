#!/bin/bash

# Ask for the admin password upfront
sudo -v

# Keep-alive: update existing 'sudo' time stamp until finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Establish relative dir path
realpath() {
    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}
relative_path=$(realpath "$0")
relative_dir=$(dirname $relative_path)

###################
###################
for filepath in "$@"
do
	echo
	filepathMD5HASH=$(md5 -q "$filepath")
	echo "adding $filepath md5 hash ($filepathMD5HASH) to $relative_dir/blash-list.txt"
	echo $filepathMD5HASH >> "$relative_dir/blash-list.txt"
	echo
done
###################
###################

exit
