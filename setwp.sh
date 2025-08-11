#!/usr/bin/env bash

# Check if argument is given
if [ -z "$1" ]; then
    echo "Usage: setwp.sh /path/to/image"
    exit 1
fi

wallpaper="$1"

# Check if file exists
if [ ! -f "$wallpaper" ]; then
    echo "Error: File does not exist: $wallpaper"
    exit 1
fi

# Set wallpaper with swww
swww img "$wallpaper" \
    --transition-type any \
    --transition-duration 1.5 \
    --transition-step 20 \
    --transition-fps 144 \
    && wal -i "$wallpaper" > /dev/null 2>&1

# Optional: reload apps using pywal colors
killall waybar && nohup waybar > /dev/null 2>&1 & disown

# Optional: send notification
# notify-send "Wallpaper set" "$wallpaper"
