#! /bin/bash
mv -v /home/watchboy/Videos /media/Backup
tar -cvzWf /media/Backup/laptop-"`date`".tar.gz /home/watchboy --exclude=/home/watchboy/Music --exclude=/home/watchboy/Podcasts --exclude=/home/watchboy/Videos
