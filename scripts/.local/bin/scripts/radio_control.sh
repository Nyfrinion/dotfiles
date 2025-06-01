#!/bin/bash

mpv_socket="/tmp/mpvsocket"

# Default emoji
emoji="❌"

# Toggle pause on click
if [ "$BLOCK_BUTTON" = "1" ]; then
    if [ -S "$mpv_socket" ]; then
        echo '{ "command": ["cycle", "pause"] }' | socat - "$mpv_socket" &>/dev/null
    fi
fi

# Check if mpv is running and connected
if [ -S "$mpv_socket" ]; then
    status=$(echo '{ "command": ["get_property", "pause"] }' | socat - "$mpv_socket" 2>/dev/null)
    if [[ "$status" == *'"data":false'* ]]; then
        emoji="🎵"
    elif [[ "$status" == *'"data":true'* ]]; then
        emoji="⏸️"
    fi
fi

# i3blocks output
echo "$emoji"
echo
echo "#ffffff"

