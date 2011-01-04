#!/bin/bash

# Variables
SOURCEDIR=""
DESTDIR="/home/watchboy/Downloads/Andy Thomas/Blood And Sunshine"

# Functions
# #############################################################################
# Name: Convert
#
# Purpose: Convert the given .flac file
# Receive: .flac filename, destination directory
# #############################################################################
function convert {
    # Metadata
    ARTIST=`metaflac "$1" --show-tag=ARTIST | sed s/.*=//g`
    TITLE=`metaflac "$1" --show-tag=TITLE | sed s/.*=//g`
    ALBUM=`metaflac "$1" --show-tag=ALBUM | sed s/.*=//g`
    GENRE=`metaflac "$1" --show-tag=GENRE | sed s/.*=//g`
    TRACKNUMBER=`metaflac "$1" --show-tag=TRACKNUMBER | sed s/.*=//g`
    DATE=`metaflac "$1" --show-tag=DATE | sed s/.*=//g`
    
    # Filename
    NUM="$TRACKNUMBER"
    if ((NUM < 10)); then
        NUM=""0""$TRACKNUMBER""
    fi
    OUTF=""$2"/"$ARTIST"/"$ALBUM"/"$NUM" - "$TITLE".mp3"

    # Create Target Directory
    TDIR=""$2"/"$ARTIST"/"$ALBUM""
    if [ ! -d "$TDIR" ]; then
        mkdir -p "$TDIR"
    fi
    
    # Encoding
    # LAME encoding switches:
        # -m j      : Joint-stereo mode
        # - q 0      : Highest quality, lowest speed
        # --vbr-new : Use newest algorithm for speed boost
        # -V 0      : Highest VBR quality
        # -s 44.1   : Sample at 44.1 kHz
    flac --stdout --decode "$1" | lame -m j -q 0 --vbr-new -V 0 -s 44.1 - "$OUTF"
    id3 -t "$TITLE" -T "${TRACKNUMBER:-0}" -a "$ARTIST" -A "$ALBUM" -y "$DATE" -g "${GENRE:-12}" "$OUTF"
}

for a in *.flac
do
    convert "$a" "$DESTDIR"
done
