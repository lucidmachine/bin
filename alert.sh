#! /bin/bash

# Send a notification.

if [ $# = 2 ]; then
  app_name=$1
  text=$2
else
  app_name="alert.sh"
  text=$1
fi

if [ $? = 0 ]; then
  urgency="normal"
  icon="terminal"
else
  urgency="critical"
  icon="error"
fi

notify-send \
  --urgency=${urgency} \
  --icon=${icon} \
  --app-name=${app_name} \
  "${text}"
