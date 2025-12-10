#!/bin/sh

realpath() {
    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}
relative_path=$(realpath "$0")
relative_dir=$(dirname $relative_path)
echo $relative_dir && ls -ale $relative_dir

###################################################
mkdir -p ~/Dev/shhh_local
chmod -R 770 ~/Dev/shhh_local

find ~/Dev/shhh_local -type f -iname "*.sh" -exec rm -rfv '{}' \;

###################################################
# Recovery boot sh
SH_FILE_NAME=rebootinR.sh
ALIAS_STR='recovery="sh'
sh $relative_dir/../../latest/osx/profile/update_an_alias.sh $SH_FILE_NAME $ALIAS_STR

###################################################
# add metadata sanitizer
SH_FILE_NAME=sanitize_multiple_files.sh
ALIAS_STR='sanitize="sh' 
sh $relative_dir/../../latest/osx/profile/update_an_alias.sh $SH_FILE_NAME $ALIAS_STR

##ALSO needs 2nd file:
sudo chmod 777 ~/Dev/shhh_local/downloaded_files.sh && rm -rfv ~/Dev/shhh_local/downloaded_files.sh
cp -a $relative_dir/../../latest/osx/profile/downloaded_files.sh ~/Dev/shhh_local/downloaded_files.sh
chmod 500 ~/Dev/shhh_local/downloaded_files.sh


###################################################
# add csr_override example
SH_FILE_NAME=csr_override.sh
ALIAS_STR='csroverride="sh'
sh $relative_dir/../../latest/osx/profile/update_an_alias.sh $SH_FILE_NAME $ALIAS_STR


#################################################
# add inspect
SH_FILE_NAME=inspecther.sh
ALIAS_STR='inspecther="sh'
sh $relative_dir/../../latest/osx/profile/update_an_alias.sh $SH_FILE_NAME $ALIAS_STR


#################################################
# add J0URNAL
sh $relative_dir/../../latest/SRS/delete_line_with_match.sh "J0URNAL" ~/.bash_profile
sh $relative_dir/../../latest/SRS/delete_line_with_match.sh "J0URNAL" ~/.zshrc
#removing from bash profiles will allow for updating script too
sh $relative_dir/../../latest/J0URNAL/journal_installer.sh
echo && echo
cat ~/Dots/J0URNAL/entries/.log
echo && sleep 1

##########################
# add others without aliases
find $relative_dir/../../latest/osx/profile/MOAR4DEV+shhh_local -type f -iname "*.sh" -exec cp -a
sudo cp -a $relative_dir/../../latest/osx/profile/MOAR4DEV+shhh_local/*.sh ~/Dev/shhh_local

sudo sh ~/Dev/shhh_local/permsperpath.sh ~/Dev/shhh_local

sleep 1 && echo
sudo chmod 0700 ~/Dev/shhh_local/
sudo chmod 0500 ~/Dev/shhh_local/*.sh

##########################################################################
##########################################################################
# and then source both of them cuz sweet yay a mess (CONSIDER: checking to see if exists already.. ideal)

source ~/.bash_profile
source ~/.zshrc

# well thats all for now folks
exit







exit;

###################################################
# Recovery boot sh
SH_FILE_NAME=rebootinR.sh
ALIAS_STR='recovery="sh'

sudo chmod 777 ~/Dev/shhh_local/$SH_FILE_NAME && rm -rfv ~/Dev/shhh_local/$SH_FILE_NAME

cp -a /Volumes/D0TS/latest/osx/$SH_FILE_NAME ~/Dev/shhh_local/$SH_FILE_NAME
chmod 500 ~/Dev/shhh_local/$SH_FILE_NAME

sh /Volumes/D0TS/latest/SRS/delete_line_with_match.sh $ALIAS_STR ~/.bash_profile
sh /Volumes/D0TS/latest/SRS/delete_line_with_match.sh $ALIAS_STR ~/.zshrc

echo 'alias recovery="sh ~/Dev/shhh_local/$SH_FILE_NAME"' >> ~/.bash_profile
echo 'alias recovery="sh ~/Dev/shhh_local/$SH_FILE_NAME"' >> ~/.zshrc
###################################################

###################################################
# add metadata sanitizer
cp /Volumes/D0TS/latest/osx/sanitize/downloaded_files.sh /Volumes/D0TS/latest/osx/sanitize/sanitize_multiple_files.sh ~/Dev/shhh_local/
chmod 500 ~/Dev/shhh_local/downloaded_files.sh ~/Dev/shhh_local/sanitize_multiple_files.sh
echo 'alias sanitize="sh ~/Dev/shhh_local/sanitize_multiple_files.sh"' >> ~/.bash_profile

###################################################
# add csr_override example
cp -a /Volumes/D0TS/45EC†/quarantineCSR_override/csr_override.txt ~/Dev/shhh_local/csr_override.txt
chmod 440 ~/Dev/shhh_local/csr_override.txt

##########################################################################
##########################################################################
# and then source both of them cuz sweet yay a mess (CONSIDER: checking to see if exists already.. ideal)

source ~/.bash_profile
source ~/.zshrc

# well thats all for now folks
exit


