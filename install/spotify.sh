#!/usr/bin/env bash

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

source "$ROOT/lib/helpers.sh"
source "$ROOT/lib/detect-distro.sh"

info "Installing Spotify..."

case "$DISTRO" in

    debian)

        # Make sure required tools are installed
        sudo apt install -y \
            curl \
            gnupg \
            ca-certificates

        info "Adding Spotify signing key..."

        curl -sS \
            https://download.spotify.com/debian/pubkey_5384CE82BA52C83A.asc \
            | sudo gpg \
                --dearmor \
                --yes \
                -o /etc/apt/trusted.gpg.d/spotify.gpg

        info "Adding Spotify repository..."

        echo "deb https://repository.spotify.com stable non-free" \
            | sudo tee \
                /etc/apt/sources.list.d/spotify.list \
                >/dev/null

        info "Updating package database..."

        sudo apt-get update

        info "Installing Spotify..."

        sudo apt-get install -y spotify-client

        ;;

    arch)

        # Ensure yay exists
        "$ROOT/install/yay.sh"

        info "Installing Spotify from the AUR..."

        yay -S --needed --noconfirm spotify

        ;;

esac

info "Spotify installed."