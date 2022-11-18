#!/bin/sh

	#search_str="/Volumes/DOTS"
 	#replace_str="/Volumes/D0TS"
	#sudo sed -i -- 's|'"$search_str"'|'"$replace_str"'|g' "/Volumes/D0TS/latest/brews/icons.sh"

	search_str="$1"
        replace_str="$2"
        sudo sed -i -- 's|'"$search_str"'|'"$replace_str"'|g' "$3"
exit

#########################
# sh /Volumes/D0TS/mySH/find_and_replace_string_in_file.sh /Volumes/DOTS /Volumes/D0TS /Volumes/D0TS/latest/brews/firefox_prefs.sh 
