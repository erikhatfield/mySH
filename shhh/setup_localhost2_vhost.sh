#!/bin/bash

# Close any open System Preferences panes, to prevent them from overwriting our changes
osascript -e 'tell application "System Preferences" to quit'

# Ask for the admin password upfront
sudo -v

# Keep-alive: update existing 'sudo' time stamp until finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# SETUP username and paths and check                                          #
###############################################################################

#who am i | awk '{print $1}' #works with sudo
who_i_is=$(who am i | awk '{print $1}')
home_path="$HOME"

# (1) prompt user, and read command line argument
  read -p "Setting up localhost (phase 2: adding or removing virtualhost/vhost- please have vhosts setup- run phase1 setup) with who='$who_i_is', and home_path='$home_path', is this correct sir? " answer

  # (2) handle the command line argument we were given
  while true
  do
    case $answer in
     [yY]* ) #very well, carry on
        break;;

     [nN]* ) exit;;

     * )     echo "Y or N input required, good sir."; break ;;
    esac
  done

  ###############################################################################
  # SETUP LOCALHOST PHASE 2                                                     #
  ###############################################################################
  # (1) prompt user, and read command line argument
  read -p "Add or Remove a vhost? (aA or rR) " answer

  # (2) handle the command line argument we were given
  while true
  do
    case $answer in
     ###############################################################################
     # ADD VHOST                                                                   #
     ###############################################################################
      [aA]* ) echo "aA entered. Adding Vhost"

        # Ask the user for vhost string
        echo Please type in a simple string without spaces to be your vhost name
        read USER_INPUT_VHOST_NAME_TO_ADD
        echo Your vhost will use the name $USER_INPUT_VHOST_NAME_TO_ADD

        # Make directories for backups
        mkdir -pv "$home_path/Dev/baks/"

        # backup everything (with timestamps)
        sudo cp -RPpv "/etc/apache2" "$home_path/Dev/baks/etc-apache2_"$(date +'%m%d%y')"-"$(date +'%H%M')

        # Make directories for new vhosts
        mkdir -p "$home_path/Sites/$USER_INPUT_VHOST_NAME_TO_ADD/"
        mkdir -p "$home_path/Sites/$USER_INPUT_VHOST_NAME_TO_ADD/www"
        mkdir -p "$home_path/Sites/$USER_INPUT_VHOST_NAME_TO_ADD/logs"
        sudo chmod 755 "$home_path/Sites/$USER_INPUT_VHOST_NAME_TO_ADD/"
        sudo chmod 755 "$home_path/Sites/$USER_INPUT_VHOST_NAME_TO_ADD/www"

        if ! cat $home_path/Sites/$USER_INPUT_VHOST_NAME_TO_ADD/www/index.html 2>/dev/null
            then
                touch $home_path/Sites/$USER_INPUT_VHOST_NAME_TO_ADD/www/index.html
                echo "<h1>hello~ $USER_INPUT_VHOST_NAME_TO_ADD.local</h1><hr><h2>Setup@: "$(date +'%m%d%y')"-"$(date +'%H%M')"</h2>" >> $home_path/Sites/$USER_INPUT_VHOST_NAME_TO_ADD/www/index.html
                sudo chmod 755 $home_path/Sites/$USER_INPUT_VHOST_NAME_TO_ADD/www/index.html
            else
                echo "$home_path/Sites/$USER_INPUT_VHOST_NAME_TO_ADD/www/index.html already exists."
        fi

        # New vhost conf
        sudo echo '<VirtualHost *:80>' >> /etc/apache2/vhosts/$USER_INPUT_VHOST_NAME_TO_ADD.conf
        sudo echo '        DocumentRoot "'$home_path'/Sites/'$USER_INPUT_VHOST_NAME_TO_ADD'/www"' >> /etc/apache2/vhosts/$USER_INPUT_VHOST_NAME_TO_ADD.conf
        sudo echo '        ServerName '$USER_INPUT_VHOST_NAME_TO_ADD'.local' >> /etc/apache2/vhosts/$USER_INPUT_VHOST_NAME_TO_ADD.conf
        sudo echo '        ErrorLog "'$home_path'/Sites/'$USER_INPUT_VHOST_NAME_TO_ADD'/logs/error_log"' >> /etc/apache2/vhosts/$USER_INPUT_VHOST_NAME_TO_ADD.conf
        sudo echo '        CustomLog "'$home_path'/Sites/'$USER_INPUT_VHOST_NAME_TO_ADD'/logs/access_log" common' >> /etc/apache2/vhosts/$USER_INPUT_VHOST_NAME_TO_ADD.conf
        sudo echo '' >> /etc/apache2/vhosts/$USER_INPUT_VHOST_NAME_TO_ADD.conf
        sudo echo '        <Directory "'$home_path'/Sites/'$USER_INPUT_VHOST_NAME_TO_ADD'/www">' >> /etc/apache2/vhosts/$USER_INPUT_VHOST_NAME_TO_ADD.conf
        sudo echo '            AllowOverride All' >> /etc/apache2/vhosts/$USER_INPUT_VHOST_NAME_TO_ADD.conf
        sudo echo '            Require all granted' >> /etc/apache2/vhosts/$USER_INPUT_VHOST_NAME_TO_ADD.conf
        sudo echo '        </Directory>' >> /etc/apache2/vhosts/$USER_INPUT_VHOST_NAME_TO_ADD.conf
        sudo echo '</VirtualHost>' >> /etc/apache2/vhosts/$USER_INPUT_VHOST_NAME_TO_ADD.conf

        #set permissions
        sudo chmod 644 /etc/apache2/vhosts/$USER_INPUT_VHOST_NAME_TO_ADD.conf



        # check syntax of configs
        sudo apachectl -t
        sleep 2

        # add to hosts file and restart apache/flush dns
        sudo echo "127.0.0.1       $USER_INPUT_VHOST_NAME_TO_ADD.local" >> /etc/hosts

        # flush host file
        dscacheutil -flushcache
        sudo dscacheutil -flushcache
        sleep 5

        # Restart apache
        sudo apachectl restart
        sleep 5

        # And open a test window
        open 'http://'$USER_INPUT_VHOST_NAME_TO_ADD'.local/'
        echo "Done setting up new vhost."
        sleep 1

        break;;

     ###############################################################################
     # END == ADD VHOST                                                            #
     ###############################################################################


     ###############################################################################
     # REMOVE VHOST                                                                #
     ###############################################################################
      [rR]* ) echo "rR entered. Removing Vhost"

        # Ask the user for vhost string
        echo Please type in a string of an existing vhost name
        read USER_INPUT_VHOST_NAME_TO_REMOVE
        echo Will remove vhost with name $USER_INPUT_VHOST_NAME_TO_REMOVE

        # Make directories for backups
        mkdir -p "$home_path/Dev/baks/"

        # backup everything (with timestamps)
        sudo cp -RPp "/etc/apache2" "$home_path/Dev/baks/etc-apache2_"$(date +'%m%d%y')"-"$(date +'%H%M')

        # remove files
        sudo rm -rf "$home_path/Sites/$USER_INPUT_VHOST_NAME_TO_REMOVE/"

        # apache vhost string to REMOVE
        # remove vhost conf file
        sudo rm -rf /private/etc/apache2/vhosts/$USER_INPUT_VHOST_NAME_TO_REMOVE.conf

        # remove it from hosts file and restart apache/flush dns
        search_str="127.0.0.1       $USER_INPUT_VHOST_NAME_TO_REMOVE.local"
        replace_str=""
        sudo sed -i -- 's|'"$search_str"'|'"$replace_str"'|g' "/etc/hosts"

        # flush host file
        dscacheutil -flushcache
        sudo dscacheutil -flushcache
        sleep 5

        # Restart apache
        sudo apachectl restart
        sleep 5

        # And open a test window
        open 'http://'$USER_INPUT_VHOST_NAME_TO_REMOVE'.local/'
        echo "Done Removing vhost."
        sleep 1

        break;;

     ###############################################################################
     # END == REMOVE VHOST                                                         #
     ###############################################################################

     * )     echo "Exiting without action."; exit;;

    esac
  done

###############################################################################
###############################################################################
###############################################################################




exit
