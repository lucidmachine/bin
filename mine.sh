#!/bin/sh
# Makes the current user the owner of the target files or directories

current_user=$(whoami)
targets=$@

for target in "${targets}"; do
  sudo chown -R ${current_user} ${target}
  sudo chgrp -R ${current_user} ${target}
done
