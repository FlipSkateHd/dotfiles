#!/bin/bash

# Menu de energia para Waybar usando wofi
# Salve este arquivo como ~/.config/waybar/power-menu.sh e dê permissão de execução com:
# chmod +x ~/.config/waybar/power-menu.sh

entries="Desligar\nReiniciar\nSuspender\nHibernar\nSair\nBloquear"

selected=$(echo -e $entries | wofi --dmenu --cache-file=/dev/null --width=200 --height=250 --prompt="Power Menu" --conf=$HOME/.config/wofi/config --style=$HOME/.config/wofi/style.css)

case $selected in
  Desligar)
    systemctl poweroff
    ;;
  Reiniciar)
    systemctl reboot
    ;;
  Suspender)
    systemctl suspend
    ;;
  Hibernar)
    systemctl hibernate
    ;;
  Sair)
    swaymsg exit
    ;;
  Bloquear)
    swaylock
    ;;
esac
