#!/usr/bin/env bash

start-applet() {
    pid=$(pgrep $1)
    if [[ -n "$pid" ]]; then
        killall $1
    fi
    $@ &

}

xset s 180 120
xss-lock -n "dimscreen" -l -- sLockscreenctl lock &
setxkbmap -option compose:ralt

# exec_always --no-startup-id feh --bg-scale /home/jelle/.wallpaper.jpg
~/.screenlayout/default.sh
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
picom -b
# nitrogen --restore
# $HOME/.config/polybar/launch.sh
# start-applet pa-applet --disable-key-grabbing
start-applet nm-applet
start-applet blueman-tray
~/.config/conky/start.sh

# Keys
# exec_always xmodmap -e "clear lock" #disable caps lock switch
# exec_always xmodmap -e "add control = Control_L" #set caps_lock as escape
# dropbox start &
# xfce4-power-manager &
