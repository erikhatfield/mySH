
#!/bin/sh

################################################################
# for all files included (as params) -> run a shell listed below
#
# e.g.: 01_multiple_files_run.sh /path/to/file1.jpg /path/to/file3.jpg /path/to/file2.jpg 

for filepath in "$@"
do
    echo "$filepath"

    ./02_operate_on_file.sh $filepath
done

###################
# known limitations 
# 
# if file names have spaces or weird characters...
# 	no handling has been done yet
#####################################
