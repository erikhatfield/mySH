#!/usr/bin/env bash

###############################################################################
# Recovery Mode reboot option                                                 #
###############################################################################
# (1) prompt user, and read command line argument
read -p "Reboot in recovery? (y or n) " answer

# (2) handle the command line argument we were given
while true
do
  case $answer in
   [yY]* )          echo "yY entered. rebooting in recovery mode."

      sudo nvram "recovery-boot-mode=unused"
      sudo reboot recovery

      break;;

#   [nN]* ) echo "no selected" #exit;;
#      break;;

   * )              echo "ok, exiting"; break ;;
  esac
done

exit