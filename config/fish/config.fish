set -U fish_greeting

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


# asdf
source ~/.asdf/asdf.fish

eval "$(/opt/homebrew/bin/brew shellenv)"


source /Users/paul.dariye/workspace/pleo/bin/oo.fish

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# Created by `pipx` on 2024-07-26 14:07:26
set PATH $PATH /Users/paul.dariye/.local/bin

# pnpm
set -gx PNPM_HOME "/Users/paul.dariye/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# Base16 Shell
if status --is-interactive
    set BASE16_SHELL "$HOME/.config/base16-shell/"
    source "$BASE16_SHELL/profile_helper.fish"
end

base16-nord

direnv hook fish | source

# 
starship init fish | source
