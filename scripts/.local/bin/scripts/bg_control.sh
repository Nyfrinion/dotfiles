#!/bin/bash

# Map workspaces to background images
declare -A wallpapers
wallpapers["🐠"]="$HOME/Pictures/fish.png"
wallpapers["2"]="$HOME/Pictures/2.jpg"
wallpapers["3"]="$HOME/Pictures/3.jpg"
# Add more as needed

# Listen to workspace changes
i3-msg -t subscribe '[ "workspace" ]' | while read -r line; do
    current_ws=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true).name')
    image="${wallpapers[$current_ws]}"
    [ -n "$image" ] && feh --bg-scale "$image"
done
