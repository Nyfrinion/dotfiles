#!/bin/bash

# Map workspaces to background images
declare -A wallpapers
wallpapers["🐠"]="$HOME/resources/wallpapers/fish.png"
wallpapers["🦞"]="$HOME/resources/wallpapers/lobster.png"
wallpapers["🐙"]="$HOME/resources/wallpapers/octopus.png"
wallpapers["🐳"]="$HOME/resources/wallpapers/whale.png"
wallpapers["🪼"]="$HOME/resources/wallpapers/jellyfish.png"
wallpapers["🦈"]="$HOME/resources/wallpapers/shark.png"
# Add more as needed

# Listen to workspace changes
i3-msg -t subscribe '[ "workspace" ]' | while read -r line; do
    current_ws=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true).name')
    image="${wallpapers[$current_ws]}"
    [ -n "$image" ] && feh --bg-scale "$image"
done
