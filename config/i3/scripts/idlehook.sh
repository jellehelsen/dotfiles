#!/usr/bin/env bash

# Only exported variables can be used within the timer's command.
# export PRIMARY_DISPLAY="$(xrandr | awk '/ primary/{print $1}')"
monitors=$(xrandr --listmonitors | awk '/ [0-9]:/{print $4}')
for monitor in $monitors; do
    command+="--output $monitor --brightness .3"
done
# Run xidlehook
xidlehook \
  `# Don't lock when there's a fullscreen application` \
  --not-when-fullscreen \
  `# Don't lock when there's audio playing` \
  --not-when-audio \
  `# Dim the screen after 60 seconds, undim if user becomes active` \
  --timer 60 \
    'xrandr --output "$PRIMARY_DISPLAY" --brightness .1' \
    'xrandr --output "$PRIMARY_DISPLAY" --brightness 1' \
  `# Undim & lock after 10 more seconds` \
  --timer 10 \
    'xrandr --output "$PRIMARY_DISPLAY" --brightness 1; i3lock' \
    '' \
  `# Finally, suspend an hour after it locks` \
  --timer 3600 \
    'systemctl suspend' \
    ''
