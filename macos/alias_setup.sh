# bin bish bash zsh ! from template
# add alias for art 
# perhaps check to see if it exists? that is, check to see if line u about to add exists already in:
# ~/.bash_profile
# and
# ~/.zshrc
# or
# just (first phase)
# add it to both 
# ~/.bash_profile and ~/.zshrc
# like so:
echo 'alias art="~/Dev/BL/art-from-code/SH/art-from-code.sh"' >> ~/.bash_profile
echo 'alias art="~/Dev/BL/art-from-code/SH/art-from-code.sh"' >> ~/.zshrc
# and then source both of them (so that it may work again within future terminal wins)
source ~/.bash_profile
source ~/.zshrc
# then final step of phase 1, test it
art

