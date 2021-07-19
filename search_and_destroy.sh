#!/bin/sh

###################
## Work in progress, code sample dumps 
## 
## w00ttles here works with a pre-compiled list of file hashes of known deleteable files in my vast digital archivials. 
## for every line in blash-list txt, treat as string and search the dir tree of parametered dir path for files with md5 hash string that matches
##
## w00tles can have filter out sprinklettos of screwballium

#howdoyouunderstandmenow

#dry#find . -type f -exec md5 {} + | awk '$1 == "eg1anmd5h4sh5tr5amp13101lolw00t" {printf "%s\0", substr($0, 35)}' | xargs -r0 -n1
#wet#find . -type f -exec md5 {} + | awk '$1 == "eg1anmd5h4sh5tr5amp13101lolw00t" {printf "%s\0", substr($0, 35)}' | xargs -r0 rm -rf

#awk '{printf "%s%s", NR-1 ? "|" : "", $1}' blash-list.txt will reformat this into a single line of pipe | separated hashes.

#Use this variant of the original command to match hashes using regex rather than an exact string match: 
#find . -type f -exec md5sum {} + | awk '$1 ~ "^('$(awk '{printf "%s%s", NR-1 ? "|" : "", $1}' hashes.txt)')$" {printf "%s\0", substr($0, 35)}' | xargs -r0 -n1
