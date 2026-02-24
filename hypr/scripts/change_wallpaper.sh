#!/bin/bash
# Script para cambiar wallpapers con mpvpaper 

# Carpeta de wallpapers
WP_DIR="$HOME/Documents/Wallpapers"

# Lista de wallpapers
WALLPAPERS=(
    "$WP_DIR/Anime_Girl.mp4"
    "$WP_DIR/chainsaw-man-girls-moewalls-com.mp4"
    "$WP_DIR/falling-upside-down-neon-city-spiderman-into-the-spiderverse-moewalls-com.mp4"
    "$WP_DIR/Frieren in The Field.mp4"
    "$WP_DIR/Rem live.mp4"
    "$WP_DIR/Hatsune Miku in System Error Bloom Live.mp4"
    "$WP_DIR/hu-tao-smiling-genshin-impact-moewalls-com.mp4"
)

# Archivo para almacenar la posición actual
STATE_FILE="$HOME/.config/hypr/scripts/current_wp.txt"

# Inicializar si no existe
if [ ! -f "$STATE_FILE" ]; then
    echo 0 > "$STATE_FILE"
fi

# Leer el índice actual
INDEX=$(cat "$STATE_FILE")

# Si INDEX es igual al número de wallpapers, apagamos mpvpaper
if [ "$INDEX" -ge "${#WALLPAPERS[@]}" ]; then
    pkill mpvpaper
    echo 0 > "$STATE_FILE"  # Reinicia para la próxima pulsación
    exit 0
fi

# Cambiar wallpaper
pkill mpvpaper
mpvpaper -o "no-audio loop" eDP-1 "${WALLPAPERS[$INDEX]}" &

# Actualizar índice
INDEX=$((INDEX + 1))
echo $INDEX > "$STATE_FILE"

