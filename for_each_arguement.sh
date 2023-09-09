#!/bin/bash

################
### instructions 
##ensure exec privs
#% chmod u+x ./for_each_arguement.sh
##use bash
#% ./for_each_arguement.sh "arguement one" "argument ii"
################

#######################################################
# setup and use a relative path for blash-list txt file
realpath() {
    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}
relative_path=$(realpath "$0") #contains filename.ext
relative_dir=$(dirname $relative_path)
echo "Working directory: "$relative_dir
cd $relative_dir #might fail if spaces in path?

###############################
# iterate thru params handed in
for filepath in "$@"
do
    echo "operating on file @ filepath: $filepath"
    #md5 -q "$filepath" >> ~/Desktop/blash-list.txt
    #md5 -q "$filepath" >> $relative_dir/blash-list.txt
    
    echo "Saving blash-list in dir @"$(pwd)
    md5 -q "$filepath" >> ./blash-list.txt
done
#excitingggg stufffff... =P
