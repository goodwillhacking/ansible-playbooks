#!/bin/bash

export DISPLAY=:0
export XAUTHORITY=/home/lbischof/.Xauthority

echo "Monitor state changed"
xrandr --output DP-1-1 --off --output DP-1-2 --off
xrandr --output eDP-1 --auto --output DP-1-1 --auto --right-of eDP-1 --primary --output DP-1-2 --auto --right-of DP-1-1
