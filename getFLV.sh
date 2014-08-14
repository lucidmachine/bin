#! /bin/bash

# ######
# Config
# ######
DIR="$HOME/Videos/"

# ####
# Args
# ####
if [ $1 ]; then
    echo $1
fi

# ####
# Main
# ####
for FILE in $(lsof -n|grep .tmp.Flash | awk '{print "/proc/" $2 "/fd/" $4}' | sed 's/.$//'); do
    cp -v $FILE $(mktemp -u --suffix=.flv --tmpdir=$DIR)
done
