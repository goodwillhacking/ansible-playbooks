#!/bin/bash

function power_set {
    message=$1
    if [ $message = 'OFF' ]; then
        shutdown -h now
    fi
}

function radio_set {
    message=$1
    if [ $message = 'ON' ]; then
        if [ ! -f $HOME/.radio.pid ]; then
            radio
        else
            mosquitto_pub -t computer/radio/status -m ON
        fi
    else
        if [ -f $HOME/.radio.pid ]; then
            radio
        else
            mosquitto_pub -t computer/radio/status -m OFF
        fi
    fi
}

function volume_set {
    message=$1
    amixer set Master -Mq "${message}%"
}

until ping -n -c1 -w5 8.8.8.8; do sleep 5; done
while read line; do
    echo $line
    topic=$(echo $line | awk '{print $1}')
    message=$(echo $line | cut -f2- -d' ')
    case "$topic" in
        computer/power/set) power_set $message ;;
        computer/radio/set) radio_set $message ;;
        computer/volume/set) volume_set $message ;;
    esac
done < <(mosquitto_sub -t 'computer/#' -v)
