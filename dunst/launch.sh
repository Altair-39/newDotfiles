#!/bin/sh

# Paths
TEMPLATE="$HOME/.config/dunst/dunstrc.template"
DUNST_CONFIG="$HOME/.config/dunst/dunstrc"
PYWAL_COLORS="$HOME/.cache/wal/colors"

# Extract colors
BG=$(sed -n '1p' "$PYWAL_COLORS")       # Background
FG=$(sed -n '2p' "$PYWAL_COLORS")       # Foreground
FRAME=$(sed -n '3p' "$PYWAL_COLORS")    # Frame

# Reset dunstrc from the template
cp "$TEMPLATE" "$DUNST_CONFIG"

# Replace placeholders with actual colors
sed -i "s/PLACEHOLDER_BG/$BG/" "$DUNST_CONFIG"
sed -i "s/PLACEHOLDER_FG/$FG/" "$DUNST_CONFIG"
sed -i "s/PLACEHOLDER_FRAME/$FRAME/" "$DUNST_CONFIG"

# Restart Dunst to apply changes
pkill dunst && dunst &

