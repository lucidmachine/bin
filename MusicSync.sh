#! /bin/bash

# Requires vorbis-tools

# Variables
backupDir="/media/Backup/Music/"
localDir="/home/watchboy/Music/"

# Synchronize all files b/w external and internal drives
# Note: this will transfer all .flac files for songs that have already been converted to .ogg
find $backupDir -mindepth 2 -maxdepth 2 -type d -exec rsync -vru '{}' $localDir \;

find $localDir -type f -name *.flac -exec oggenc -q 7 '{}' \; 
find $localDir -type f -name *.flac -exec rm '{}' \;
