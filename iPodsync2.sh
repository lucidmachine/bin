#! /bin/bash

MINPARAMS=1

delete=""
dry_run=""
quiet=""

function help
{
echo "
Synopsis:

$0 [OPTIONS] [Source Directory] [Destination Directory]

Description:

At this point, basically rsync with default switches and excludes and a slimmer option list

Options:

-d	Deletes any files from the destination not found in the source
-h	Displays this help message
-n	Perform a dry-run test without actually making changes
-q	Runs without output
"
}

# Prevents execution without parameters 
if [ $# -eq "0" ]; then
    help
    exit 1
fi

# Switches
while getopts "dhnq" Option; do
    case $Option in
        d )		delete="--delete"
        ;;
        h )		help
			exit
        ;;
        n )		dry_run=n
        ;;
        q )		quiet=q
        ;;
    esac
    shift $(($OPTIND - 1)) # Shifts the old $2 to $1 and so on
done

cd $1

# Recursively updates, preserving timestamps and excluding video and bookmarks
rsync -"$dry_run"rvut"$quiet" --exclude Gnooze/ --exclude Sessler\'s\ Soapbox/ --exclude X-Play\'s\ Daily\ Video\ Podcast/ --exclude Ask\ A\ Ninja/ --exclude *.bmark "$delete" "$1" "$2"

# Sets last sync date
#date > /media/IPOD/02\ Podcasts/.last_sync.txt

exit
