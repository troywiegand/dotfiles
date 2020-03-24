#!/bin/sh
xrandr --output DVI-I-1-1 --mode 1680x1050 --pos 0x30 --rotate normal --output eDP-1 --primary --mode 1920x1080 --pos 1680x0 --rotate normal --output DVI-I-2-2 --mode 1920x1080 --pos 3600x0 --rotate normal --output HDMI-2 --off --output HDMI-1 --mode 1600x900 --pos 5520x108 --rotate normal --output DP-2 --off --output DP-1 --off

for x in `seq 1 2`;
do
    bspc desktop $x -m DVI-I-1-1
    bspc desktop $(expr $x + 8) -m HDMI-1
done

for x in `seq 3 5`;
do 
    bspc desptop $x -m eDP-1
    bspc desktop $(expr $x + 3)  -m DVI-I-2-2
done

bspc wm -r
