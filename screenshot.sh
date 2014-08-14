#!/bin/bash
scrot '%Y-%m-%d--%s_$wx$h.png' -e 'mv $f ~/Pictures/Screenshots & chromium ~/Pictures/Screenshots/$f'
