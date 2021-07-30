#!/bin/sh

###############################
## Set environment variables ##
## 

# actually
#################################
## LEARN environment variables ##
## 

# print env variables
env

####if your shell %env | grep "SHELL" is bash this, or bash that, or zsh sw00sh... workin prog

# Set default EDITOR to nano
## if your shell is zsh, set/echo and activate/source
echo 'export EDITOR=nano' >> ~/.zshrc
echo 'export VISUAL="$EDITOR"' >> ~/.zshrc
source ~/.zshrc

## if your shell is bash
echo 'export EDITOR=nano' >> ~/.bash_profile
echo 'export VISUAL="$EDITOR"' >> ~/.bash_profile
source ~/.bash_profile

## what is ~/.bashrc from?

## vi vim!
## exit vim: 'esc' :q! 'enter'
