#!/bin/bash
title=$(xdotool getactivewindow getwindowname)
if [[ "$title" == nvim* ]]; then
    nvr --servername ${title#nvim:} --remote-send gw${1::1}
else
    i3-msg -q focus $1
fi
