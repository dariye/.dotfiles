set -g fish_greeting

if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl --max-time 10 https://raw.githubusercontent.com/jorgebucaran/fisher/4.4.8/functions/fisher.fish --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

if type -q hx
    alias vim='hx'
    alias vi='hx'
end

set -gx LC_ALL en_GB.UTF-8

fish_add_path $HOME/.local/bin $HOME/go/bin

/opt/homebrew/bin/brew shellenv | source

starship init fish | source
mise activate fish | source
