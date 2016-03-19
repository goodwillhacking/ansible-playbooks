#!/bin/bash

export DISPLAY=:0
export XAUTHORITY=~/.Xauthority

echo "Monitor state changed"
xrandr --output eDP1 --auto --output DP1 --auto --right-of eDP1 --primary --output DP2 --auto --right-of DP1

