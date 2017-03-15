#!/bin/bash
pidfile=$HOME/.radio.pid
if [[ -f $pidfile ]]; then
    read -p "Stop playing radio? " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        pkill -F $pidfile
        rm $pidfile
        echo "Stopped radio"
    fi
    exit 1
fi
echo "Started radio"
(
# kill vlc when exiting
trap "kill 0" EXIT
vlc -I cli --rc-host 127.0.0.1:9876 --no-volume-save https://somafm.com/indiepop130.pls &> /dev/null &
volume=256
while true; do
    if [[ -n $(lsof -tc '^vlc' /dev/snd/*) ]] ; then
        [[ $volume -gt 110 ]] && volume=$(( volume - 50 ))
    else
        [[ $volume -lt 256 ]] && volume=$(( volume + 10 ))
    fi
    echo "volume ${volume}" > /dev/tcp/127.0.0.1/9876
    if [[ $? -ne 0 ]]; then
        exit 1
    fi
    sleep 1
done
) &
echo $! > $pidfile
