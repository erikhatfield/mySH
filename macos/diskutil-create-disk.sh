#!/bin/bash


# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing 'sudo' time stamp until sh(es) has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

#################################################################################
# Create encrypted disk (macOS)	with diskutil									#
#################################################################################

# List all disks and partitions
diskutil list && echo

# Schemes available: [APM[Format]|MBR[Format]|GPT[Format]]
# Formats available: [HFS+|APFS|FAT32|ExFAT|JHFS+|JHFSX|Case-sensitive APFS|Case-sensitive HFS+|Encrypted APFS|Encrypted HFS+|Encrypted Case-sensitive APFS|Encrypted Case-sensitive HFS+]

# Format as an encrypted case-sensitive Extended Journaled disk with schema GPT

# Initialize two input parameters:
# 1) BSD disk identifier (a devfs device node), e.g. /dev/disk2.
# 2) Disk name, e.g. "SUPER62".
DISK_NODE="$1"
DISK_NAME="$2"

# If < 2 parameters are provided, exit with error message
if [ "$#" -lt 2 ]; then
    echo "**********************************************************"
    echo "Error: Not enough parameters provided."
    echo "Usage: $0 <disk_node> <disk_name>"
    echo "Example: $0 /dev/disk2 SUPER62"
    echo "**********************************************************"
    exit 1
fi

# Check if diskutil info $DISK_NODE contains a Volume that matches DISK_NAME
if diskutil list "$DISK_NODE" | grep -q " $DISK_NAME "; then
    echo "Disk $DISK_NODE with $DISK_NAME Confirmed, proceeding with eraseDisk..."
    sleep 2
    # Proceed to erase and format the disk
    sudo diskutil eraseDisk "Journaled HFS+ (Encrypted)" "$DISK_NAME" GPT "$DISK_NODE"

    #JHFS+ = Journaled HFS+ (case‑insensitive).
    #JHFSX = Journaled HFS+ (case‑sensitive).

    ### in progress: in order to encrypt a macOS Extended format disk, you will need MacOS catalina or earlier, if you use APFS, all those legacy air-gapped machines won't mount the disk.
    ### legacy machines are becoming gold, eh?
    sleep 2

    #enableOwnership
    #sudo diskutil enableOwnership "/Volumes/$DISK_NAME"

else
    echo "**********************************************************"
    echo "Error: Disk $DISK_NODE does not have Volume Name $DISK_NAME"
    echo ""
    echo "pre-format the disk at $DISK_NAME with a disk named $DISK_NAME and try again."
    echo "**********************************************************"
    exit 1
fi



