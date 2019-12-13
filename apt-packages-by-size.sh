#!/bin/bash
# Sorts installed .deb packages by size, large to small

dpkg-query --show --showformat='${Package;-50}\t${Installed-Size}\n' \
    | sort -k2 -nr \
    | less
