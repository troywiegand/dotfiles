#!/bin/sh
xrandr --output DVI-I-1-1 --mode 1680x1050 --pos 0x0 --rotate normal --output eDP-1 --primary --mode 1920x1080 --pos 1680x0 --rotate normal --output DVI-I-2-2 --mode 1920x1080 --pos 3600x0 --rotate normal --output HDMI-2 --off --output HDMI-1 --off --output DP-2 --off --output DP-1 --off

for x in `seq 1 3`;
do
	bspc desktop $x -m DVI-I-1-1
	bspc desktop $(expr $x + 3) -m eDP-1
done

for x in `seq 7 10`;
do
	bspc desktop $x -m DVI-I-2-2
done

bspc wm -r
