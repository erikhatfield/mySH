#!/bin/sh
# add alias for log defaults... l00g sounds g00d

echo 'alias l00g="sh ~/Dots/defaults_log/log_defaults.sh"' >> ~/.bash_profile
echo 'alias l00g="sh ~/Dots/defaults_log/log_defaults.sh"' >> ~/.zshrc

# and then source both of them cuz sweet yay a mess (CONSIDER: checking to see if exists already.. ideal)

source ~/.bash_profile
source ~/.zshrc

# well thats all for now folks
exit
