#!/bin/bash
# Define wallpaper paths
WALLPAPERS=(
    "/home/$USER/Immagini/Wallpapers/Vocaloid/Miku9.jpg"
    "/home/$USER/Immagini/Wallpapers/Vocaloid/Miku11.jpg"
    "/home/$USER/Immagini/Wallpapers/Pokemon/Eeveelutions.png"
    "/home/$USER/Immagini/Wallpapers/Pokemon/Glaceon.jpg"
    "/home/$USER/Immagini/Wallpapers/Vocaloid/Kaito3.jpeg"
    "/home/$USER/Immagini/Wallpapers/Vocaloid/Kaito.jpg"
    "/home/$USER/Immagini/Wallpapers/Vocaloid/Miku6.jpg"
    "/home/$USER/Immagini/Wallpapers/Vocaloid/Kaito2.jpg"
    "/home/$USER/Immagini/Wallpapers/Vocaloid/Miku8.jpg"
    "/home/$USER/Immagini/Wallpapers/Programming/rust.png"
    "/home/$USER/Immagini/Wallpapers/Vocaloid/Miku10.jpg"
)

# Set the wallpaper and apply pywal for the current workspace
set_wallpaper() {
    local workspace="$1"
    local wallpaper="${WALLPAPERS[$((workspace-1))]}"
    feh --bg-fill "$wallpaper" # Set the wallpaper
    nvim @wezterm-cmd{"ok": false, "error": "'NoneType' object has no attribute 'get'"} 2>/dev/null
    wal -i "$wallpaper"         # Generate pywal theme
}

# Hook to workspace change
ws_change() {
    workspace="$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true).num')"
    set_wallpaper "$workspace"
}

cat ~/.cache/wal/wezterm.conf >> ~/.config/wezterm/wezterm.conf

# Run on startup
ws_change

