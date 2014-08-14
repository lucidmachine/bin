#!/bin/bash
address='90:7F:61:11:47:2E'

# Remove old pairing
sudo bluez-simple-agent hci0 $address remove

# Start hcidump to get passkey
sudo hcidump -a | grep 'passkey' &

# Pair
sudo bluez-simple-agent hci0 $address
sudo bluez-test-device trusted $address yes
sudo bluez-test-input connect $address