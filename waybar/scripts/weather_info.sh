#!/bin/bash

output=$(curl -s 'https://wttr.in/Itajai?format=%c+%t+%f' 2>/dev/null)

# Separar os valores
icon=$(echo "$output" | awk '{print $1}')
temp=$(echo "$output" | awk '{print $2}')
feels_like=$(echo "$output" | awk '{print $3}')

# Exibe JSON para Waybar
echo "{\"text\":\"${icon}${feels_like}\", \"tooltip\":\"Temperatura atual: ${temp}\", \"class\":\"weather\"}"
