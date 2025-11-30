#!/bin/bash

RESET="\e[0m"
AZUL="\e[44m"
VERMELHO="\e[31m"
NEGRITO="\e[1m"

echo -e "${VERMELHO}#################################################################${RESET}"
echo -e "${VERMELHO}#${RESET}${NEGRITO}		             DNSZONE		                ${RESET}${VERMELHO}#${RESET}"
echo -e "${VERMELHO}#################################################################${RESET}"

# Verifica se passou parâmetro
if [ -z "$1" ]; then
    echo -e "${VERMELHO}Uso: $0 dominio.com${RESET}"
    exit 1
fi

DNS="$1"

# Regex p/ validar formato de domínio
DNS_REGEX="^([a-zA-Z0-9]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?\.)+[a-zA-Z]{2,}$"

if [[ $DNS =~ $DNS_REGEX ]]; then
    # Obtém servidores NS
    for SERVER in $(host -t ns "$DNS" | awk '{print $4}'); do
        host -l -a "$DNS" "$SERVER"
    done
else
    echo ""
    echo -e "${NEGRITO}NÃO APARENTA SER UM DNS${RESET}"
    exit 1
fi
