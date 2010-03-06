#!/bin/bash
for i in *.m4a
do
OUTF=`echo "$i" | sed s/\.m4a$/.mp3/g`
ffmpeg -v 5 -y -i "$i" -acodec libmp3lame -ac 2 "$OUTF"
done
