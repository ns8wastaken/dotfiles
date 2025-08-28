if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -U fish_greeting ''

# Config path
set -U XDG_CONFIG_HOME $HOME/.config

set -Ux EDITOR nvim
set -Ux VISUAL nvim

# Path
set -U fish_user_paths $HOME/bin $fish_user_paths
set -U fish_user_paths /var/lib/flatpak/exports/bin $fish_user_paths

starship init fish | source

function transient_prompt_func
    starship module character --status $transient_status
end
