#! /bin/bash

# Requires vorbis-tools

# Variables
backupDir="/media/Backup/Music/"
localDir="/home/watchboy/Music/"

# Functions
function help
{
echo "
Synopsis:

$0 [OPTIONS]

Description:

Synchronizes external and internal music directories using rsync. Transcodes all .flac files in local directory to .ogg.

Options:

-h Displays this help message
-n Performs a dry-run
"
}

# Switches
rsyncDryRun=""

while getopts "hn" Option; do
    case $Option in
        h )     help
                exit
        ;;
        n )     rsyncDryRun=n
        ;;
    esac
    shift $((OPTIND - 1))
done

# Synchronize all files b/w external and internal drives
# Note: this will transfer all .flac files for songs that have already been converted to .ogg
find $backupDir -mindepth 2 -maxdepth 2 -type d -exec rsync -"rsyncDryRun"vru '{}' $localDir \;

find $localDir -type f -name *.flac -exec oggenc -q 7 '{}' \; 
find $localDir -type f -name *.flac -exec rm '{}' \;
