#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

source "$ROOT/lib/helpers.sh"
source "$ROOT/lib/detect-distro.sh"

[[ "$DISTRO" == "arch" ]] || exit 0

if command_exists yay; then
    info "yay is already installed."
    exit 0
fi

info "Installing yay..."

sudo pacman -S --needed --noconfirm \
    base-devel \
    git

TEMP_DIR="$(mktemp -d)"

cleanup() {
    rm -rf "$TEMP_DIR"
}

trap cleanup EXIT

git clone \
    https://aur.archlinux.org/yay-bin.git \
    "$TEMP_DIR/yay-bin"

cd "$TEMP_DIR/yay-bin"

makepkg -si --noconfirm

info "yay installed."