#!/bin/bash

scrot /tmp/screen.png
/home/troy/dotfiles/scripts/videoglitch -a 100 -n 12 -d -1 -c green-magenta -j 50 /tmp/screen.png /tmp/glitched.png
i3lock -i /tmp/glitched.png
