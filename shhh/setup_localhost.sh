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
  read -p "Setting up localhost with who='$who_i_is', and home_path='$home_path', is this correct sir? " answer

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
# SETUP LOCALHOST PHASE 1                                                     #
###############################################################################

  # Make directories for backups
  mkdir -p "$home_path/Dev/baks/"

  # backup everything (with timestamps)
  sudo cp -RPp "/etc/apache2" "$home_path/Dev/baks/etc-apache2_"$(date +'%m%d%y')"-"$(date +'%H%M')

        ###switch to the root user to avoid permission issues:??

        # Stop/unload apache if it's running
        ###sudo apachectl stop
        ###sudo launchctl unload -w /System/Library/LaunchDaemons/org.apache.httpd.plist 2>/dev/null

  # Start up apache
  ##sudo apachectl start
  apachectl start

  #create phpinfo.php with <?php phpinfo(); ?>
  sudo echo '<?php phpinfo();' > /Library/WebServer/Documents/phpinfo.php

  sleep 1
  open http://localhost/
  sleep 2
  open http://localhost/phpinfo.php
  sleep 3

  #create apache user for localhost
  #### WHY WHAT
  ##touch $home_path/$who_i_is.conf
  ##echo '<Directory "/Users/'$who_i_is'/Sites/www/'$who_i_is'">' >> $home_path/$who_i_is.conf
  ##echo 'AllowOverride All' >> $home_path/$who_i_is.conf
  ##echo 'Options Indexes MultiViews FollowSymLinks' >> $home_path/$who_i_is.conf
  ##echo 'Require host localhost' >> $home_path/$who_i_is.conf
  ##echo '</Directory>' >> $home_path/$who_i_is.conf

  ##if ! cat /etc/apache2/users/$who_i_is.conf 2>/dev/null
  ##    then
  ##        # If this file doesnt exist, make it exist
  ##        # Move the newly created file and set permissions
  ##        sudo mv $home_path/$who_i_is.conf /etc/apache2/users/$who_i_is.conf
  ##        sudo chmod 644 /etc/apache2/users/$who_i_is.conf
  ##    else
  ##        echo "The file @ /etc/apache2/users/$who_i_is.conf exists already"
  ##        #View it's contents
  ##        cat /etc/apache2/users/$who_i_is.conf
  ##
  ##        #View file permissions
  ##        stat -f %A /etc/apache2/users/$who_i_is.conf
  ##        sleep 1
  ##fi

        # Search and replace string 'foo' with 'bar' in file/at/path
        #sed -i -- 's/foo/bar/g' /file/path/of.file

  # Enable PHP in /etc/apache2/httpd.conf
  search_str="#LoadModule php7_module"
  replace_str="LoadModule php7_module"
  sudo sed -i -- 's|'"$search_str"'|'"$replace_str"'|g' "/etc/apache2/httpd.conf"

  search_str="#LoadModule authz_core_module libexec/apache2/mod_authz_core.so"
  replace_str="LoadModule authz_core_module libexec/apache2/mod_authz_core.so"
  sudo sed -i -- 's|'"$search_str"'|'"$replace_str"'|g' "/etc/apache2/httpd.conf"

  search_str="#LoadModule authz_host_module libexec/apache2/mod_authz_host.so"
  replace_str="LoadModule authz_host_module libexec/apache2/mod_authz_host.so"
  sudo sed -i -- 's|'"$search_str"'|'"$replace_str"'|g' "/etc/apache2/httpd.conf"

  search_str="#LoadModule userdir_module libexec/apache2/mod_userdir.so"
  replace_str="LoadModule userdir_module libexec/apache2/mod_userdir.so"
  sudo sed -i -- 's|'"$search_str"'|'"$replace_str"'|g' "/etc/apache2/httpd.conf"

  search_str="#LoadModule include_module libexec/apache2/mod_include.so"
  replace_str="LoadModule include_module libexec/apache2/mod_include.so"
  sudo sed -i -- 's|'"$search_str"'|'"$replace_str"'|g' "/etc/apache2/httpd.conf"

  search_str="#LoadModule rewrite_module libexec/apache2/mod_rewrite.so"
  replace_str="LoadModule rewrite_module libexec/apache2/mod_rewrite.so"
  sudo sed -i -- 's|'"$search_str"'|'"$replace_str"'|g' "/etc/apache2/httpd.conf"

  search_str="#Include /private/etc/apache2/extra/httpd-userdir.conf"
  replace_str="Include /private/etc/apache2/extra/httpd-userdir.conf"
  sudo sed -i -- 's|'"$search_str"'|'"$replace_str"'|g' "/etc/apache2/httpd.conf"

  # Enable in /etc/apache2/extra/httpd-userdir.conf
  search_str="#Include /private/etc/apache2/users/*.conf"
  replace_str="Include /private/etc/apache2/users/*.conf"
  sudo sed -i -- 's|'"$search_str"'|'"$replace_str"'|g' "/etc/apache2/extra/httpd-userdir.conf"

  # Enable Virtual Hosts
  search_str="#Include /private/etc/apache2/extra/httpd-vhosts.conf"
  replace_str="Include /private/etc/apache2/vhosts/*.conf"
  sudo sed -i -- 's|'"$search_str"'|'"$replace_str"'|g' "/etc/apache2/httpd.conf"

  # Create V Host directory
  sudo mkdir /etc/apache2/vhosts

  # Create Default conf to keep http://localhost working
  touch $home_path/default.conf
  echo '<VirtualHost *:80>' >> $home_path/default.conf
  echo '    ServerName localhost' >> $home_path/default.conf
  echo '    DocumentRoot "/Library/WebServer/Documents"' >> $home_path/default.conf
  echo '</VirtualHost>' >> $home_path/default.conf

  if ! cat /etc/apache2/vhosts/default.conf 2>/dev/null
      then
        # If this file doesnt exist, make it exist
        # Move the newly created file and set permissions
        sudo mv $home_path/default.conf /etc/apache2/vhosts/default.conf
        sudo chmod 644 /etc/apache2/vhosts/default.conf
      else
        echo "The file @ /etc/apache2/vhosts/default.conf exists already"
        #remove stray
        #sudo rm -rf $home_path/default.conf
        #View file permissions
        stat -f %A /etc/apache2/vhosts/default.conf
        sleep 1
  fi

  if ! cat /etc/apache2/vhosts/$who_i_is.conf 2>/dev/null
      then
        # If this file doesnt exist, make it exist
        # Create user's vhost
        touch $home_path/$who_i_is.conf
        echo '<VirtualHost *:80>' >> $home_path/$who_i_is.conf
        echo '        DocumentRoot "'$home_path'/Sites/'$who_i_is'/www"' >> $home_path/$who_i_is.conf
        echo '        ServerName '$who_i_is'.local' >> $home_path/$who_i_is.conf
        echo '        ErrorLog "'$home_path'/Sites/'$who_i_is'/logs/error_log"' >> $home_path/$who_i_is.conf
        echo '        CustomLog "'$home_path'/Sites/'$who_i_is'/logs/access_log" common' >> $home_path/$who_i_is.conf
        echo '' >> $home_path/$who_i_is.conf
        echo '        <Directory "'$home_path'/Sites/'$who_i_is'/www">' >> $home_path/$who_i_is.conf
        echo '            AllowOverride All' >> $home_path/$who_i_is.conf
        echo '            Require all granted' >> $home_path/$who_i_is.conf
        echo '        </Directory>' >> $home_path/$who_i_is.conf
        echo '</VirtualHost>' >> $home_path/$who_i_is.conf

        sudo mv $home_path/$who_i_is.conf /etc/apache2/vhosts/$who_i_is.conf
        sudo chmod 644 /etc/apache2/vhosts/$who_i_is.conf

      else
        echo "The file @ /etc/apache2/vhosts/$who_i_is.conf exists already"
        cat /etc/apache2/vhosts/$who_i_is.conf
        sleep 1
        #remove stray
        #sudo rm -rf $home_path/$who_i_is.conf
        #View file permissions
        stat -f %A /etc/apache2/vhosts/$who_i_is.conf
        sleep 1

  fi


  #make dir @ $home_path/Sites
  mkdir -p $home_path/Sites/$who_i_is/www
  mkdir -p $home_path/Sites/$who_i_is/logs

  sudo chmod 755 $home_path/Sites
  sudo chmod 755 $home_path/Sites/$who_i_is
  sudo chmod 755 $home_path/Sites/$who_i_is/www

  if ! cat $home_path/Sites/$who_i_is/www/index.html 2>/dev/null
      then
          touch $home_path/Sites/$who_i_is/www/index.html
          echo "<h1>hello~ $who_i_is.local</h1><hr><h3>Setup@: "$(date +'%m%d%y')"-"$(date +'%H%M')"</h3>" >> $home_path/Sites/$who_i_is/www/index.html
          sudo chmod 755 $home_path/Sites/$who_i_is/www/index.html
      else
          echo "$home_path/Sites/$who_i_is/www/index.html already exists."
  fi

  #perform cleanup on hosts file (in case script has been run multiple times)
  search_str="127.0.0.1       $who_i_is.local"
  replace_str=""
  sudo sed -i -- 's|'"$search_str"'|'"$replace_str"'|g' "/etc/hosts"

  #setup vhost in hosts file
  sudo echo "127.0.0.1       $who_i_is.local" >> /etc/hosts

  # flush host file
  dscacheutil -flushcache
  sudo dscacheutil -flushcache
  sleep 7

  # Restart apache
  sudo apachectl restart
  sleep 6

  # And open test windows
  open 'http://localhost/'
  sleep 5
  open 'http://'$who_i_is'.local/'
  sleep 4
  sudo echo '<?php phpinfo();' > $home_path/Sites/$who_i_is/www/phpinfo.php
  sleep 3
  open 'http://'$who_i_is'.local/phpinfo.php'
  sleep 2
  echo "Done setting up localhost."
  sleep 1

exit
