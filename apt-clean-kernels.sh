#!/bin/bash

# Require root permissions
if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    sudo $0 "$@"
    exit
fi

ls /boot/ \
    | grep vmlinuz \
    | sed 's@vmlinuz-@linux-image-@g' \
    | grep -v `uname -r` > /tmp/kernelList
for kernel_version in `cat /tmp/kernelList`; do
    printf "Uninstalling ${kernel_version}...\n\n"
    apt-get -y purge $kernel_version
    printf "\n\n"
done
rm -f /tmp/kernelList

printf "Updating grub...\n\n"
update-grub
