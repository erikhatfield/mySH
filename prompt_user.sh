#!/bin/sh

###############################################################################
# PROMPT USER 1                                                               #
###############################################################################

#prompt user, and read command line argument
read -p "Would you like to say hello to the World? (Yy/Nn)" answer

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

###############################################################################
# PROMPT USER 2                                                               #
###############################################################################

# Ask the user for their name
echo Please type in a string
read userinputed
echo you typed in $userinputed


#exit
