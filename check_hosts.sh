#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Utilizare: $0 <fisier_hosts>" >&2
    exit 1
fi

FILE="$1"

if [ ! -f "$FILE" ]; then
    echo "Eroare: fisierul '$FILE' nu exista." >&2
    exit 2
fi

while read -r ip rest; do
    [[ -z "$ip" || "$ip" == \#* ]] && continue

    valid=1
    if [[ $ip =~ ^([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})$ ]]; then
        for octet in "${BASH_REMATCH[@]:1}"; do
            (( 10#$octet > 255 )) && valid=0
        done
    else
        valid=0
    fi

    if (( valid )); then
        echo "$ip - valida"
    else
        echo "$ip - INVALIDA"
    fi
done < "$FILE"
