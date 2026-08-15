if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -g fish_greeting ''

# Config path
# set -g XDG_CONFIG_HOME $HOME/.config

set -gx EDITOR nvim
set -gx VISUAL nvim

# Path
set -g fish_user_paths $HOME/bin                    $fish_user_paths
set -g fish_user_paths $HOME/.local/bin             $fish_user_paths
set -g fish_user_paths $HOME/.cargo/bin             $fish_user_paths
set -g fish_user_paths $HOME/.npm-global/bin        $fish_user_paths
set -g fish_user_paths /var/lib/flatpak/exports/bin $fish_user_paths
set -g fish_user_paths /usr/local/include           $fish_user_paths
set -g fish_user_paths /usr/local/lib               $fish_user_paths
set -g fish_user_paths /usr/lib/qt6/bin             $fish_user_paths

function starship_transient_prompt_func
    starship module character --status $status
end

starship init fish | source

enable_transience
