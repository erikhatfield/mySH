#!/bin/sh

###################
## instructions: ##
## run both of these lines on the command line from within the containing directory.
#% chmod u+x for_each_arguement.sh
#% ./for_each_arguement.sh "arguement one" "argument ii" "arguement 3"

for arguement in "$@"
do
    echo "$arguement"
done
