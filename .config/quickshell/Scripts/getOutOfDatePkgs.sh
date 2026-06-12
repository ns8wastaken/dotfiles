#!/usr/bin/env bash

if ! repo_output=$(checkupdates --nocolor); then
    echo "-1"
    exit 1
fi

if ! aur_output=$(aur-check-updates --color never); then
    echo "-1"
    exit 1
fi

# Using 'grep -c' on the variable avoids an empty line counting as 1
repo_updates=$(echo "$repo_output" | grep -c '^')
aur_updates=$(echo "$aur_output" | grep -c '^')

total_updates=$((repo_updates + aur_updates))

echo "$total_updates"
