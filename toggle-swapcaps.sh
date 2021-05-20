#! /bin/bash

# Toggle swapping Caps and Ctrl

setxkbmap -query | grep 'options' &> /dev/null

if [ $? -eq 0 ]; then
  setxkbmap -option
else
  setxkbmap -option ctrl:swapcaps
fi
