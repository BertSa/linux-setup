#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

source "$ROOT/lib/helpers.sh"
source "$ROOT/lib/detect-distro.sh"

DESKTOP="${XDG_CURRENT_DESKTOP:-}:${XDG_SESSION_DESKTOP:-}"

if [[ "${DESKTOP,,}" != *gnome* ]]; then
    info "GNOME not detected. Skipping GNOME Tweaks."
    exit 0
fi

info "GNOME detected. Installing GNOME Tweaks..."

case "$DISTRO" in
    debian)
        sudo apt install -y gnome-tweaks
        ;;

    arch)
        sudo pacman -S --needed --noconfirm gnome-tweaks
        ;;
esac