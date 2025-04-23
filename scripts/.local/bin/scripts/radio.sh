#!/bin/bash

# Declare an array of YouTube playlists with labels and colors
playlists=(
    "https://www.youtube.com/playlist?list=PL12345ABCDE|Winter|#ff0000"
    "https://www.youtube.com/playlist?list=PL67890FGHIJ|Jungle|#00ff00"
    "https://www.youtube.com/playlist?list=PL99999ZZZZZ|Hot|#0000ff"
)

index_file="/tmp/radio_index"
playlist_cache="/tmp/radio_playlist_cache"
mpv_socket="/tmp/mpvsocket"

# Initialize index if needed
if [ ! -f "$index_file" ]; then
    echo 0 > "$index_file"
fi

# Refresh playlist cache if missing or empty
if [ ! -s "$playlist_cache" ]; then
    > "$playlist_cache"
    for entry in "${playlists[@]}"; do
        IFS="|" read -r playlist_url title color <<< "$entry"
        yt-dlp --flat-playlist -J "$playlist_url" | jq -r '.entries[].id' | while read -r video_id; do
            echo "https://www.youtube.com/watch?v=$video_id|$title|$color" >> "$playlist_cache"
        done
    done
    # Shuffle the resulting list
    shuf "$playlist_cache" -o "$playlist_cache"
fi

# Load the current index
current_index=$(cat "$index_file")

# Reload if we reached the end of the cache
total_lines=$(wc -l < "$playlist_cache")
if [ "$current_index" -ge "$total_lines" ]; then
    current_index=0
    echo 0 > "$index_file"
fi

# Left click: go to next
if [ "$BLOCK_BUTTON" = "1" ]; then
    next_index=$(( (current_index + 1) % total_lines ))
    echo "$next_index" > "$index_file"
    current_index=$next_index

    # Kill mpv if running
    if pgrep -x "mpv" > /dev/null; then
        pkill -x mpv
        sleep 0.2
    fi
fi

# Get current video info
line=$(sed -n "$((current_index + 1))p" "$playlist_cache")
video_url=$(echo "$line" | cut -d'|' -f1)
title=$(echo "$line" | cut -d'|' -f2)
color=$(echo "$line" | cut -d'|' -f3)

# Start MPV if not running
if ! pgrep -x "mpv" > /dev/null; then
    mpv --no-video --title="$title" "$video_url" --input-ipc-server="$mpv_socket" &>/dev/null &
fi

# Output for i3blocks
echo "$title"
echo
echo "$color"
