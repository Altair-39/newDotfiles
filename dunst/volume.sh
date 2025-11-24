#!/bin/bash

# You can call this script like this:
# $./volume.sh up
# $./volume.sh down
# $./volume.sh mute

function get_volume {
    pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d{1,3}(?=%)' | head -1
}

function is_mute {
    pactl get-sink-mute @DEFAULT_SINK@ | grep -q 'yes'
}

function send_notification {
    volume=$(get_volume)
    # Make the bar with the special character ─ (it's not dash -)
    # https://en.wikipedia.org/wiki/Box-drawing_character
    bar=$(seq -s "─" $(($volume / 5)) | sed 's/[0-9]//g')
    # Send the notification
     dunstify -h string:x-canonical-private-synchronous:audio "Volume: " -h int:value:"`ponymix get-volume`"

}

case $1 in
    up)
        # Up the volume (+ 5%)
        pactl set-sink-volume @DEFAULT_SINK@ +5%
        send_notification
        ;;
    down)
        # Down the volume (- 5%)
        pactl set-sink-volume @DEFAULT_SINK@ -5%
        send_notification
        ;;
    mute)
        # Toggle mute
        pactl set-sink-mute @DEFAULT_SINK@ toggle
        if is_mute; then
             dunstify -h string:x-canonical-private-synchronous:audio "Volume: " -h int:value:"0"    
        else
            send_notification
        fi
        ;;
    *)
        echo "Usage: $0 {up|down|mute}"
        exit 1
        ;;
esac

