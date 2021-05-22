#! /bin/sh

# Disables the touchpad

device_id=$( \
  xinput list \
  | grep -i 'touchpad' \
  | sed -e 's/.*id=\([0-9]*\).*/\1/' \
)

is_enabled=$( \
  xinput list-props ${device_id} \
  | grep "Device Enabled" \
  | sed -e 's/.*:[^0-1]*\([0-1]\)/\1/' \
)

if [ ${is_enabled} -eq 1 ]; then
  xinput disable ${device_id}
fi
