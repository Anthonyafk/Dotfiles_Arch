#!/usr/bin/env bash

wallpaper_path=$(readlink "$HOME/.current_wallpaper")

check_file() {
  if [ ! -f "$1" ]; then
    echo "File $1 not found!"
    exit 1
  fi
}

check_file "$wallpaper_path"

# Si no le pasamos argumentos, ejecuta wal normalmente
if [ $# -eq 0 ]; then
    wal -i "$wallpaper_path"
    exit 0
fi

# Si sí hay argumentos, entra al ciclo
for opt in "$@"; do
  case "$opt" in
      no-tty)
        # Do not change terminal colors
        sleep 0.2
        wal -i "$wallpaper_path" -s -t
      ;;
      *)
        sleep 0.2
        wal -i "$wallpaper_path"
      ;;
  esac
done
