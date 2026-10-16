#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

source "$ROOT/lib/helpers.sh"
source "$ROOT/lib/detect-distro.sh"

info "Installing development tools..."

case "$DISTRO" in
    debian)
        sudo apt install -y \
            python3 \
            python3-pip \
            python3-venv \
            default-jdk \
            build-essential
        ;;

    arch)
        sudo pacman -S --needed --noconfirm \
            python \
            python-pip \
            jdk-openjdk \
            base-devel
        ;;
esac