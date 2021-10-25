#!/bin/sh

# generate random number and store in variable
rand=$RANDOM
echo "random number generated: "$rand

echo "a random integer <= 25"
echo $(($RANDOM % 25))

echo "random number between 25 and 325"
echo $((25 + $RANDOM % 325))

echo "5 random ints in said range (with spiffy one-line for loop)"
## for i in {1..5}; do echo $(( RANDOM % 325 + 25 )); done
# same for loop in easier-to-read format (for shell script)
for i in {1..5}
  do
    echo $i") "$((25 + $RANDOM % 325))
done

echo ""

# echo a random (between 3 and 7) amount of random ints in ^said^ range (with super-codey one-line for loop)
echo "NOW: 3-7 random numbers between the range of 25-325"
for ((i=1; i<=$((3 + RANDOM % 7 )); i++)); do echo $i") "$((25 + RANDOM % 325 )); done
echo ""
# same for loop expanded:
for ((i=1; i<=$((3 + RANDOM % 7)); i++))
  do
    echo $i") "$((25 + RANDOM % 325))
done

#############################################################
## RANDOM_NOTE2SELF: how to spell the word 'environment'   ##
## env iron ment                                           ##
#############################################################


# random:
# 2 ways to exit the vi/vim editor
# first: open another terminal window and type 'man vim' to read exit instructions
## second: type the 'esc' key a random number of times (at least twice), then type the three characters :q! and hit 'enter'
## exit vim: 'esc' :q! 'enter'
