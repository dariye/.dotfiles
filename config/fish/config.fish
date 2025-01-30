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

eval "$(/opt/homebrew/bin/brew shellenv)"

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# pnpm
set -gx PNPM_HOME "/Users/$HOME/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# Base16 Shell
# git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
if status --is-interactive
    set BASE16_SHELL "$HOME/.config/base16-shell/"
    source "$BASE16_SHELL/profile_helper.fish"
    base16-nord
end

direnv hook fish | source

source /opt/homebrew/opt/asdf/libexec/asdf.fish

source "$HOME/workspace/pleo/scripts/bin/oo.fish"
