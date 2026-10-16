#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

source "$ROOT/lib/helpers.sh"
source "$ROOT/lib/detect-distro.sh"

info "Installing Brave..."

case "$DISTRO" in
    debian)
        sudo install -d -m 0755 /usr/share/keyrings

        sudo curl -fsSLo \
            /usr/share/keyrings/brave-browser-archive-keyring.gpg \
            https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

        echo \
            "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" \
            | sudo tee /etc/apt/sources.list.d/brave-browser-release.list >/dev/null

        sudo apt update
        sudo apt install -y brave-browser
        ;;

    arch)
        "$ROOT/install/yay.sh"

        yay -S --needed --noconfirm brave-bin
        ;;
esac