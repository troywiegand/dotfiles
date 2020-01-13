#!/bin/sh
xrandr --output HDMI-2 --off --output HDMI-1 --mode 1280x768 --pos 2560x0 --rotate normal --output DP-1 --off --output eDP-1 --primary --mode 2560x1440 --pos 0x0 --rotate normal --output DP-2 --off

for x in `seq 6 10`;
do
	bspc desktop $x -m HDMI-1
done

bspc wm -r
