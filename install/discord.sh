#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

source "$ROOT/lib/helpers.sh"
source "$ROOT/lib/detect-distro.sh"

info "Installing Discord..."

case "$DISTRO" in
    debian)
        TEMP_DEB="$(mktemp --suffix=.deb)"
        trap 'rm -f "$TEMP_DEB"' EXIT

        wget \
            -O "$TEMP_DEB" \
            "https://discord.com/api/download?platform=linux&format=deb"

        sudo apt install -y "$TEMP_DEB"
        ;;

    arch)
        sudo pacman -S --needed --noconfirm discord
        ;;
esac