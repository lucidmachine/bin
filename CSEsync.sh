#!/bin/bash

# Vars
key=/home/watchboy/.ssh/id_rsa
ruser=slenkeri
rhost=adriatic.cse.msu.edu
rpath=/user/slenkeri/Projects/
lpath=/home/watchboy/CSE-231/
gitRepo=CSE-231
gitSpec=master

# Functions
function help
{
echo "
Synopsis:

$0 [OPTIONS]

Description:

Uses git, rsync, and ssh with default switches to synchronize CSE project folders.

Options:

-h Displays this help hessage
-n Performs a dry-run
-p Pushes local files to server
-P Pulls remote files from server
"
}

function push
{
rsync -"$rSyncDryRun"vrut -e "ssh -i $key" "$lpath" $ruser@$rhost:$rpath
cd "$lpath"
ls
git commit -a
git push "$gitRepo" "$gitSpec"
}

function pull
{
rsync -"$rSyncDryRun"vrut -e "ssh -i $key" $ruser@$rhost:$rpath "$lpath"
}

# Prevent execution without parameters
if [ $# -eq "0" ]; then
    help
    exit 1
fi

# Switches
pushBit=0
pullBit=0
rSyncDryRun=""
gitDryRun=""


while getopts "hnpP" Option; do
    case $Option in
        h )    help
               exit
        ;;
        n )    rSyncDryRun=n
               gitDryRun=--dry-run
        ;;
        p )    pushBit=1
        ;;
        P )    pullBit=1
        ;;
    esac
    shift $((OPTIND - 1))
done

# Logic
if [ $pushBit -eq 1  ]; then
    push    
elif [ $pullBit -eq 1 ]; then
    pull
else
    help
fi
