#!/bin/bash

# Declare an array of YouTube links, titles, and colors
videos=(
    "https://www.youtube.com/watch?v=FFrNhHd347Q&t=47s|Winter|#ff0000"
    "https://www.youtube.com/watch?v=S9PIF2Acjhw&t=1411s|Jungle|#00ff00"
    "https://www.youtube.com/watch?v=HCbl0VfxtbA|Hot|#0000ff"
)

index_file="/tmp/radio_index"
mpv_socket="/tmp/mpvsocket"

# If index file doesn't exist, initialize to 0
if [ ! -f "$index_file" ]; then
    echo 0 > "$index_file"
fi

# Read current index
current_index=$(cat "$index_file")

# If left click (BLOCK_BUTTON=1), update index and restart MPV
if [ "$BLOCK_BUTTON" = "1" ]; then
    next_index=$(( (current_index + 1) % ${#videos[@]} ))
    echo "$next_index" > "$index_file"
    current_index=$next_index

    # Stop any running mpv instance
    if pgrep -x "mpv" > /dev/null; then
        pkill -x mpv
        sleep 0.2
    fi
fi

# Extract video info
selected_video=${videos[$current_index]}
video_url=$(echo "$selected_video" | cut -d'|' -f1)
title=$(echo "$selected_video" | cut -d'|' -f2)
color=$(echo "$selected_video" | cut -d'|' -f3)

# Start mpv if not running
if ! pgrep -x "mpv" > /dev/null; then
    mpv --no-video --title="$title" "$video_url" --input-ipc-server="$mpv_socket" &>/dev/null &
fi

# Output for i3blocks
echo "$title"
echo
echo "$color"

