#!/usr/bin/env fish

# Check if argument is given
if not set -q argv[1]
    echo "Usage: setwp.fish /path/to/image"
    exit 1
end

set wallpaper $argv[1]

# Check if file exists
if not test -f $wallpaper
    echo "Error: File does not exist: $wallpaper"
    exit 1
end

# Set wallpaper with swww
swww img "$wallpaper" --transition-type any --transition-duration 1.5 --transition-step 20 --transition-fps 144 \
    | wal -i "$wallpaper" \
    > /dev/null 2>&1 &

# Optional: reload apps using pywal colors
killall waybar ; nohup waybar > /dev/null 2>&1 & disown

# Optional: send notification
# notify-send "Wallpaper set" "$wallpaper"
