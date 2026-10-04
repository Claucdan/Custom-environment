#!/bin/sh

# Hyprlock labels accept Pango markup. Escape text coming from applications.
escape_text() {
    cut -c "1-${1:-26}" | sed -e 's/&/\&amp;/g' -e 's/</\&lt;/g' -e 's/>/\&gt;/g'
}

battery() {
    for supply in /sys/class/power_supply/*; do
        if [ -r "$supply/type" ] && [ "$(cat "$supply/type")" = Battery ]; then
            printf '%s\n' "$supply"
            return
        fi
    done
}

case "${1:-}" in
    uptime)
        awk '{ minutes = int($1 / 60); printf "󰥔 UPTIME %dH%02dM\n", int(minutes / 60), minutes % 60 }' /proc/uptime
        ;;
    weekday) LC_TIME=C date +%a | tr '[:lower:]' '[:upper:]' ;;
    date) LC_TIME=C date '+%d %B, %Y' ;;
    music-title|music-artist)
        field=title
        fallback='Nothing playing'
        if [ "$1" = music-artist ]; then
            field=artist
            fallback='Media player'
        fi
        value=''
        if command -v playerctl >/dev/null 2>&1; then
            value=$(playerctl metadata --format "{{$field}}" 2>/dev/null) || value=''
        fi
        printf '%s\n' "${value:-$fallback}" | escape_text
        ;;
    network)
        value=''
        if command -v nmcli >/dev/null 2>&1; then
            value=$(nmcli -t -f TYPE,NAME connection show --active 2>/dev/null |
                awk -F: '$1 == "802-11-wireless" || $1 == "802-3-ethernet" { sub(/^[^:]*:/, ""); print; exit }')
        fi
        printf '%s\n' "${value:-Offline}" | escape_text 18
        ;;
    bluetooth)
        value=''
        if command -v bluetoothctl >/dev/null 2>&1; then
            value=$(timeout 2 bluetoothctl devices Connected 2>/dev/null |
                sed -n '1s/^Device [^ ]* //p')
        fi
        printf '%s\n' "${value:-Not connected}" | escape_text 18
        ;;
    power-value)
        supply=$(battery)
        if [ -n "$supply" ] && [ -r "$supply/capacity" ]; then
            printf '%s%%\n' "$(cat "$supply/capacity")"
        else
            printf '%s\n' 'AC'
        fi
        ;;
    power-status)
        supply=$(battery)
        if [ -n "$supply" ] && [ -r "$supply/status" ]; then
            cat "$supply/status"
        else
            printf '%s\n' 'Desktop power'
        fi
        ;;
    *) exit 1 ;;
esac
