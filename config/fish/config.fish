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

# load shell env
eval "$(/opt/homebrew/bin/brew shellenv)"

# asdf -- https://asdf-vm.com/guide/getting-started.html
if test -z $ASDF_DATA_DIR
    set _asdf_shims "$HOME/.asdf/shims"
else
    set _asdf_shims "$ASDF_DATA_DIR/shims"
end

# Do not use fish_add_path (added in Fish 3.2) because it
# potentially changes the order of items in PATH
if not contains $_asdf_shims $PATH
    set -gx --prepend PATH $_asdf_shims
end
set --erase _asdf_shims

direnv hook fish | source

starship init fish | source
