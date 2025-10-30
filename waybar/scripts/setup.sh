#!/bin/bash
# Script principal para os módulos personalizados do Waybar
# Salve como ~/.config/waybar/scripts/setup.sh

# Cria o diretório de scripts se não existir
mkdir -p ~/.config/waybar/scripts

# ========================================
# Script para o seletor de cores
# ~/.config/waybar/scripts/colorpicker.sh
# ========================================
cat >~/.config/waybar/scripts/colorpicker.sh <<'EOF'
#!/bin/bash

if [ "$1" = "-j" ]; then
    echo '{"text":"󰴱","tooltip":"Seletor de Cores"}'
else
    # Usa hyprpicker se disponível, senão tenta outras opções
    if command -v hyprpicker > /dev/null; then
        color=$(hyprpicker -a)
        notify-send "Cor copiada!" "Cor $color copiada para área de transferência"
    elif command -v grim > /dev/null && command -v slurp > /dev/null; then
        # Alternativa usando grim + slurp para Wayland
        grim -g "$(slurp -p)" -t ppm - | convert - -format '%[pixel:p{0,0}]' txt:- | tail -n1 | cut -d' ' -f4 | wl-copy
        notify-send "Cor copiada!" "Cor copiada para área de transferência"
    else
        notify-send "Erro" "Nenhuma ferramenta de captura de cor encontrada"
    fi
fi
EOF

# ========================================
# Script para brilho (melhorado)
# ~/.config/waybar/scripts/brightness.sh
# ========================================
cat >~/.config/waybar/scripts/brightness.sh <<'EOF'
#!/bin/bash

get_brightness() {
    if command -v brightnessctl > /dev/null; then
        current=$(brightnessctl get)
        max=$(brightnessctl max)
        percentage=$((current * 100 / max))
        echo $percentage
    else
        echo "50"
    fi
}

get_icon() {
    brightness=$(get_brightness)
    if [ $brightness -le 25 ]; then
        echo "󰃞"
    elif [ $brightness -le 50 ]; then
        echo "󰃟"
    elif [ $brightness -le 75 ]; then
        echo "󰃝"
    else
        echo "󰃠"
    fi
}

if [ "$1" = "-j" ]; then
    brightness=$(get_brightness)
    icon=$(get_icon)
    echo "{\"text\":\"$icon\",\"tooltip\":\"Brilho: $brightness%\"}"
else
    brightness=$(get_brightness)
    icon=$(get_icon)
    echo "$icon $brightness%"
fi
EOF

# ========================================
# Script para informações do sistema
# ~/.config/waybar/scripts/system-info.sh
# ========================================
cat >~/.config/waybar/scripts/system-info.sh <<'EOF'
#!/bin/bash

case "$1" in
    "cpu")
        cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
        echo "󰻠 ${cpu_usage%.*}%"
        ;;
    "memory")
        mem_info=$(free | grep Mem)
        mem_total=$(echo $mem_info | awk '{print $2}')
        mem_used=$(echo $mem_info | awk '{print $3}')
        mem_percent=$((mem_used * 100 / mem_total))
        echo "󰍛 ${mem_percent}%"
        ;;
    "disk")
        disk_usage=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')
        echo "󰋊 ${disk_usage}%"
        ;;
esac
EOF

# ========================================
# Script para clima
# ~/.config/waybar/scripts/weather.sh
# ========================================
cat >~/.config/waybar/scripts/weather.sh <<'EOF'
#!/bin/bash

# Tenta obter informações do clima para Itajaí
if ping -c1 google.com > /dev/null 2>&1; then
    weather=$(curl -s 'https://wttr.in/Itajai?format=%c+%t' 2>/dev/null)
    if [ $? -eq 0 ] && [ -n "$weather" ]; then
        echo "$weather"
    else
        echo "󰖐 N/A"
    fi
else
    echo "󰖐 Offline"
fi
EOF

# Torna todos os scripts executáveis
chmod +x ~/.config/waybar/scripts/*.sh

echo "Scripts criados e configurados!"
echo "Certifique-se de que os seguintes pacotes estão instalados:"
echo "- brightnessctl (para controle de brilho)"
echo "- hyprpicker ou grim+slurp (para seletor de cores)"
echo "- wlogout (para menu de energia)"
echo "- pavucontrol (para controle de áudio)"
