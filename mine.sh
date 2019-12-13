#!/bin/sh
# Makes the current user the owner of the target file or directory

current_user=$(whoami)
target=$1

sudo chown -R ${current_user} ${target}
sudo chgrp -R ${current_user} ${target}
