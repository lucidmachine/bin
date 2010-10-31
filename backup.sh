#! /bin/bash
#mv -v /home/watchboy/Videos /media/Backup
apt-cache pkgnames > /home/watchboy/Desktop/packages.list
tar -cvzWf /media/Backup/laptop-"`date`".tar.gz /home/watchboy --exclude=/home/watchboy/Music --exclude=/home/watchboy/Podcasts --exclude=/home/watchboy/Videos
