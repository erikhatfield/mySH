#!/bin/sh

###################
## 

## Traverses current ./ directory tree returning filepaths matching the md5 hash passed in as arguement
find ./ -type f -exec md5 {} + | grep $FILE_HASH_MD5
