#! /bin/bash
# To Do:
#   Accept arguments for alternate home and target directories
#   Argument for alternate config file
#   Switch to move Videos directory

configFile='backup.conf'
homeDir="`cat $configFile | grep homeDir | sed 's/homeDir=//'`"
targetDir="`cat $configFile | grep targetDir | sed 's/targetDir=//'`"
mysqlUsername="`cat $configFile | grep mysqlUsername | sed 's/mysqlUsername=//'`"
mysqlPassword="`cat $configFile | grep mysqlPassword | sed 's/mysqlPassword=//'`"


apt-cache pkgnames > "$homeDir"Desktop/packages.list
mysqldump --all-databases -u "$mysqlUsername" -p "$mysqlPassword" | gzip > "$homeDir"Desktop/MySQL-"`date`".sql.gz
tar -cvzWf "$targetDir"laptop-"`date`".tar.gz /home/watchboy --exclude="$homeDir"Music --exclude="$homeDir"Podcasts --exclude="$homeDir"Videos
#mv -v "$homeDir"Videos "$targetDir" 
