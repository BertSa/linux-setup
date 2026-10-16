#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

source "$ROOT/lib/helpers.sh"
source "$ROOT/lib/detect-distro.sh"

info "Installing base packages..."

case "$DISTRO" in
    debian)
        sudo apt update

        sudo apt install -y \
            curl \
            wget \
            tree \
            unzip \
            zip \
            git \
            vlc \
            ca-certificates \
            gnupg
        ;;

    arch)
        sudo pacman -Syu --noconfirm

        sudo pacman -S --needed --noconfirm \
            curl \
            wget \
            tree \
            unzip \
            zip \
            git \
            vlc
        ;;
esac