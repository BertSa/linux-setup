#!/usr/bin/env bash

info() {
    printf '\n\033[1;34m==>\033[0m %s\n' "$1"
}

warn() {
    printf '\n\033[1;33mWARNING:\033[0m %s\n' "$1"
}

error() {
    printf '\n\033[1;31mERROR:\033[0m %s\n' "$1" >&2
    exit 1
}

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

if [[ "${EUID:-$(id -u)}" -eq 0 ]]; then
    error "Run this script as your normal user, not root."
fi

command_exists sudo || error "sudo is required."