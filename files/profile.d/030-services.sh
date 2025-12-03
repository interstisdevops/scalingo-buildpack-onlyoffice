#!/usr/bin/env bash

start_service() {
    local name=$1
    local cmd=$2

    echo "Starting $name"
    $cmd &
}

ensure_service() {
    local name=$1
    local cmd=$2
    local pattern=$3   # optionnel, pour pgrep

    pattern=${pattern:-$cmd}

    while true; do
        sleep 30
        if ! pgrep -f "$pattern" >/dev/null; then
            echo "$name does not seem to be running. Respawning."
            start_service "$name" "$cmd"
        fi
    done &
}

# Only start OnlyOffice services if conditions are OK
# `_OO_START` is computed in 020-onlyoffice.sh

if [ "${_OO_START}" -eq 0 ]; then
    case "${ONLYOFFICE_MODE}" in
        docservice)
            echo "Starting ONLYOFFICE Document Service..."
            ensure_service "OnlyOffice DocService" "/app/server/DocService/docservice"
            ;;
        fileconverter)
            echo "Starting ONLYOFFICE File Converter..."
            ensure_service "OnlyOffice FileConverter" "/app/server/FileConverter/converter"
            ;;
        proxy)
            echo "Starting ONLYOFFICE Proxy..."
            ensure_service "OnlyOffice Proxy" "/app/server/Proxy/proxy"
            ;;
        *)
            echo "[WARNING] Unknown or undefined ONLYOFFICE_MODE: '${ONLYOFFICE_MODE}'"
            echo "Valid values: docservice | fileconverter | proxy"
            ;;
    esac
fi
