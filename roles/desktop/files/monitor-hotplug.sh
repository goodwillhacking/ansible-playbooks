#!/bin/bash

#Adapt this script to your needs.

DEVICES=$(find /sys/class/drm/*/status)

#inspired by /etc/acpd/lid.sh and the function it sources

displaynum=`ls /tmp/.X11-unix/* | sed s#/tmp/.X11-unix/X##`
display=":$displaynum.0"
export DISPLAY=":$displaynum.0"

uid=$(ck-list-sessions | awk 'BEGIN { unix_user = ""; } /^Session/ { unix_user = ""; } /unix-user =/ { gsub(/'\''/,"",$3); unix_user = $3; } /x11-display = '\'$display\''/ { print unix_user; exit (0); }')
if [ -n "$uid" ]; then
	# from https://wiki.archlinux.org/index.php/Acpid#Laptop_Monitor_Power_Off
	export XAUTHORITY=$(ps -C Xorg -f --no-header | sed -n 's/.*-auth //; s/ -[^ ].*//; p')
else
  echo "unable to find an X session"
  exit 1
fi


#this while loop declare the $HDMI1 $VGA1 $LVDS1 and others if they are plugged in
while read l
do
  dir=$(dirname $l);
  status=$(cat $l);
  dev=$(echo $dir | cut -d\- -f 2-);

  if [ $(expr match  $dev "HDMI") != "0" ]
  then
#REMOVE THE -X- part from HDMI-X-n
    dev=HDMI${dev#HDMI-?-}
  else
    dev=$(echo $dev | tr -d '-')
  fi

  if [ "connected" == "$status" ]
  then
    echo $dev "connected"
    declare $dev="yes";

  fi
done <<< "$DEVICES"


if [ -n "$DP1" -a -n "$DP2" ]
then
  echo "DP1 and DP2 are plugged in"
  xrandr --output DP1 --mode auto --right-of eDP1 --primary
  xrandr --output DP2 --mode auto --right-of DP1 --noprimary
else
  echo "No external monitors are plugged in"
  xrandr --output DP1 --off
  xrandr --output DP2 --off
fi

