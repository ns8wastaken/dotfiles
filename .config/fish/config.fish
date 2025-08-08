if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -U fish_greeting ''

set -x XDG_DATA_DIRS /usr/local/share /usr/share
set -x XDG_DATA_HOME $HOME/.local/share

# Config path
set -U XDG_CONFIG_HOME $HOME/.config

set -x QT_QPA_PLATFORMTHEME qt5ct

starship init fish | source
