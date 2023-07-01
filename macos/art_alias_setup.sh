#!/bin/sh

###################
# add alias for art

# maybe later: check to see if it exists? that is, check to see if line u about to add exists already in:

echo 'alias art="~/Art/BL/art-from-code/SH/art-from-code.sh"' >> ~/.bash_profile
echo 'alias art="~/Art/BL/art-from-code/SH/art-from-code.sh"' >> ~/.zshrc

# and then source both of them (so that it may work again within future terminal wins)
source ~/.bash_profile
source ~/.zshrc

# then final step of phase 1, test it
echo 'test it with alias => art'
