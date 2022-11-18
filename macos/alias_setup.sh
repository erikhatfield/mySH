#!/bin/sh

###################################################
# Recovery boot sh
mkdir -p ~/Dev/shhh_local
cp -a /Volumes/D0TS/latest/osx/rebootinR.sh ~/Dev/shhh_local/rebootinR.sh
echo 'alias recovery="sh ~/Dev/shhh_local/rebootinR.sh"' >> ~/.bash_profile
echo 'alias recovery="sh ~/Dev/shhh_local/rebootinR.sh"' >> ~/.zshrc


##########################################################################
##########################################################################
# and then source both of them cuz sweet yay a mess (CONSIDER: checking to see if exists already.. ideal)

source ~/.bash_profile
source ~/.zshrc

# well thats all for now folks
exit

