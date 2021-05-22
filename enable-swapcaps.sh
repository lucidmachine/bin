#! /bin/bash

# Enable swapping Caps and Ctrl

setxkbmap -query | grep 'options' &> /dev/null

if [ $? -ne 0 ]; then
  setxkbmap -option ctrl:swapcaps
fi
