#!/bin/bash

# Exit immediately if any command fails
set -e

INSTALL="yay -S --needed --noconfirm"

# Function to prompt the user with a yes/no question
confirm() {
    local prompt="$1"
    local answer
    while true; do
        read -p "$prompt (y/n) " answer
        case "$answer" in
            [Yy]* ) return 0 ;;  # yes → return success
            [Nn]* ) return 1 ;;  # no → return failure
            * ) echo "Please answer y or n." ;;
        esac
    done
}


# Colors
RESET="\e[0m"
CYAN="\e[36m"


echo "=========================================="
echo "   Installing yay (Yet Another Yaourt)    "
echo "=========================================="

sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay-bin.git
cd yay
makepkg -si

# Clean up (optional)
cd ..
rm -rf yay


echo "=========================================="
echo "         Installing core packages         "
echo "          ${CYAN}(swww, waybar, wlogout,         "
echo "         neovim, kitty, rofi, wal,        "
echo "           fish, fastfetch, fd,           "
echo "         ripgrep, blueman, copyq)${RESET}         "
echo "=========================================="

$INSTALL swww waybar wlogout neovim kitty rofi wal fish fastfetch fd ripgrep blueman copyq


echo "=========================================="
echo "           Installing sharship            "
echo "=========================================="

curl -sS https://starship.rs/install.sh | sh


echo "=========================================="
echo "     Installing other wanted packages     "
echo "     ${CYAN}(vesktop, zen-browser, nwg-look,     "
echo "         speedcrunch, ncdu, tree)${RESET}         "
echo "=========================================="

$INSTALL vesktop zen-browser nwg-look speedcrunch \
    ncdu tree


echo "=========================================="
echo "         Installing optional packages         "
echo "=========================================="

if confirm "Install KeepassXC?"; then
    $INSTALL keepassxc
fi

if confirm "Install Spotify?"; then
    $INSTALL spotify-launcher
fi

if confirm "Install Steam?"; then
    # Uncomment [multilib] and its Include line in /etc/pacman.conf
    sudo sed -i '/^\s*#\[multilib\]/s/^#//' /etc/pacman.conf
    sudo sed -i '/^\s*#Include = \/etc\/pacman.d\/mirrorlist/s/^#//' /etc/pacman.conf

    # Update package databases
    yay -Sy

    $INSTALL steam-native-runtime
fi

if confirm "Install PrismLauncher (Minecraft)"; then
    $INSTALL prismlauncher
fi

if confirm "Install HeroicGames Launcher (GOG + Epic Games)"; then
    $INSTALL heroic-games-launcher
fi

if confirm "Install QBittorrent"; then
    $INSTALL qbittorrent
fi
