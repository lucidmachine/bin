#!/bin/bash
WINDOWS_DEV="/dev/sda2"
WINDOWS_MNT="/mnt/windows"
WINDOWS_DB="$WINDOWS_MNT/Users/Watchboy/Documents/Personal.kdbx"
LINUX_DB="/home/watchboy/.keepass/Personal.kdbx"

# Mount the Windows drive
sudo mount $WINDOWS_DEV $WINDOWS_MNT
echo "Windows partition mounted."

# Determine which DB is most recent
WINDOWS_UPDATED=$(date -r $WINDOWS_DB +%s)
LINUX_UPDATED=$(date -r $LINUX_DB +%s)

if [ "$WINDOWS_UPDATED" -lt "$LINUX_UPDATED" ]; then
    echo "Linux DB is more recent. Copying to Windows."
    cp $LINUX_DB $WINDOWS_DB
else
    echo "Windows DB is more recent. Copying to Linux."
    cp $WINDOWS_DB $LINUX_DB
fi
echo "Database copied."

# Unmount the Windows drive
sudo umount $WINDOWS_MNT
echo "Windows partition unmounted."
