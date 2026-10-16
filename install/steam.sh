#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

source "$ROOT/lib/helpers.sh"
source "$ROOT/lib/detect-distro.sh"

info "Installing Steam..."

case "$DISTRO" in
    debian)
        if sudo apt install -y steam-installer; then
            exit 0
        fi

        if sudo apt install -y steam; then
            exit 0
        fi

        error "Steam package unavailable. You may need to enable your distro's non-free/multiverse repository."
        ;;

    arch)
        if ! sudo pacman -S --needed --noconfirm steam; then
            error "Steam installation failed. Check that the multilib repository is enabled."
        fi
        ;;
esac