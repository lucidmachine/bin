#! /bin/bash
# Concatenates mp3 files in a directory into one mp3 file
# Depends:
## ffmpeg
## id3
## mp3wrap

album=
artist=
year=
genre=
comment=

mp3wrap temp.mp3 *.mp3
ffmpeg -i temp_MP3WRAP.mp3 -acodec copy "$album".mp3 && rm temp_MP3WRAP.mp3
id3 -t "$album" -T 1 -a "$artist" -A "$album" -y "$year" -c "$comment" -g "$genre" "$album".mp3
