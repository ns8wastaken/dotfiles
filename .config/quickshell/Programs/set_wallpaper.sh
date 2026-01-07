#!/usr/bin/env bash

set -euo pipefail

show_usage() {
    echo "Usage: $0 -w /path/to/image [-t 'theme_command']"
    exit 1
}

# Parse arguments
wallpaper=""
theme_cmd=""

while getopts "w:t:" opt; do
    case "$opt" in
        w) wallpaper="$OPTARG" ;;
        t) theme_cmd="$OPTARG" ;;
        *) show_usage ;;
    esac
done

# Validate wallpaper
if [[ -z "$wallpaper" ]]; then
    show_usage
fi

if [[ ! -f "$wallpaper" ]]; then
    notify-send -u critical "Wallpaper" "File does not exist: $wallpaper"
    exit 1
fi

# Functions
set_wallpaper() {
    swww img "$wallpaper" \
        --transition-type any \
        --transition-duration 1.5 \
        --transition-step 20 \
        --transition-fps 144
}

generate_theme() {
    if [[ -n "$theme_cmd" ]]; then
        WALLPAPER="$wallpaper" eval "$theme_cmd"
    fi
}

notify_success() {
    notify-send "Wallpaper set" "$wallpaper"
}

notify_failure() {
    local msg="$1"
    notify-send -u critical "Wallpaper" "$msg"
    exit 1
}

# Main
if set_wallpaper; then
    if ! generate_theme; then
        notify_failure "Failed to generate theme"
    fi
    notify_success
else
    notify_failure "swww failed to set the wallpaper"
fi
