#!/usr/bin/env bash

## Add this to your wm startup file.

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

HDMI = "$(xrandr -q | grep HDMI-1 | awk '{print $2}')"
DVI = "$(xrandr -q | grep DVI-I-1-1 | awk '{print $2}')"



## Just one thing connected
if [ "$(xrandr -q | grep HDMI-1 | awk '{print $2}')" == "connected" ]; then
	polybar -c /home/troy/.config/polybar/config.ini eDP-1 &
	polybar -c /home/troy/.config/polybar/config.ini HDMI-1 &
## The dock thingy I have at runs it with these DVI 
elif [  "$(xrandr -q | grep DVI-I-1-1 | awk '{print $2}')" == "connected" ]; then
	polybar -c /home/troy/.config/polybar/config.ini DVI-I-1-1 &
	polybar -c /home/troy/.config/polybar/config.ini eDP-1 &
	polybar -c /home/troy/.config/polybar/config.ini DVI-I-2-2 &
else
	polybar -c /home/troy/.config/polybar/config.ini eDP-1 &
fi

