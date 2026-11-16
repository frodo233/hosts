#!/bin/bash
FILE="$HOME/etc/hosts"

while read -r ip rest; do
    # sarim peste linii goale si comentarii
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
