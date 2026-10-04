#!/bin/sh

choice=$(printf '%s\n' 'Lock' 'Suspend' 'Reboot' 'Power off' |
    wofi --dmenu --prompt 'Power' --width 300 --height 220 --hide-scroll)

case "$choice" in
    Lock) pgrep -x hyprlock >/dev/null || hyprlock ;;
    Suspend) systemctl suspend ;;
    Reboot) systemctl reboot ;;
    'Power off') systemctl poweroff ;;
esac
