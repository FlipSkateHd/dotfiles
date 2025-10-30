#!/bin/bash

# Obtém o nível de brilho atual (porcentagem)
BRIGHTNESS=$(brightnessctl g)

# Define os ícones e a classe CSS com base no nível
if [ "$BRIGHTNESS" -le 33 ]; then
    ICON="󰃝" # Ícone para brilho baixo (0% - 33%)
    CLASS="low"
elif [ "$BRIGHTNESS" -le 66 ]; then
    ICON="󰃞" # Ícone para brilho médio (34% - 66%)
    CLASS="medium"
else
    ICON="󰃟" # Ícone para brilho alto (67% - 100%)
    CLASS="high"
fi

# Imprime o objeto JSON
# O campo "text" (o ícone) é o que vai aparecer na barra.
# O campo "tooltip" mostrará a porcentagem ao passar o mouse.
# O campo "class" permite estilizar o ícone com CSS (opcional).
echo "{\"text\": \"$ICON\", \"tooltip\": \"Luminosidade: $BRIGHTNESS%\", \"class\": \"$CLASS\"}"
