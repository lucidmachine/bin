#! /bin/bash

sudo apt update -q
sudo apt list --upgradable
sudo apt upgrade -y -q
sudo apt autoremove -y
