#!/usr/bin/env bash

killall conky

monitors=$(xrandr --listmonitors | awk '/ [0-9]:/{print substr($1,1,length($1)-1)}')

for monitor in $monitors; do
    conky -c ~/.config/conky/conky.conf -m $monitor -d 
    conky -c ~/.config/conky/weather.conf -m $monitor -d 
done

