#!/bin/bash
set -e
set -o pipefail

exec >> /var/log/monitor-hotplug.log 2>&1
echo $(date)

DEVICES=$(find /sys/class/drm/*/status)

#inspired by /etc/acpd/lid.sh and the function it sources

displaynum=$(ls /tmp/.X11-unix/* | sed s#/tmp/.X11-unix/X##)
display=":$displaynum.0"
export DISPLAY=":$displaynum.0"

# from https://wiki.archlinux.org/index.php/Acpid#Laptop_Monitor_Power_Off
export XAUTHORITY=$(ps -C Xorg -f --no-header | sed -n 's/.*-auth //; s/ -[^ ].*//; p')

#this while loop declare the $HDMI1 $VGA1 $LVDS1 and others if they are plugged in
while read l; do
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

if [ ! -z "eDP1" -a ! -z "$DP1" -a ! -z "$DP2" ]; then
    xrandr --output eDP-1 --auto
    xrandr --output DP-1-1 --auto --right-of eDP-1 --primary
    xrandr --output DP-1-2 --auto --right-of DP-1-1
    feh  --bg-fill "$HOME/.config/wallpapers/wallpaper_cropped_1.png" "$HOME/.config/wallpapers/wallpaper_cropped_0.png" "$HOME/.config/wallpapers/wallpaper_cropped_1.png"
elif [ -z "$eDP1" -a ! -z "$DP1" -a ! -z "$DP2" ]; then
    xrandr --output eDP-1 --off
    xrandr --output DP-1-1 --auto --primary
    xrandr --output DP-1-2 --auto --right-of DP-1-1
    feh  --bg-fill "$HOME/.config/wallpapers/wallpaper_cropped_0.png" "$HOME/.config/wallpapers/wallpaper_cropped_1.png"
else
    echo "No external monitors are plugged in"
    xrandr --output eDP-1 --auto --primary
    feh  --bg-fill "$HOME/.config/wallpapers/wallpaper_cropped_0.png"
fi
