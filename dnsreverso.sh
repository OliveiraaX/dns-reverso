#!/bin/bash

RESET="\e[0m"
AZUL="\e[44m"
VERMELHO="\e[31m"
NEGRITO="\e[1m"

echo -e "${VERMELHO}#######################################################################${RESET}"
echo -e "${VERMELHO}#${RESET}${NEGRITO}                      	     DNS_REVERSO                              ${RESET}${VERMELHO}#${RESET}"
echo -e "${VERMELHO}#######################################################################${RESET}"

# Verifica se passou parâmetro
if [ -z "$1" ]; then
    echo ""
    echo -e "${NEGRITO}Uso:${RESET} ${VERMELHO}$0 127.0.0.1${RESET}"
    exit 1
fi

IP="$1"

# Regex para validar IP
IP_REGEX="^((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])\.){3}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])$"

if [[ $IP =~ $IP_REGEX ]]; then

    # Linha do whois
    inetnum=$(whois "$IP" | grep -m1 inetnum)

    if [ -z "$inetnum" ]; then
        echo ""
        echo "Nenhum range (inetnum) encontrado no WHOIS."
        exit 1
    fi

    # Extrai TODOS os IPs da linha
    ips=($(echo "$inetnum" | grep -oE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+'))

    echo ""
    echo -e "${NEGRITO}Range encontrado:${RESET}"
    echo ""
    echo -e "${NEGRITO}$inetnum${RESET}"
    echo ""
    echo "----------------------------------------------------------------------"

    # Pega o primeiro e o último IP do range
    ip_inicio=${ips[0]}
    ip_fim=${ips[-1]}

    # Últimos octetos
    inicio=$(echo "$ip_inicio" | cut -d '.' -f4)
    fim=$(echo "$ip_fim" | cut -d '.' -f4)

    # Prefixo (primeiros 3 octetos)
    prefixo=$(echo "$ip_inicio" | cut -d '.' -f1-3)
    # Todos os IPs do range
    echo ""

    resultado=$(for range in $(seq "$inicio" "$fim"); do
	host -t ptr "$prefixo.$range"
    done)
    echo "$resultado"
else
    echo ""
    echo -e "${NEGRITO}NÃO APARENTA SER UM IP${RESET}"
    exit 1
fi
