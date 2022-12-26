#! /bin/bash

# Use rsync to synchronize various home subdirectories with a given destination directory

dest_dir=${1:-/mnt/usb/home}

rsync \
  --dry-run \
  --archive \
  --delete \
  --verbose \
\
  ~/.emulationstation \
  ~/.environment-ext \
  ~/.skyscraper \
  ~/.ssh \
  ~/Books \
  ~/Compositions \
  ~/Desktop \
  ~/Documents \
  ~/Music \
  ~/Notes \
  ~/Pictures \
  ~/Sync \
  ~/Templates \
  ~/Videos \
  ~/bin \
  ~/roms \
  ~/src \
\
  ${dest_dir}
