#!/usr/bin/env bash
## /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Script para seleccionar wallpapers estáticos (SUPER Q)

# Rutas
wallpaperDir="$HOME/Pictures/wallpapers"
themesDir="$HOME/.config/rofi/themes"
scriptsDir="$HOME/.config/hypr/scripts"

# Configuración de transición para awww
FPS=60
TYPE="any"
DURATION=3
BEZIER="0.4,0.2,0.4,1.0"
AWWW_PARAMS="--transition-fps ${FPS} --transition-type ${TYPE} --transition-duration ${DURATION} --transition-bezier ${BEZIER}"

# 1. Matar swaybg si está corriendo
if pidof swaybg > /dev/null; then
  pkill swaybg
fi

# 2. Matar mpvpaper si hay un fondo animado corriendo (¡El fix de los dos mundos!)
if pidof mpvpaper > /dev/null; then
  pkill mpvpaper
fi

# Obtener imágenes
PICS=($(find -L "${wallpaperDir}" -type f \( -iname \*.jpg -o -iname \*.jpeg -o -iname \*.png -o -iname \*.gif \) | sort ))

# Variables aleatorias
randomNumber=$(( ($(date +%s) + RANDOM) + $$ ))
randomPicture="${PICS[$(( randomNumber % ${#PICS[@]} ))]}"
randomChoice="[${#PICS[@]}] Random"

# Comando de Rofi
rofiCommand="rofi -show -dmenu -theme ${themesDir}/wallpaper-select.rasi"

# Función para aplicar el fondo y los colores
executeCommand() {
  if command -v awww &>/dev/null; then
    awww img "$1" ${AWWW_PARAMS}
  elif command -v swaybg &>/dev/null; then
    swaybg -i "$1" &
  else
    echo "Ni awww ni swaybg están instalados."
    exit 1
  fi

  # Guardar la ruta del wallpaper actual
  ln -sf "$1" "$HOME/.current_wallpaper"

  # 3. ¡La magia de Pywal! Extraer colores y refrescar la interfaz
  sleep 0.5 # Pequeña pausa para asegurar que el archivo se enlazó
  "${scriptsDir}/pywal.sh"
  "${scriptsDir}/refresh.sh"
}

# Mostrar el menú
menu() {
  printf "$randomChoice\n"
  for i in "${!PICS[@]}"; do
    if [[ -z $(echo "${PICS[$i]}" | grep .gif$) ]]; then
      printf "$(basename "${PICS[$i]}" | cut -d. -f1)\x00icon\x1f${PICS[$i]}\n"
    else
      printf "$(basename "${PICS[$i]}")\n"
    fi
  done
}

# Iniciar el demonio si por alguna razón no estaba
if command -v awww &>/dev/null; then
  awww query || awww init
fi

# Ejecución principal
main() {
  choice=$(menu | ${rofiCommand})

  if [[ -z $choice ]]; then
    exit 0
  fi

  if [ "$choice" = "$randomChoice" ]; then
    executeCommand "${randomPicture}"
    return 0
  fi

  for file in "${PICS[@]}"; do
    if [[ "$(basename "$file" | cut -d. -f1)" = "$choice" ]]; then
      selectedFile="$file"
      break
    fi
  done

  if [[ -n "$selectedFile" ]]; then
    executeCommand "${selectedFile}"
    return 0
  else
    echo "Imagen no encontrada."
    exit 1
  fi
}

# Evitar múltiples instancias de Rofi
if pidof rofi > /dev/null; then
  pkill rofi
  exit 0
fi

main
