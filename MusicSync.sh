#! /bin/bash

# Requires vorbis-tools

# Synchronize all files b/w external and internal drives
# Note: this will transfer all .flac files for songs that have already been converted to .ogg
find /media/Backup/Music/ -mindepth 2 -maxdepth 2 -type d -exec rsync -vru '{}' /home/watchboy/Music \;

find /home/watchboy/Music -type f -name *.flac -exec oggenc -q 7 '{}' \; 
find /home/watchboy/Music -type f -name *.flac -exec rm '{}' \;
