#!/bin/sh

###############################################################################
# PROMPT USER                                                                 #
###############################################################################

#prompt user, and read command line argument
read -p "Would you like to say hello to the World? (Y/N)" answer

while true
do
  case $answer in
   [yY]* ) echo "Yes!"

		if [ $answer == "Y" ]; then
			osascript -e 'display dialog "HELLO WORLD!" buttons {"Riveting."} default button 1'
		else
			osascript -e 'display dialog "hello world" buttons {"riveting"} default button 1'
		fi
		
      break;;

   [nN]* ) echo "hello world .. or - uh i mean woops?" #exit;;
      break;;

   * )     echo "Sir, that doesn't make sense, sir."; break ;;
  esac
done

#exit
