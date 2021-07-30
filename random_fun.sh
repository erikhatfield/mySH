#!/bin/sh

####################
## crontab syntax ##
## 
##    *    *    *   *   *    command_to_executed
##    |    |    |   |   |
##    |    |    |   |   +----- day of week (0 - 6) (Sunday=0)
##    |    |    |   +------- month (1 - 12)
##    |    |    +--------- day of month (1 - 31)
##    |    +----------- hour (0 - 23)
##    +------------- min (0 - 59)
##
###########################
## fun, this is random.) ##
## 59 21 * * 1,2,3,4,5 echo "The time is 2200 hours on a weekday, sir."
#######################################################################

# generate random number and store in variable 
rand=$RANDOM

echo "a random integer <= 325"
echo $(( rand %= 325 ))
# difference in operators? mod equals vs. just mod -wondering: <= vs. <
echo $(( rand % 325 ))

echo "random number between 325 and 25 (excitiiiiing)"
echo $(( rand % 325 + 25 ))

echo "5 random ints in said range (with spiffy one-line for loop)"
## for i in {1..5}; do echo $(( RANDOM % 325 + 25 )); done
# same for loop in easier-to-read format (for shell script)
for i in {1..5}
  do
    echo $(( RANDOM % 325 + 25 ))
done

# echo a random (between 3 and 7) amount of random ints in ^said^ range (with super-codey one-line for loop)
for ((i=1; i<=$(( RANDOM % 7 + 3 )); i++)); do echo $(( RANDOM % 325 + 25 )); done
# same for loop expanded:
for ((i=1; i<=$(( RANDOM % 7 + 3 )); i++))
  do
    echo $(( RANDOM % 325 + 25 ))
done

#############################################################
## RANDOM_NOTE2SELF: how to spell the word 'environment'   ##
## env iron ment                                           ##
#############################################################
# print env variables
env

# random:
# 2 ways to exit the vi/vim editor
# first: open another terminal window and type 'man vim' to read exit instructions
## second: type the 'esc' key a random number of times (at least twice), then type the three characters :q! and hit 'enter'
## exit vim: 'esc' :q! 'enter'
