if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

if type nvim >/dev/null 2>/dev/null
  alias vim='nvim'
  alias vi='nvim'
end

set -gx LC_ALL en_GB.UTF-8 
set -gx LANG en_GB.UTF-8 


eval "$(/opt/homebrew/bin/brew shellenv)"

starship init fish | source
