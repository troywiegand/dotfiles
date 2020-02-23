#!/bin/sh
xrandr --output DVI-I-1-1 --off --output eDP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DVI-I-2-2 --off --output HDMI-2 --off --output HDMI-1 --mode 1920x1080 --pos 1920x0 --rotate normal --output DP-2 --off --output DP-1 --off

for x in `seq 6 10`;
do 
	bspc desktop $x -m HDMI-1
done

bspc wm -r 
sleep 5
wal -i ~/Pictures/Wallpapers/CSTutor.png
