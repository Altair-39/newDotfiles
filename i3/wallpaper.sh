
#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/.dotfiles/Pictures/Wallpapers"
CURRENT_IMAGE="$HOME/.config/rofi/images/current.jpg"

# Collect images recursively
mapfile -t wallpapers < <(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | sort)
[ ${#wallpapers[@]} -eq 0 ] && { echo "No wallpapers found in $WALLPAPER_DIR"; exit 1; }

# Show basenames in rofi
choices=$(printf "%s\n" "${wallpapers[@]##*/}")
picked=$(echo "$choices" | rofi -dmenu -i -p "Select Wallpaper:")
[ -z "$picked" ] && exit 1

# Map back to full path
for wp in "${wallpapers[@]}"; do
    if [[ "${wp##*/}" == "$picked" ]]; then
        choice="$wp"
        break
    fi
done

# Apply pywal colors (updates terminal & generates color files)
wal -i "$choice" -n --backend wal

# Set wallpaper using swww (Wayland-compatible)
swww img "$choice" --transition-fps 60 --transition-type fade

python3 /home/altair/Repository/telegram-pywal/pallete-gen.py

# Reload Waybar to pick up new colors
pkill -USR2 waybar

# Update Rofi image
cp "$choice" "$CURRENT_IMAGE"

