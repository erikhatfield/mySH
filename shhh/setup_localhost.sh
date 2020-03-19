#!/usr/bin/env bash

# Close any open System Preferences panes, to prevent them from overwriting our changes
osascript -e 'tell application "System Preferences" to quit'

# Ask for the admin password upfront
sudo -v

# Keep-alive: update existing 'sudo' time stamp until finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

#store username in variable for dynamicness. $id -un <=> $whoami
#whoamilol="$(id -un)"
#Use run_setup_localhost 

###############################################################################
# SETUP USER'S LOCALHOST                                                      #
###############################################################################


  # (1) prompt user, and read command line argument
  read -p "Would you like to setup localhost, good sir? " answer

  # (2) handle the command line argument we were given
  while true
  do
    case $answer in
     [yY]* ) #echo "Please choose a virtual host name"

        # Ask the user for their name
        echo "Please choose a virtual host name (without the .local)"
        read varname
        echo Your localhost will be $varname.local

        # backup everything (with timestamps)
        sudo cp -R "/etc/apache2" "$HOME/Desktop/bak-etc_apache2_"$(date +'%m%d%y')"-"$(date +'%H%M')

        #switch to the root user to avoid permission issues:

        # Stop/unload apache if it's running
        sudo apachectl stop
        sudo launchctl unload -w /System/Library/LaunchDaemons/org.apache.httpd.plist 2>/dev/null

        # Start up apache
        sudo apachectl start

        #create phpinfo.php with <?php phpinfo(); ?>
        echo '<?php phpinfo();' > /Library/WebServer/Documents/phpinfo.php

        sleep 1
        open http://localhost/
        sleep 2
        open http://localhost/phpinfo.php

        #create apache user for localhost
        touch $HOME/Desktop/$whoamilol.conf
        echo '<Directory "/Users/'$whoamilol'/Sites/www">' >> $HOME/Desktop/$whoamilol.conf
        echo 'AllowOverride All' >> $HOME/Desktop/$whoamilol.conf
        echo 'Options Indexes MultiViews FollowSymLinks' >> $HOME/Desktop/$whoamilol.conf
        echo 'Require host localhost' >> $HOME/Desktop/$whoamilol.conf
        echo '</Directory>' >> $HOME/Desktop/$whoamilol.conf

        #if this file already exists... warn?

        # Move the newly created file and set permissions
        sudo mv $HOME/Desktop/$whoamilol.conf /etc/apache2/users/$whoamilol.conf
        sudo chmod 644 /etc/apache2/users/$whoamilol.conf

        # View file permissions
        stat -f %A /etc/apache2/users/$whoamilol.conf

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

        # Create Default conf
        touch $HOME/Desktop/_default.conf
        echo '<VirtualHost *:80>' >> $HOME/Desktop/_default.conf
        echo '    DocumentRoot "/Library/WebServer/Documents"' >> $HOME/Desktop/_default.conf
        echo '</VirtualHost>' >> $HOME/Desktop/_default.conf

        #if this file already exists... warn?
        # Move the newly created file and set permissions
        sudo mv $HOME/Desktop/_default.conf /etc/apache2/vhosts/_default.conf
        sudo chmod 644 /etc/apache2/vhosts/_default.conf

        # Create user's vhost
        touch $HOME/Desktop/$varname.conf
        echo '<VirtualHost *:80>' >> $HOME/Desktop/$varname.conf
        echo '        DocumentRoot "'$HOME'/Sites/'$varname'/www"' >> $HOME/Desktop/$varname.conf
        echo '        ServerName '$varname'.local' >> $HOME/Desktop/$varname.conf
        echo '        ErrorLog "'$HOME'/Sites/'$varname'/logs/error_log"' >> $HOME/Desktop/$varname.conf
        echo '        CustomLog "'$HOME'/Sites/'$varname'/logs/access_log" common' >> $HOME/Desktop/$varname.conf
        echo '' >> $HOME/Desktop/$varname.conf
        echo '        <Directory "'$HOME'/Sites/'$varname'/www">' >> $HOME/Desktop/$varname.conf
        echo '            AllowOverride All' >> $HOME/Desktop/$varname.conf
        echo '            Require all granted' >> $HOME/Desktop/$varname.conf
        echo '        </Directory>' >> $HOME/Desktop/$varname.conf
        echo '</VirtualHost>' >> $HOME/Desktop/$varname.conf

        sudo mv $HOME/Desktop/$varname.conf /etc/apache2/vhosts/$varname.conf
        sudo chmod 644 /etc/apache2/vhosts/$varname.conf

        ##check for both $HOME/Sites and it's index file? good practice
        #make dir @ $HOME/Sites
        mkdir -vp $HOME/Sites/$varname/www
        mkdir -vp $HOME/Sites/$varname/logs

        sudo chmod 755 $HOME/Sites
        sudo chmod 755 $HOME/Sites/$varname
        sudo chmod 755 $HOME/Sites/$varname/www

        touch $HOME/Desktop/index.html
        echo 'hello~' >> $HOME/Desktop/index.html
        sudo mv $HOME/Desktop/index.html $HOME/Sites/$varname/www/index.html
        sudo chmod 755 $HOME/Sites/$varname/www/index.html

        #setup vhost in hosts file
        sudo echo '127.0.0.1       '$varname'.local' >> /etc/hosts

        # flush host file
        dscacheutil -flushcache
        sudo dscacheutil -flushcache

        # Restart apache
        sudo apachectl restart
        # And open a test window
        sleep 1
        open http://$varname.local\#$HOME

        echo "Done Setting up localhost."




        break;;

     [nN]* ) exit;;

     * )     echo "Y or N input required, good sir."; break ;;
    esac
  done



exit
