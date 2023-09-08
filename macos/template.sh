#!/bin/sh

#################################################################################
#										#
#################################################################################

#store username in variable for dynamicness. $id -un <=> $whoami
whoamilol="$(id -un)"

#who am i | awk '{print $1}' #works with sudo
wh0is=$(who am i | awk '{print $1}')
home_path="$HOME"

# confirm correct
read -p "whoamilol= '$whoamilol' and who='$wh0is', and home_path='$home_path', enter to continue, ctrl-c to exit." wait4answer

#################################################################################
#                                                                               #
#################################################################################

echo "Finishing..."
exit
