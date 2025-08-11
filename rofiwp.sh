#!/usr/bin/bash

wall_dir="${HOME}/wallpapers/"
cache_dir="${HOME}/.cache/thumbnails/rofi_wal_selector/"

rofi_config_path="${HOME}/.config/rofi/wallpaper-selector.rasi "
rofi_command="rofi -dmenu -theme ${rofi_config_path}"

set_wp_script="$HOME/setwp.sh"

# Create cache dir if not exists
if [ ! -d "${cache_dir}" ] ; then
    mkdir -p "${cache_dir}"
fi

# Convert images in directory and save to cache dir
for imagen in "$wall_dir"/*.{jpg,jpeg,png,webp}; do
    if [ -f "$imagen" ]; then
        filename=$(basename "$imagen")
        if [ ! -f "${cache_dir}/${filename}" ] ; then
            magick "$imagen" -strip -thumbnail 500x500^ -gravity center -extent 500x500 "$cache_dir/$filename"
        fi
    fi
done

# Select a picture with rofi
wall_selection=$(ls "${wall_dir}" -t | while read -r A ; do
    echo -en "$A\x00icon\x1f""${cache_dir}"/"$A\n" ;
done | $rofi_command)

# Set the wallpaper with waypaper
[[ -n "$wall_selection" ]] || exit 1
$set_wp_script ${wall_dir}${wall_selection}
