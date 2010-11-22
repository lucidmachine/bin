#! /bin/bash
# To Do:
#   Accept arguments for alternate home and target directories
#   Switch to move Videos directory

homeDir='/home/watchboy/'
targetDir='/media/Backup/'

apt-cache pkgnames > "$homeDir"Desktop/packages.list
tar -cvzWf "$targetDir"laptop-"`date`".tar.gz /home/watchboy --exclude="$homeDir"Music --exclude="$homeDir"Podcasts --exclude="$homeDir"Videos
#mv -v "$homeDir"Videos "$targetDir" 
