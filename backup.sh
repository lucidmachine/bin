#! /bin/bash
# To Do:
#   Switches
#       --config / -c   - load alt. configFile
#       --home / -h     - alt. homeDir
#       --target / -t   - alt. targetDir
#       --video / -d    - move Videos directory to target

configFile='backup.conf'
homeDir="`cat $configFile | grep homeDir | sed 's/homeDir=//'`"
targetDir="`cat $configFile | grep targetDir | sed 's/targetDir=//'`"
mysqlUsername="`cat $configFile | grep mysqlUsername | sed 's/mysqlUsername=//'`"
mysqlPassword="`cat $configFile | grep mysqlPassword | sed 's/mysqlPassword=//'`"


apt-cache pkgnames > "$homeDir"Desktop/packages.list
mysqldump --all-databases -u "$mysqlUsername" -p "$mysqlPassword" | gzip > "$homeDir"Desktop/MySQL-"`date`".sql.gz
tar -cvzWf "$targetDir"laptop-"`date`".tar.gz /home/watchboy --exclude="$homeDir"Music --exclude="$homeDir"Podcasts --exclude="$homeDir"Videos
#mv -v "$homeDir"Videos "$targetDir" 
