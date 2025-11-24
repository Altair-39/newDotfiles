#!/bin/bash
options="  Shutdown\n  Reboot\n  Logout\n  Lock\n  Suspend"

choice=$(echo -e "$options" | rofi -dmenu -i -p "   Power Menu:" -theme-str '@import "/home/altair/.config/rofi/lain.rasi"')

case "$choice" in
    *Shutdown)
        dbus-send --system --print-reply --dest=org.freedesktop.login1 /org/freedesktop/login1 org.freedesktop.login1.Manager.PowerOff boolean:false
        ;;
    *Reboot)
        dbus-send --system --print-reply --dest=org.freedesktop.login1 /org/freedesktop/login1 org.freedesktop.login1.Manager.Reboot boolean:false    
        ;;
    *Logout)
        if pgrep -x "i3" > /dev/null; then
            i3-msg exit
        elif pgrep -x "niri" > /dev/null; then
            niri msg action quit
        elif pgrep -x "bspwm" > /dev/null; then
            bspc quit
        fi
        ;;
    *Lock)
        if pgrep -x "i3" > /dev/null; then
            betterlockscreen -l
        elif pgrep -x "niri" > /dev/null; then
            swaylock -i "/home/altair/Pictures/Wallpapers/Vocaloid/Ghost miku 4.jpg"
        elif pgrep -x "bspwm" > /dev/null; then
            # Choose one of these lock commands for bspwm:
            betterlockscreen -l
            # OR
            # swaylock -i "/home/altair/Pictures/Wallpapers/Vocaloid/Ghost miku 4.jpg"
            # OR
            # i3lock  # if you have i3lock installed
        fi
        ;;
    *Suspend)
        loginctl suspend
        ;;
    *)
        echo "No match found" >> $LOGFILE
        ;;
esac
