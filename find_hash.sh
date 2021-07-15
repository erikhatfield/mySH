#!/bin/sh

###################
## Super simple shell uses 'find', 'md5', and 'grep' to print paths of files with matching md5 hash input parameter
##
## Get an md5 file has string on the macos commandline:
## %md5 /path/to/the/file/to/hash.yay
##
## Run this shell:
## %./find_hash.sh eg1anmd5h4sh5tr5amp13101lolw00t

FILE_HASH_MD5="${1?input arguement missing - include an md5 file hash string when running this shell.}"

## Traverses current ./ directory tree returning filepaths matching the md5 hash passed in as arguement
find ./ -type f -exec md5 {} + | grep $FILE_HASH_MD5
