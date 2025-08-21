#!/bin/bash

set -euo pipefail

# --- Configuration ---
THRESHOLD_YELLOW=25
THRESHOLD_RED=100

# --- Functions ---
get_update_count() {
    yay -Qu | wc -l
}

determine_class() {
    local -r count=$1
    if (( count == 0 )); then
        echo "transparent"
    elif (( count <= THRESHOLD_YELLOW )); then
        echo "green"
    elif (( count <= THRESHOLD_RED )); then
        echo "yellow"
    else
        echo "red"
    fi
}

output_waybar_json() {
    local -r count=$1
    local -r css_class=$2
    if (( count > 0 )); then
        printf '{"text":"%d","tooltip":"%d packages can be updated","class":"%s"}\n' \
            "$count" "$count" "$css_class"
    else
        printf '{"text":"0","tooltip":"System is up to date","class":"transparent"}\n'
    fi
}

# --- Main ---
updates=$(get_update_count)
css_class=$(determine_class "$updates")
output_waybar_json "$updates" "$css_class"
