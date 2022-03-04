#!/usr/bin/env bash

###############################################################################
# Recovery Mode reboot option                                                 #
###############################################################################
# (1) prompt user, and read command line argument
read -p "Reboot in recovery (to use csutil) ? (y or n) " answer

# (2) handle the command line argument we were given
while true
do
  case $answer in
   [yY]* ) echo "yY entered."

      sudo nvram "recovery-boot-mode=unused"
      sudo reboot recovery

      break;;

   [nN]* ) echo "no name being set then... " #exit;;
      break;;

   * )     echo "Y or N input required, good sir."; break ;;
  esac
done
