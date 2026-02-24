#!/bin/bash
# Cambia el wallpaper animado según el workspace actual

# Carpeta de wallpapers
WP_DIR="$HOME/Downloads/Wallpapers"

# Define wallpapers por workspace (workspace index empieza en 1)
declare -A WALLPAPERS
WALLPAPERS[1]="$WP_DIR/Anime_Girl.mp4"
WALLPAPERS[2]="$WP_DIR/chainsaw-man-girls-moewalls-com.mp4"
WALLPAPERS[3]="$WP_DIR/falling-upside-down-neon-city-spiderman-into-the-spiderverse-moewalls-com.mp4"
WALLPAPERS[4]="$WP_DIR/Solo Leveling Monarch Shadows 2 Prob4.mp4"

# Detecta workspace actual
CURRENT_WS=$(hyprctl activeworkspace -j | jq -r '.id')

# Si existe wallpaper para ese workspace, lo aplica
if [[ -n "${WALLPAPERS[$CURRENT_WS]}" ]]; then
    pkill mpvpaper
    mpvpaper -o "no-audio loop" eDP-1 "${WALLPAPERS[$CURRENT_WS]}" &
fi
