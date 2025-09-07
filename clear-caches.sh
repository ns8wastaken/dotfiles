#!/usr/bin/env bash

set -euo pipefail

echo "🧹 Clearing caches..."

# Pacman package cache
if command -v pacman >/dev/null 2>&1; then
    sudo pacman -Scc --noconfirm
    echo " - Pacman cache cleared"
fi

# Yay/AUR helper cache
if command -v yay >/dev/null 2>&1; then
    yay -Scc --noconfirm
    echo " - Yay cache cleared"
fi

# Pip cache
if command -v python >/dev/null 2>&1; then
    python -m pip cache purge || true
    echo " - Pip cache cleared"
fi

# Npm cache
if command -v npm >/dev/null 2>&1; then
    npm cache clean --force
    echo " - NPM cache cleared"
fi

# Cargo (Rust) cache
if command -v cargo >/dev/null 2>&1; then
    cargo cache -a > /dev/null 2>&1 || true
    echo " - Cargo cache cleared"
fi

# Systemd journal (system-wide)
if command -v journalctl >/dev/null 2>&1; then
    sudo journalctl --vacuum-time=1d
    echo " - System journal cleared (kept 1 day)"
fi

# Systemd journal (user)
if systemctl --user >/dev/null 2>&1; then
    journalctl --user --vacuum-time=1d
    echo " - User journal cleared (kept 1 day)"
fi

echo "✅ All supported caches cleared!"
