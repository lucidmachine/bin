#!/bin/bash

# Vars
key=/home/watchboy/.ssh/id_dsa
ruser=slenkeri
rhost=adriatic.cse.msu.edu
rpath=/user/slenkeri/Projects/
lpath=/home/watchboy/School/Programming\ I/Projects/

function help
{
echo "
Synopsis:

$0 [OPTIONS]

Description:

Uses rsync and ssh with default switches to synchronize CSE project folders.

Options:

-h Displays this help hessage
-n Performs a dry-run
-p Pushes local files to server
-P Pulls remote files from server
"
}

# Prevent execution without parameters
if [ $# -eq "0" ]; then
    help
    exit 1
fi

# Switches
push=0
pull=0
dry_run=""

while getopts "hnpP" Option; do
    case $Option in
        h )    help
            exit
        ;;
        n )    dry_run=n
        ;;
        p )    push=1
        ;;
        P )    pull=1
        ;;
    esac
    shift $((OPTIND - 1))
done

# Logic
if [ $push -eq 1  ]; then
    rsync -"$dry_run"vrut -e "ssh -i $key" "$lpath" $ruser@$rhost:$rpath
elif [ $pull -eq 1 ]; then
    rsync -"$dry_run"vrut -e "ssh -i $key" $ruser@$rhost:$rpath "$lpath"
else
    help
fi
