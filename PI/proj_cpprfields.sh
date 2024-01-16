#!/bin/bash

#erases cpprfields, formats new cpprfields, and ejects it

ls -la /media/pi

lsblk

#both cpprfields and /dev/sda could be different
umount /media/pi/cpprfields
sudo mkfs.exfat -n 'cpprfields' /dev/sda
sudo eject sda
