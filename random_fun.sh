#!/bin/sh

# $RANDOM is an internal Bash function (not a constant) that returns a pseudorandom integer in the range 0 - 32767.
# 32767 is 2^16 / 2 - 1 which is the upper limit for a signed 16 bit integer.

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

echo

# OTHERWAYS FOR FUTURE ME
#$ shuf -i 1-100000 -n 1 #shuf is available in coreutils
#$ dd if=/dev/urandom count=4 bs=1 | od -t d
#$ od -A n -t d -N 1 /dev/urandom
#same as above, removes spaces:
#$ od -A n -t d -N 1 /dev/urandom |tr -d ' '

# awk
echo "AWK:"
awk 'BEGIN {
   # seed
   srand()
   for (i=1;i<=10;i++){
     print int(1 + rand() * 100)
   }
}'

# The below way results in bias towards numbers starting with 1, 2, or 3:
echo
echo ${RANDOM:0:1} # random number between 1 and 9
echo ${RANDOM:0:2} # random number between 1 and 99
echo

#############################################################
## RANDOM_NOTE2SELF: how to spell the word 'environment'   ##
## env iron ment                                           ##
#############################################################


# random:
# 2 ways to exit the vi/vim editor
# first: open another terminal window and type 'man vim' to read exit instructions
## second: type the 'esc' key a random number of times (at least twice), then type the three characters :q! and hit 'enter'
## exit vim: 'esc' :q! 'enter'
