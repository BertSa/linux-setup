#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$ROOT/lib/helpers.sh"
source "$ROOT/lib/detect-distro.sh"

INSTALLERS=(
    base
    development
    gnome
    discord
    steam
    brave
    vscode
    spotify
)

list_installers() {
    echo
    echo "Available installers:"
    echo

    for installer in "${INSTALLERS[@]}"; do
        echo "  $installer"
    done

    echo
}

installer_exists() {
    local requested="$1"

    for installer in "${INSTALLERS[@]}"; do
        if [[ "$installer" == "$requested" ]]; then
            return 0
        fi
    done

    return 1
}

run_installer() {
    local installer="$1"
    local script="$ROOT/install/$installer.sh"

    installer_exists "$installer" ||
        error "Unknown installer: $installer"

    [[ -f "$script" ]] ||
        error "Missing installer: $script"

    info "Running $installer..."

    bash "$script"
}

# ------------------------------------------------------------
# Arguments
# ------------------------------------------------------------

if [[ "${1:-}" == "--list" ]]; then
    list_installers
    exit 0
fi

info "Linux Setup"
info "Detected ${PRETTY_NAME:-$ID}"

# No arguments = install everything
if [[ "$#" -eq 0 ]]; then

    for installer in "${INSTALLERS[@]}"; do
        run_installer "$installer"
    done

else

    for installer in "$@"; do
        run_installer "$installer"
    done

fi

echo
echo "========================================"
echo "          SETUP COMPLETE"
echo "========================================"
echo