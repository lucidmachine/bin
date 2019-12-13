#!/bin/bash
# Converts a given .flac audio file to .mp3

function require_bin() {
    local bin=$1

    if [[ -n $(which ${bin}) ]]; then
        >&2 echo "${bin} not installed"
        exit 1
    fi
}

require_bin 'metaflac'
require_bin 'flac'
require_bin 'lame'
require_bin 'id3'

flac_filename=$1
mp3_filename=$(echo ${flac_filename} | sed -e 's/\.flac$/.mp3/')

# Metadata
artist=`metaflac "${flac_filename}" --show-tag=ARTIST | sed s/.*=//g`
title=`metaflac "${flac_filename}" --show-tag=TITLE | sed s/.*=//g`
album=`metaflac "${flac_filename}" --show-tag=ALBUM | sed s/.*=//g`
genre=`metaflac "${flac_filename}" --show-tag=GENRE | sed s/.*=//g`
tracknumber=`metaflac "${flac_filename}" --show-tag=TRACKNUMBER | sed s/.*=//g`
date=`metaflac "${flac_filename}" --show-tag=DATE | sed s/.*=//g`

# Encoding
# LAME encoding switches:
    # -m j      : Joint-stereo mode
    # - q 0     : Highest quality, lowest speed
    # --vbr-new : Use newest algorithm for speed boost
    # -V 0      : Highest VBR quality
    # -s 44.1   : Sample at 44.1 kHz
flac --stdout --decode "${flac_filename}" \
    | lame -m j -q 0 --vbr-new -V 0 -s 44.1 - "${mp3_filename}"
id3 \
    -t "$title" \
    -T "${tracknumber:-0}" \
    -a "$artist" \
    -A "$album" \
    -y "$date" \
    -g "${genre:-12}" \
    "${mp3_filename}"
