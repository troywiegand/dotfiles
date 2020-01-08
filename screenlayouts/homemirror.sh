#!/bin/sh
xrandr --output DVI-I-1-1 --mode 1680x1050 --pos 0x0 --rotate normal --output eDP-1 --primary --mode 1680x1050 --pos 0x0 --rotate normal --output DVI-I-2-2 --mode 1680x1050 --pos 0x0 --rotate normal --output HDMI-2 --off --output HDMI-1 --off --output DP-2 --off --output DP-1 --off


for x in `seq 1 10`;
do
	bspc desktop $x -m DVI-I-1-1
done

