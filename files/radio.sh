#!/bin/bash
pidfile=$HOME/.radio.pid
if [[ -f $pidfile ]]; then
    pkill -P $(cat $pidfile)
    rm -f $pidfile
    echo "Stopped radio"
    exit
fi
echo "Started radio"
(
# kill vlc when exiting
trap "rm -f $pidfile; mosquitto_pub -t computer/radio/status -m OFF" EXIT
vlc -I cli --rc-host 127.0.0.1:9876 --no-volume-save https://somafm.com/indiepop130.pls &
mosquitto_pub -t computer/radio/status -m ON
sleep 5
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
) &> /dev/null &
echo $! > $pidfile
