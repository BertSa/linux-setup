#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

source "$ROOT/lib/helpers.sh"
source "$ROOT/lib/detect-distro.sh"

info "Installing Visual Studio Code..."

case "$DISTRO" in
    debian)
        sudo install -d -m 0755 /usr/share/keyrings

        TEMP_KEY="$(mktemp)"
        trap 'rm -f "$TEMP_KEY"' EXIT

        curl -fsSL \
            https://packages.microsoft.com/keys/microsoft.asc \
            | gpg --dearmor > "$TEMP_KEY"

        sudo install \
            -o root \
            -g root \
            -m 644 \
            "$TEMP_KEY" \
            /usr/share/keyrings/packages.microsoft.gpg

        echo \
            "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" \
            | sudo tee /etc/apt/sources.list.d/vscode.list >/dev/null

        sudo apt update
        sudo apt install -y code
        ;;

    arch)
        "$ROOT/install/yay.sh"

        yay -S --needed --noconfirm visual-studio-code-bin
        ;;
esac