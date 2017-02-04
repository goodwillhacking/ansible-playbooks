#!/bin/bash
# Map directions to vim letters
declare -A directions
directions[right]="h"
directions[left]="l"
directions[up]="k"
directions[down]="j"
# Test if input is correct
[ "$#" -eq 1 ] || exit 1
[ "${directions[$1]+isset}" ] || exit 1
title=$(xdotool getactivewindow getwindowname)
if [[ "$title" == nvim* ]]; then
    nvr --servername "${title#nvim:}" --remote-expr "Focus('$1','${directions[$1]}')"
else
    i3-msg -q focus "$1"
fi
