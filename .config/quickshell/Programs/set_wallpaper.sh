#!/bin/bash

# Check if argument is given
if [ -z "$1" ]; then
    echo "Usage: setwp.sh /path/to/image"
    exit 1
fi

wallpaper="$1"

# Check if file exists
if [ ! -f "$wallpaper" ]; then
    notify-send -u critical "Wallpaper" "File does not exist: $wallpaper"
    exit 0
fi

set_wallpaper() {
    swww img "$wallpaper" \
      --transition-type any \
      --transition-duration 1.5 \
      --transition-step 20 \
      --transition-fps 144
}

generate_theme() {
    wallust run "$wallpaper" -u -q #--check-contrast
}

# Set wallpaper with swww
if set_wallpaper; then
    if ! generate_theme; then
        notify-send -u critical "Wallpaper" "Failed to generate wallust palette"
        exit 1
    fi
else
    notify-send -u critical "Wallpaper" "swww failed to set the wallpaper"
    exit 1
fi

# Optional: send notification
notify-send "Wallpaper set" "$wallpaper"
