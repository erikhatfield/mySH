#!/bin/sh

###################
## instructions: ##
## run both of these lines on the command line from within the containing directory.
#% chmod u+x for_each_arguement.sh
#% ./for_each_arguement.sh "arguement one" "argument ii"

#######################################################
# setup and use a relative path for blash-list txt file
realpath() {
    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}
relative_path=$(realpath "$0")
relative_dir=$(dirname $relative_path)
echo $relative_dir

###############################
# iterate thru params handed in
for filepath in "$@"
do
    echo "working with filepath: $filepath"
    #md5 -q "$filepath" >> ~/Desktop/blash-list.txt
    #md5 -q "$filepath" >> $relative_dir/blash-list.txt
    cd $relative_dir
    cd ../RUN
    echo "Saving blash-list in dir @"$(pwd)
    md5 -q "$filepath" >> ./blash-list.txt
done
