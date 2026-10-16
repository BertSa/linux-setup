#!/usr/bin/env bash

[[ -f /etc/os-release ]] || {
    echo "Cannot detect Linux distribution." >&2
    exit 1
}

source /etc/os-release

case "$ID" in
    arch|manjaro|endeavouros|cachyos)
        DISTRO="arch"
        ;;

    debian|ubuntu|pop|linuxmint)
        DISTRO="debian"
        ;;

    *)
        if [[ "${ID_LIKE:-}" == *arch* ]]; then
            DISTRO="arch"
        elif [[ "${ID_LIKE:-}" == *debian* ]] ||
             [[ "${ID_LIKE:-}" == *ubuntu* ]]; then
            DISTRO="debian"
        else
            echo "Unsupported distribution: ${PRETTY_NAME:-$ID}" >&2
            exit 1
        fi
        ;;
esac

export DISTRO