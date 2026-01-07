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

is_installed() {
    pacman -Qi "$1" &> /dev/null
    return $?
}

install_uninstalled() {
    local packages=("$@")  # Accept package names as arguments

    for package in "${packages[@]}"; do
        if ! is_installed "$package"; then
            $INSTALL "$package"
        fi
    done
}


if ! is_installed "yay"; then
    echo "=========================================="
    echo "   Installing yay (Yet Another Yaourt)    "
    echo "=========================================="

    sudo pacman -S --needed git base-devel
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si

    # Clean up (optional)
    cd ..
    rm -rf yay
fi


echo "=========================================="
echo "         Installing core packages         "
echo "=========================================="

install_uninstalled \
    "swww" \
    "waybar" \
    "wlogout" \
    "neovim" \
    "kitty" \
    "rofi" \
    "python-pywal" \
    "fish" \
    "fastfetch" \
    "grimblast" \
    "hyprpicker" \
    "starship"


echo "=========================================="
echo "     Installing other wanted packages     "
echo "=========================================="

install_uninstalled \
    "man-db" \
    "7zip" \
    "ncdu" \
    "tree" \
    "btop" \
    "fd" \
    "ripgrep" \
    "blueman" \
    "copyq" \
    "nwg-look" \
    "vesktop" \
    "zen-browser-bin" \
    "speedcrunch"


echo "=========================================="
echo "         Installing optional packages         "
echo "=========================================="

if ! is_installed "keepassxc"; then
    if confirm "Install KeepassXC?"; then
        $INSTALL "keepassxc"
    fi
fi

if ! is_installed "spotify-launcher"; then
    if confirm "Install Spotify?"; then
        $INSTALL "spotify-launcher"
    fi
fi

if ! is_installed "steam-native-runtime"; then
    if confirm "Install Steam?"; then
        # # Uncomment [multilib] and its Include line in /etc/pacman.conf
        # sudo sed -i '/^\s*#\[multilib\]/s/^#//' /etc/pacman.conf
        # sudo sed -i '/^\s*#Include = \/etc\/pacman.d\/mirrorlist/s/^#//' /etc/pacman.conf
        #
        # # Update package databases
        # yay -Sy

        $INSTALL "steam-native-runtime"
    fi
fi

if ! is_installed "prismlauncher"; then
    if confirm "Install PrismLauncher (Minecraft)"; then
        $INSTALL "prismlauncher"
    fi
fi

if ! is_installed "heroic-games-launcher"; then
    if confirm "Install HeroicGames Launcher (GOG + Epic Games)"; then
        $INSTALL "heroic-games-launcher"
    fi
fi

if ! is_installed "qbittorrent"; then
    if confirm "Install QBittorrent"; then
        $INSTALL "qbittorrent"
    fi
fi

echo "=========================================="
echo "         Installation Complete!           "
echo "=========================================="
