#!/usr/bin/fish

dotfiles add \
    ~/dotfiles_refresh.fish \
    ~/setwp.sh \
    ~/clear-caches.sh \
    ~/install-script.sh \
    ~/.config/nvim/ \
    ~/.config/hypr/ \
    ~/.config/kitty/ \
    ~/.local/share/fastfetch/ \
    ~/.config/fish/ \
    ~/.config/starship.toml \
    ~/.config/quickshell/ \
    ~/.config/wallust/

dotfiles restore --staged \
    ~/.config/nvim/lazy-lock.json \
    ~/.config/fish/fish_variables
