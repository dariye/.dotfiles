set -g fish_greeting

if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://raw.githubusercontent.com/jorgebucaran/fisher/4.4.8/functions/fisher.fish --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

if type hx >/dev/null 2>/dev/null
    alias vim='hx'
    alias vi='hx'
end

set -gx LC_ALL en_GB.UTF-8
set -gx LANG en_GB.UTF-8

# load shell env
eval "$(/opt/homebrew/bin/brew shellenv)"

starship init fish | source
mise activate fish | source

fish_add_path $HOME/.local/bin $HOME/go/bin
